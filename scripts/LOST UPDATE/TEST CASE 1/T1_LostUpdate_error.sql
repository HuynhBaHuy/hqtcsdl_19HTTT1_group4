--T1 nhan vien 1 cua doi tac cap nhat thoi gian hieu luc hop dong 
--T2 nhan vien 2 cua doi tac cap nhat thoi gian hieu luc hop dong 
go
use OnlineOrderingSystem
GO
CREATE PROCEDURE sp_lostupdate_tc1_T1 @mahd nvarchar(20), @tg_hlhd date
AS
BEGIN TRAN 
	IF IS_ROLEMEMBER('doi_tac') = 0 AND IS_ROLEMEMBER('dbowner') = 0
		BEGIN
			ROLLBACK TRAN
		END
	ELSE
		BEGIN
			IF EXISTS (SELECT * FROM HOP_DONG WHERE MaHD = @mahd)
				BEGIN
					SELECT TG_HieuLucHD FROM HOP_DONG WHERE MaHD = @mahd
					Waitfor Delay '0:0:10'
					UPDATE HOP_DONG SET TG_HieuLucHD = @tg_hlhd
					WHERE MaHD = @mahd
					COMMIT TRAN;
				END
			ELSE
				BEGIN
					ROLLBACK TRAN
				END
		END
--go
--use OnlineOrderingSystem
--GO
--CREATE PROCEDURE sp_lostupdate_tc1_T1 @masothue varchar(20), @mahd nvarchar(20), @madt nvarchar(20), @tghlhd date, @pthh float
--AS
--BEGIN TRAN 
--	IF IS_ROLEMEMBER('nhan_vien') = 0 AND IS_ROLEMEMBER('dbowner') = 0
--		BEGIN
--			ROLLBACK TRAN
--		END
--	ELSE
--		BEGIN
--			IF NOT EXISTS(SELECT h.MaDT FROM DOI_TAC d JOIN HOP_DONG h ON (d.MaDT = h.MaDT) WHERE d.MaSoThue = @masothue)
--				BEGIN
--					ROLLBACK TRAN
--					PRINT('TRANSACTION IS ROLLBACKED')
--				END 
--			ELSE
--				BEGIN
--							DECLARE @doanhsoban float
--							SET @doanhsoban = (SELECT SUM(d.TongPhiSP) FROM DON_HANG d WHERE d.MaDT = @madt)	
--							SELECT TG_HieuLucHD, PhanTramHoaHong FROM HOP_DONG WHERE MaDT = @madt and MaHD = @mahd
--							Waitfor Delay '0:0:10'
--							UPDATE HOP_DONG
--							SET TG_HieuLucHD = @tghlhd, PhanTramHoaHong = (@pthh * @doanhsoban) / 100
--							where MaDT = @madt
--							COMMIT TRAN;
--						END
--					END

--GO 
--USE OnlineOrderingSystem
--GRANT EXEC ON sp_lostupdate_tc1_T1
--TO nhan_vien

--DROP PROC sp_lostupdate_tc1_T1
--DROP PROC sp_lostupdate_tc1_T2
GO 
USE OnlineOrderingSystem
--EXEC sp_lostupdate_tc1_T1 '559','433', '813', '2028-05-06', 30000
EXEC sp_lostupdate_tc1_T1 '433', '2028-05-06'


 