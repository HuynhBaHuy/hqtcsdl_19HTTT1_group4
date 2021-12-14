-- Fix conversion deadlock
--Test case 1 => Fix
-- T1 - doi tac
GO
CREATE PROCEDURE sp_deadlock_tc1_T1_fixed @madt varchar(20), @madh varchar(20),@ttdh nvarchar(50)
AS
BEGIN TRAN 
	IF IS_ROLEMEMBER('doi_tac') = 0 AND IS_ROLEMEMBER('dbowner') = 0
		BEGIN
			ROLLBACK TRAN
		END
	ELSE
		BEGIN
			SET TRAN ISOLATION LEVEL SERIALIZABLE
			IF EXISTS (SELECT* FROM DON_HANG WITH (UPDLOCK) WHERE MaDT = @madt AND MaDH = @madh)
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
