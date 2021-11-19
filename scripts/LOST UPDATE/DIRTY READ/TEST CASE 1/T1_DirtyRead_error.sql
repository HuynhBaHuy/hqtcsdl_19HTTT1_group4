--T1 doi tac cap nhat tinh trang don hang 
--T2 khach hang xem tinh trang don hang
--DROP PROC sp_dirtyread_tc1_T1
--DROP PROC sp_dirtyread_tc1_T2
go
use OnlineOrderingSystem
GO
CREATE PROCEDURE sp_dirtyread_tc1_T1 @madh nvarchar(20), @ttdh nvarchar(50)
AS
BEGIN TRAN 
	IF IS_ROLEMEMBER('doi_tac') = 0 AND IS_ROLEMEMBER('dbowner') = 0
		BEGIN
			ROLLBACK TRAN
		END
	ELSE
		IF EXISTS (SELECT * FROM DON_HANG WHERE MaDH = @madh)
			BEGIN
				SELECT TinhTrangDH FROM DON_HANG WHERE MaDH = @madh
				UPDATE DON_HANG SET TinhTrangDH = @ttdh WHERE MaDH = @madh
				-- Waiting for shipper
				Waitfor Delay '00:00:10'
			END
		-- Cancel shipping due to shipper. Rollback transaction
		ROLLBACK TRANSACTION

GO 
USE OnlineOrderingSystem
GRANT EXEC ON sp_dirtyread_tc1_T1
TO doi_tac

GO 
USE OnlineOrderingSystem
EXEC sp_dirtyread_tc1_T1 N'100', N'Da nhan hang'
