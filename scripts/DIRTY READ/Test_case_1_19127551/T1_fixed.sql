--T1 doi tac cap nhat tinh trang don hang 
--T2 khach hang xem tinh trang don hang
go
use OnlineOrderingSystem
GO
CREATE PROCEDURE sp_dirtyread_T1_fixed @madh nvarchar(20), @ttdh nvarchar(50)
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
				-- Waiting for system's update
				Waitfor Delay '00:00:10'
			END
		-- Cancel update due to lost network. Rollback transaction
		ROLLBACK TRANSACTION

--go
--drop proc sp_dirtyread_T1_fixed 
--exec sp_dirtyread_tc1_T1 '005', N'Da nhan hang'
