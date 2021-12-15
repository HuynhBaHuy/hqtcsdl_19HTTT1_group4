--T1 doi tac xem danh sach hop dong
--T2 nhan vien cap nhat hop dong 

go
use OnlineOrderingSystem
GO
CREATE PROCEDURE sp_dirtyread_tc2_T2_fixed @masothue varchar(20), @mahd varchar(20), @madt varchar(20), @tghlhd date, @pthh float
AS
BEGIN TRAN 
	IF IS_ROLEMEMBER('nhan_vien') = 0 AND IS_ROLEMEMBER('dbowner') = 0
		BEGIN
			ROLLBACK TRAN
		END
	ELSE
			IF NOT EXISTS(SELECT h.MaDT FROM DOI_TAC d JOIN HOP_DONG h ON (d.MaDT = h.MaDT) WHERE d.MaSoThue = @masothue)
				BEGIN
					ROLLBACK TRAN
					PRINT('TRANSACTION IS ROLLBACKED')
				END 
			ELSE
				BEGIN
					DECLARE @doanhsoban float
					-- Check if the input effective time is valid
					IF(@tghlhd < (SELECT h.TG_HieuLucHD FROM HOP_DONG h WHERE h.MaDT = @madt))
						BEGIN
							ROLLBACK TRAN
							PRINT('TRANSACTION IS ROLLBACKED')
						END
					ELSE
						BEGIN	
							SELECT TG_HieuLucHD, PhanTramHoaHong FROM HOP_DONG WHERE MaDT = @madt and MaHD = @mahd
							SET @doanhsoban = (SELECT SUM(d.TongPhiSP) FROM DON_HANG d WHERE d.MaDT = @madt)
							UPDATE HOP_DONG
							SET TG_HieuLucHD = @tghlhd, PhanTramHoaHong = (@pthh * @doanhsoban) / 100
							where MaDT = @madt
							-- Waiting for updating
							Waitfor Delay '00:00:10'
						END
						-- Cancel update due to lost network. Rollback transaction
						ROLLBACK TRANSACTION
				END