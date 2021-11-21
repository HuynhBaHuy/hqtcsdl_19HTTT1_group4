USE OnlineOrderingSystem
GO 
CREATE PROCEDURE spUpdateTimeContractTerm @masothue varchar(20), @tg_hlhd date, @pthh float
AS
BEGIN TRAN
	IF IS_ROLEMEMBER('doi_tac') = 0 AND IS_ROLEMEMBER('db_owner') = 0
		BEGIN 
			ROLLBACK TRAN
			PRINT('TRANSACTION IS ROLLBACKED')
		END
	ELSE 
		BEGIN
			IF NOT EXISTS(SELECT h.TG_HieuLucHD FROM DOI_TAC d JOIN HOP_DONG h ON (d.MaDT = h.MaHD) WHERE d.MaSoThue = @masothue)
				BEGIN
					ROLLBACK TRAN
					PRINT('TRANSACTION IS ROLLBACKED')
				END 
			ELSE
				BEGIN
					DECLARE @doanhsoban float

					-- Check if the input effective time is valid
					IF(@tg_hlhd < (SELECT h.TG_HieuLucHD FROM DOI_TAC d JOIN HOP_DONG h ON (d.MaDT = h.MaHD) WHERE d.MaSoThue = @masothue))
						BEGIN
							ROLLBACK TRAN
							PRINT('TRANSACTION IS ROLLBACKED')
						END
					ELSE
						BEGIN
							SET @doanhsoban = (SELECT SUM(dh.TongPhiSP) FROM DON_HANG dh JOIN DOI_TAC dt ON (dh.MaDT = dt.MaDT) WHERE dt.MaSoThue = @masothue)
				
							UPDATE HOP_DONG
							SET TG_HieuLucHD = @tg_hlhd, PhanTramHoaHong = (@pthh * @doanhsoban) / 100
							where MaDT IN (SELECT MaDT FROM DOI_TAC WHERE MaSoThue = @masothue)

							COMMIT TRAN
						END
				END
		END

exec spUpdateTimeContractTerm