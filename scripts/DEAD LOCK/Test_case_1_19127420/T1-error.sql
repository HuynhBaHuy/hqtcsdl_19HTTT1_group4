--Conversion deadlock
--Test case 1
-- T1 - doi tac
GO
CREATE PROCEDURE sp_deadlock_tc1_T1_error @madt varchar(20), @madh varchar(20),@ttdh nvarchar(50)
AS
BEGIN TRAN 
	IF IS_ROLEMEMBER('doi_tac') = 0 AND IS_ROLEMEMBER('dbowner') = 0
		BEGIN
			ROLLBACK TRAN
		END
	ELSE
		BEGIN
			IF EXISTS (SELECT* FROM DON_HANG WITH (HOLDLOCK) WHERE MaDT = @madt AND MaDH = @madh)
				BEGIN
					Waitfor Delay '0:0:10';
					UPDATE DON_HANG WITH (XLOCK)
					SET TinhTrangDH = @ttdh
					WHERE MaDH = @madh
					COMMIT TRAN;
				END
			ELSE
				BEGIN
					ROLLBACK TRAN
				END
		END