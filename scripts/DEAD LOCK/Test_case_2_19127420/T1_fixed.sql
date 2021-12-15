--Fix cycle deadlock
--Test case 2 ==> Fix
-- T1 - Tai Xe
GO
CREATE PROCEDURE sp_deadlock_tc2_T1_fixed @madh varchar(20), @matx varchar(20),@ttdh nvarchar(50)
AS
BEGIN TRAN 
	IF IS_ROLEMEMBER('tai_xe') = 0 AND IS_ROLEMEMBER('dbowner') = 0
		BEGIN
			ROLLBACK TRAN
		END
	ELSE
		BEGIN
			IF NOT EXISTS(SELECT MaDH FROM DON_HANG WHERE MaDH = @madh) 
			OR EXISTS (SELECT MaDH FROM GIAO_HANG WHERE MaDH = @madh AND MaTX = @matx) 
			OR NOT EXISTS (SELECT MaTX FROM TAI_XE WHERE MaTX = @matx)
				BEGIN
					ROLLBACK TRAN
				END
			ELSE
			BEGIN
				Waitfor Delay '0:0:10'
				INSERT INTO GIAO_HANG WITH (XLOCK)
				VALUES(@matx,@madh,NULL)
				
				UPDATE DON_HANG WITH (XLOCK)
				SET TinhTrangDH = @ttdh
				WHERE MaDH = @madh
				COMMIT TRAN
			END
		END
