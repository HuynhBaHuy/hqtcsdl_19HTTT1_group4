--T1 nhan vien xem danh sach hop dong
--T2 doi tac cap nhat hop dong 
-- DROP PROC sp_dirtyread_tc2_T2
-- DROP PROC sp_dirtyread_tc2_T1
go
use OnlineOrderingSystem
GO
CREATE PROCEDURE sp_dirtyread_tc2_T2 @mahd nvarchar(20), @madt nvarchar(20), @tghlhd date
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

GO 
USE OnlineOrderingSystem
GRANT EXEC ON sp_dirtyread_tc2_T2
TO doi_tac

--GO 
--USE OnlineOrderingSystem
--EXEC sp_dirtyread_tc2_T2 N'085', N'057', '2026-05-06'
