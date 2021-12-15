--T1 nhan vien 1 cap nhat thoi gian hieu luc hop dong cua doi tac
--T2 nhan vien 2 cap nhat thoi gian hieu luc hop dong cua doi tac
-- T2
go
use OnlineOrderingSystem

GO
CREATE PROCEDURE sp_lostupdate_tc1_T2_error @masothue varchar(20), @mahd varchar(20), @madt varchar(20), @tghlhd date, @pthh float
AS
BEGIN TRAN 
	IF IS_ROLEMEMBER('nhan_vien') = 0 AND IS_ROLEMEMBER('dbowner') = 0
		BEGIN
			ROLLBACK TRAN
		END
	ELSE
		BEGIN
			IF NOT EXISTS(SELECT h.MaDT FROM DOI_TAC d JOIN HOP_DONG h ON (d.MaDT = h.MaDT) WHERE d.MaSoThue = @masothue)
				BEGIN
					ROLLBACK TRAN
					PRINT('TRANSACTION IS ROLLBACKED')
				END 
			ELSE
				BEGIN
					-- Check if the input effective time is valid
					IF(@tghlhd < (SELECT h.TG_HieuLucHD FROM HOP_DONG h WHERE h.MaDT = @madt))
						BEGIN
							ROLLBACK TRAN
							PRINT('TRANSACTION IS ROLLBACKED')
						END
					ELSE
						BEGIN
							DECLARE @doanhsoban float
							SET @doanhsoban = (SELECT SUM(d.TongPhiSP) FROM DON_HANG d WHERE d.MaDT = @madt)	
							SELECT TG_HieuLucHD, PhanTramHoaHong FROM HOP_DONG WHERE MaDT = @madt and MaHD = @mahd
							UPDATE HOP_DONG
							SET TG_HieuLucHD = @tghlhd, PhanTramHoaHong = (@pthh * @doanhsoban) / 100
							where MaDT = @madt
							COMMIT TRAN;
						END
					END
				END
