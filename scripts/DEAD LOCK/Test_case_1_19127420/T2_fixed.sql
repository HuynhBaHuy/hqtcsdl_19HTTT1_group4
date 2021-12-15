
-- Fix conversion deadlock
--Test case 1 => Fix
-- T2 - Tai Xe
USE OnlineOrderingSystem
GO
CREATE PROCEDURE sp_deadlock_tc1_T2_fixed @madh varchar(20),@ttdh nvarchar(50)
AS
BEGIN TRAN 
	IF IS_ROLEMEMBER('tai_xe') = 0 AND IS_ROLEMEMBER('dbowner') = 0
		BEGIN
			ROLLBACK TRAN
		END
	ELSE
		BEGIN
			SET TRAN ISOLATION LEVEL SERIALIZABLE
			SELECT TenDuong FROM DON_HANG WITH (UPDLOCK) WHERE MaDH = @madh
			UPDATE DON_HANG WITH (XLOCK)
			SET TinhTrangDH = @ttdh
			WHERE MaDH = @madh
			COMMIT TRAN
		END

