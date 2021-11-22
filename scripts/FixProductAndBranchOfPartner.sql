GO 
USE OnlineOrderingSystem
-- sua thong tin san pham va chi nhanh cung cap san pham nay
GO
CREATE PROCEDURE spUpdateProductAndBranch @madt varchar(20), @maSP varchar(20), @maCN varchar(20), @makv varchar(20), @diachict nvarchar(50), @tensanpham nvarchar(50), @loai varchar(20), @gia float
AS
BEGIN TRAN 
	IF IS_ROLEMEMBER('doi_tac') = 0 AND IS_ROLEMEMBER('db_owner') = 0
		BEGIN 
			ROLLBACK TRAN
			PRINT('TRANSACTION IS ROLLBACKED')
		END
	ELSE
		BEGIN
			IF NOT EXISTS(SELECT * FROM SAN_PHAM WHERE MaSP = @maSP) AND EXISTS(SELECT * FROM CHI_NHANH cn JOIN SAN_PHAM sp ON cn.MaDT = @madt and cn.MaCN = sp.MaCN and cn.MaCN = @macn)  
				BEGIN
					ROLLBACK TRAN
					PRINT('TRANSACTION IS ROLLBACKED')
				END 
			ELSE
				IF (SELECT SoChiNhanh FROM DOI_TAC where MaDT = @madt) = (SELECT SoCNDangKy FROM HOP_DONG where MaDT = @madt)
					BEGIN   
						UPDATE SAN_PHAM
						SET MaCN = @maCN, TenSanPham = @tensanpham, Loai = @loai, Gia = @gia
						where MaSP = @maSP and MaCN = @maCN
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

-- xoa thong tin san pham va chi nhanh cung cap san pham nay
GO
CREATE PROCEDURE spDeleteProductAndBranch @madt varchar(20), @maSP varchar(20), @maCN varchar(20), @tensanpham nvarchar(50), @loai varchar(20), @gia float
AS
BEGIN TRAN 
	IF IS_ROLEMEMBER('doi_tac') = 0 AND IS_ROLEMEMBER('db_owner') = 0
		BEGIN 
			ROLLBACK TRAN
			PRINT('TRANSACTION IS ROLLBACKED')
		END
	ELSE
		BEGIN
			IF NOT EXISTS(SELECT * FROM SAN_PHAM WHERE MaSP = @maSP) AND EXISTS(SELECT * FROM CHI_NHANH cn JOIN SAN_PHAM sp ON cn.MaDT = @madt and cn.MaCN = sp.MaCN and cn.MaCN = @macn)
				BEGIN
					ROLLBACK TRAN
					PRINT('TRANSACTION IS ROLLBACKED')
				END 
			ELSE 
				IF (SELECT SoChiNhanh FROM DOI_TAC where MaDT = @madt) = (SELECT SoCNDangKy FROM HOP_DONG where MaDT = @madt)
					BEGIN 
						DELETE FROM SAN_PHAM
						WHERE MaSP = @maSP and MaCN = @macn
						DELETE CHI_NHANH WHERE MaCN = @macn and MaDT = @madt
						UPDATE DOI_TAC
						SET SoChiNhanh = SoChiNhanh - 1
						WHERE MaDT = @madt
						UPDATE HOP_DONG
						SET SoCNDangKy = SoCNDangKy - 1
						WHERE MaDT = @madt
					END
				ELSE
					BEGIN
						ROLLBACK TRAN
						PRINT('TRANSACTION IS ROLLBACKED')
					END 
			COMMIT TRAN
		END