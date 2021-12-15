--T1 nhan vien xem danh sach hop dong
--T2 doi tac cap nhat hop dong 

go
use OnlineOrderingSystem
GO
CREATE PROCEDURE sp_dirtyread_tc2_T2_error @mahd varchar(20), @madt varchar(20), @tghlhd date
AS
BEGIN TRAN 
	IF IS_ROLEMEMBER('doi_tac') = 0 AND IS_ROLEMEMBER('dbowner') = 0
		BEGIN
			ROLLBACK TRAN
		END
	ELSE
		IF EXISTS (SELECT * FROM HOP_DONG WHERE MaDT = @madt and MaHD = @mahd)
			BEGIN
				 SELECT TG_HieuLucHD FROM HOP_DONG WHERE MaDT = @madt and MaHD = @mahd    
				 UPDATE HOP_DONG SET TG_HieuLucHD = @tghlhd WHERE MaDT = @madt and MaHD = @mahd
				-- Waiting for updating
				Waitfor Delay '00:00:10'
			END
		-- Cancel update due to lost network. Rollback transaction
		ROLLBACK TRANSACTION

