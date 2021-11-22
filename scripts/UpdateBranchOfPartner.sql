GO 
USE OnlineOrderingSystem
-- sua thong tin chi nhanh
GO
CREATE PROCEDURE spUpdateBranch @madt varchar(20), @masp varchar(20), @maCN varchar(20), @makv varchar(20), @diachict nvarchar(50)
AS
BEGIN TRAN 
	IF IS_ROLEMEMBER('doi_tac') = 0 AND IS_ROLEMEMBER('db_owner') = 0
		BEGIN 
			ROLLBACK TRAN
			PRINT('TRANSACTION IS ROLLBACKED')
		END
	ELSE
		BEGIN
			IF NOT EXISTS(SELECT * FROM CHI_NHANH cn JOIN SAN_PHAM sp on cn.MaCN = @macn AND sp.MaSP = @masp AND cn.MaCN = sp.MaCN) 
			OR NOT EXISTS(SELECT * FROM KHU_VUC where MaKV = @makv)  
				BEGIN
					ROLLBACK TRAN
					PRINT('TRANSACTION IS ROLLBACKED')
				END 
			ELSE
				IF (SELECT SoChiNhanh FROM DOI_TAC where MaDT = @madt) = (SELECT SoCNDangKy FROM HOP_DONG where MaDT = @madt)
					BEGIN   
						UPDATE CHI_NHANH
						SET MaKV = @makv, DiaChiCuThe = @diachict
						where MaDT = @madt and MaCN = @macn
					END
				ELSE
					BEGIN
						ROLLBACK TRAN
						PRINT('TRANSACTION IS ROLLBACKED')
					END 
			COMMIT TRAN
		END
GO 
USE OnlineOrderingSystem
EXEC spUpdateBranch '210', '146', '717', '084', N'HN' 
--DROP PROC  spUpdateBranch
-- xoa thong tin san pham va chi nhanh cung cap san pham nay
--GO
--CREATE PROCEDURE spDeleteBranch @madt varchar(20), @maSP varchar(20), @maCN varchar(20)
--AS
--BEGIN TRAN 
--	IF IS_ROLEMEMBER('doi_tac') = 0 AND IS_ROLEMEMBER('db_owner') = 0
--		BEGIN 
--			ROLLBACK TRAN
--			PRINT('TRANSACTION IS ROLLBACKED')
--		END
--	ELSE
--		BEGIN
--			IF NOT EXISTS(SELECT * FROM CHI_NHANH cn JOIN SAN_PHAM sp ON cn.MaDT = @madt and cn.MaCN = sp.MaCN and cn.MaCN = @macn)
--				BEGIN
--					ROLLBACK TRAN
--					PRINT('TRANSACTION IS ROLLBACKED')
--				END 
--			ELSE 
--				IF (SELECT SoChiNhanh FROM DOI_TAC where MaDT = @madt) = (SELECT SoCNDangKy FROM HOP_DONG where MaDT = @madt)
--					BEGIN 
--						DELETE CHI_NHANH WHERE MaCN = @macn and MaDT = @madt
--						DELETE CT_HOPDONG WHERE MaCN = @macn
--						UPDATE DOI_TAC
--						SET SoChiNhanh = SoChiNhanh - 1
--						WHERE MaDT = @madt
--						UPDATE HOP_DONG
--						SET SoCNDangKy = SoCNDangKy - 1
--						WHERE MaDT = @madt

--					END
--				ELSE
--					BEGIN
--						ROLLBACK TRAN
--						PRINT('TRANSACTION IS ROLLBACKED')
--					END 
--			COMMIT TRAN
--		END
--GO 
--USE OnlineOrderingSystem
--EXEC spDeleteBranch '210', '146', '717'
--DROP PROC  spDeleteBranch