
-- Fix conversion deadlock
--Test case 1 => Fix
-- T2 - Tai Xe
USE OnlineOrderingSystem
GO
ALTER PROCEDURE sp_deadlock_tc1_T2_fixed @madh varchar(20),@ttdh nvarchar(50), @matx varchar(20)
AS
BEGIN TRAN 
	IF IS_ROLEMEMBER('tai_xe') = 0 AND IS_ROLEMEMBER('dbowner') = 0
		BEGIN
			ROLLBACK TRAN
		END
	ELSE
		BEGIN
			IF EXISTS (SELECT* FROM GIAO_HANG WHERE MaDH = @madh AND MaTX = @matx)
				BEGIN
					ROLLBACK TRAN
				END
			ELSE
				BEGIN
					SELECT TenDuong FROM DON_HANG WITH (UPDLOCK) WHERE MaDH = @madh
					UPDATE DON_HANG WITH (XLOCK)
					SET TinhTrangDH = @ttdh
					WHERE MaDH = @madh
					INSERT INTO GIAO_HANG
					VALUES (@matx,@madh,NULL)
					COMMIT TRAN	
				END
		END
