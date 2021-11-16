USE OnlineOrderingSystem


-- STORE PROCEDURE FOR DOI_TAC
-- cap nhat thoi gian hieu luc va phan tram hoa hong 
GO 
CREATE PROCEDURE spUpdateTimeContractTerm @mahd varchar(20), @tg_hlhd nvarchar(10), @pthh float
AS
BEGIN TRAN
	IF IS_ROLEMEMBER('doi_tac') = 0 AND IS_ROLEMEMBER('db_owner') = 0
		BEGIN 
			ROLLBACK TRAN
			PRINT('TRANSACTION IS ROLLBACKED')
		END
	ELSE 
	BEGIN
		IF NOT EXISTS(SELECT MAHD FROM HOP_DONG WHERE  MaHD = @mahd)
			BEGIN
				ROLLBACK TRAN
				PRINT('TRANSACTION IS ROLLBACKED')
			END 
		ELSE 
			BEGIN
				UPDATE HOP_DONG
				SET TG_HieuLucHD = @tg_hlhd, PhanTramHoaHong = @pthh
				where MaHD = @mahd
			END
		COMMIT TRAN
	END

-- grant exec cho doi_tac
GO 
use OnlineOrderingSystem
GRANT EXEC ON spUpdateTimeContractTerm 
TO doi_tac

EXEC spUpdateTimeContractTerm '085', '2025-02-12', '35'  

-- them thong tin san pham va chi nhanh cung cap san pham nay
GO
CREATE PROCEDURE spAddProduct @maSP varchar(20), @maCN varchar(20), @tensanpham nvarchar(50), @loai varchar(20), @gia float
AS
BEGIN TRAN 
	IF IS_ROLEMEMBER('doi_tac') = 0 OR IS_ROLEMEMBER('db_owner') = 0
		BEGIN
			IF EXISTS(SELECT * FROM SAN_PHAM WHERE MaSP = @maSP and MaCN = @maCN)  
				BEGIN
					ROLLBACK TRAN
					PRINT('TRANSACTION IS ROLLBACKED')
				END 
			ELSE 
				BEGIN
					INSERT SAN_PHAM(MaSP, MaCN, TenSanPham, Loai, Gia)
					VALUES (@maSP, @maCN, @tensanpham, @loai, @gia)
				END
			COMMIT TRAN
		END
	ELSE
		BEGIN
			ROLLBACK TRAN
			PRINT('TRANSACTION IS ROLLBACKED')
		END
-- grant exec cho doi_tac
GO 
USE OnlineOrderingSystem
GRANT EXEC ON spAddProduct 
TO doi_tac
EXEC spAddProduct N'103', N'136', N'Dầu', N'222', 20000
-- sua thong tin san pham va chi nhanh cung cap san pham nay
GO
CREATE PROCEDURE spUpdateProduct @maSP varchar(20), @maCN varchar(20), @tensanpham nvarchar(50), @loai varchar(20), @gia float
AS
BEGIN TRAN 
	IF IS_ROLEMEMBER('tai_xe') = 0 OR IS_ROLEMEMBER('db_owner') = 0
		BEGIN
			IF NOT EXISTS(SELECT * FROM SAN_PHAM WHERE MaSP = @maSP)  
				BEGIN
					ROLLBACK TRAN
					PRINT('TRANSACTION IS ROLLBACKED')
				END 
			ELSE 
				BEGIN 
					UPDATE SAN_PHAM
					SET MaCN = @maCN, TenSanPham = @tensanpham, Loai = @loai, Gia = @gia
					where MaSP = @maSP
				END
			COMMIT TRAN
		END
	ELSE
		BEGIN
			ROLLBACK TRAN
			PRINT('TRANSACTION IS ROLLBACKED')
		END
-- grant exec cho doi_tac
GO 
USE OnlineOrderingSystem
GRANT EXEC ON spUpdateProduct 
TO doi_tac
EXEC spUpdateProduct N'103', N'136', N'Tương ớt', N'222', 20000
-- xoa thong tin san pham va chi nhanh cung cap san pham nay
GO
CREATE PROCEDURE spDeleteProduct @maSP varchar(20), @maCN varchar(20), @tensanpham nvarchar(50), @loai varchar(20), @gia float
AS
BEGIN TRAN 
	IF IS_ROLEMEMBER('tai_xe') = 0 OR IS_ROLEMEMBER('db_owner') = 0
		BEGIN
			IF NOT EXISTS(SELECT * FROM SAN_PHAM WHERE MaSP = @maSP)  
				BEGIN
					ROLLBACK TRAN
					PRINT('TRANSACTION IS ROLLBACKED')
				END 
			ELSE 
				BEGIN 
					DELETE FROM SAN_PHAM
					WHERE MaSP = @maSP
				END
			COMMIT TRAN
		END
	ELSE
		BEGIN
			ROLLBACK TRAN
			PRINT('TRANSACTION IS ROLLBACKED')
		END
-- grant exec cho doi_tac
GO 
USE OnlineOrderingSystem
GRANT EXEC ON spDeleteProduct 
TO doi_tac

EXEC spDeleteProduct N'103', N'136', N'Tương ớt', N'222', 20000
-- xem thong tin don hang 
GO 
CREATE PROCEDURE spViewOrderInformation @madh varchar(20)
AS
BEGIN TRAN
	IF IS_ROLEMEMBER('doi_tac') = 0 AND IS_ROLEMEMBER('db_owner') = 0
		BEGIN
			ROLLBACK TRAN
			PRINT('TRANSACTION IS ROLLBACKED')
		END
	ELSE
		BEGIN
		IF NOT EXISTS (SELECT * FROM GIAO_HANG WHERE MaDH = @madh)
		OR NOT EXISTS (SELECT * FROM DON_HANG WHERE MaDH = @madh)
			BEGIN
				ROLLBACK TRAN
				PRINT('TRANSACTION IS ROLLBACKED')
			END
		ELSE
			BEGIN
				SELECT * FROM DON_HANG WHERE MaDH = @madh
			END
		COMMIT TRAN
		END
GO 
USE OnlineOrderingSystem
GRANT EXEC ON spViewOrderInformation 
to doi_tac
EXEC spViewOrderInformation N'175'
-- cap nhat tinh trang don hang 
GO 
CREATE PROCEDURE spUpdateOrderStatus @madh varchar(20), @ttdh nvarchar(50)
AS
BEGIN TRAN
	IF IS_ROLEMEMBER('doi_tac') = 0 AND IS_ROLEMEMBER('tai_xe') = 0 AND IS_ROLEMEMBER('db_owner') = 0
		BEGIN
			ROLLBACK TRAN
			PRINT('TRANSACTION IS ROLLBACKED')
		END
	ELSE
		BEGIN
		IF NOT EXISTS (SELECT * FROM DON_HANG WHERE MaDH = @madh)
			BEGIN
				ROLLBACK TRAN
				PRINT('TRANSACTION IS ROLLBACKED')
			END
		ELSE
			BEGIN
				UPDATE DON_HANG
				SET TinhTrangDH = @ttdh
				WHERE MaDH = @madh
			END
		COMMIT TRAN
		END


-- grant
GO 
USE OnlineOrderingSystem
GRANT EXEC ON spUpdateOrderStatus 
to doi_tac
EXEC spUpdateOrderStatus N'175', N'Dang Giao Hang'

-- STORE PROCEDURE FOR KHACH HANG 
-- xem danh sach doi tac
GO 
CREATE PROCEDURE spViewPartnerList
AS
BEGIN TRAN
	IF IS_ROLEMEMBER('khach_hang') = 0 AND IS_ROLEMEMBER('db_owner') = 0
		BEGIN 
			ROLLBACK TRAN
			PRINT('TRANSACTION IS ROLLBACKED')
		END
	ELSE 
	BEGIN
		IF NOT EXISTS (SELECT * FROM DOI_TAC)
		BEGIN
			ROLLBACK TRAN
			PRINT('TRANSACTION IS ROLLBACKED')
		END
		ELSE 
		BEGIN
			SELECT MaDT, TenDT, NguoiDaiDien, MaKV, MaLoai, DiaChiKD, SoDT, Email
			FROM DOI_TAC 
		END 
		COMMIT TRAN
	END
--DROP PROC spViewPartnerList
-- GRANT 
GO 
USE OnlineOrderingSystem
GRANT EXEC ON spViewPartnerList
TO khach_hang
EXEC spViewPartnerList

-- xem danh sach san pham cua doi tac
GO
CREATE PROCEDURE spViewProductListOfPartner @madt varchar(20)
AS
BEGIN TRAN 
	IF IS_ROLEMEMBER('khach_hang') = 0 AND IS_ROLEMEMBER('db_owner') = 0
	BEGIN
		ROLLBACK TRAN
		PRINT('TRANSACTION IS ROLLBACKED')
	END 
	ELSE
	BEGIN
		IF NOT EXISTS (SELECT * FROM DOI_TAC WHERE MaDT = @madt)
		BEGIN
			ROLLBACK TRAN
			PRINT('TRANSACTION IS ROLLBACKED')
		END
		ELSE 
		BEGIN
			SELECT sp.MaSP, sp.TenSanPham, sp.Gia, sp.Loai 
			FROM SAN_PHAM sp
			WHERE sp.MaCN in (SELECT cn.MACN FROM CHI_NHANH cn JOIN DOI_TAC dt ON cn.MADT = dt.MADT and dt.MaDT = @madt)
		END 
		COMMIT TRAN
	END

GO 
USE OnlineOrderingSystem
GRANT EXEC ON spViewProductListOfPartner
TO khach_hang
EXEC spViewProductListOfPartner N'210'
--DROP PROC spSelectOrderInformation
-- chon san pham, so luong tuong ung, hinh thuc thanh toan va dia chi giao hang
GO
CREATE PROCEDURE spSelectOrderInformation @makh varchar(20), @masp varchar(20), @soluong int, @ht_tt nvarchar(50), @tenduong nvarchar(50)
AS
BEGIN TRAN 
	IF IS_ROLEMEMBER('khach_hang') = 0 AND IS_ROLEMEMBER('db_owner') = 0
		BEGIN
			ROLLBACK TRAN
			PRINT('TRANSACTION IS ROLLBACKED')
		END 
	ELSE
		BEGIN
			IF NOT EXISTS (SELECT * FROM DON_HANG WHERE MaKH = @makh)
				BEGIN
					ROLLBACK TRAN
					PRINT('TRANSACTION IS ROLLBACKED')
				END
			ELSE 
				BEGIN
					SELECT dh.MaKH, ct.MaSP, ct.SoLuong, dh.HinhThuc_ThanhToan, dh.TenDuong, kv.Quan, kv.Tinh 
					FROM CT_DONHANG ct, DON_HANG dh, KHU_VUC kv 
					where ct.MaDH = dh.MaDH and dh.MaKV = kv.MaKV and dh.MaKH = @makh
				END 
			COMMIT TRAN
		END

GO 
USE OnlineOrderingSystem
GRANT EXEC ON spSelectOrderInformation
TO khach_hang
--EXEC spSelectOrderInformation N'718', 
-- xac nhan dong y, don hang se duoc chuyen den doi tac va tai xe
GO
CREATE PROCEDURE spShipOrderStatus @madh varchar(20), @ttdh nvarchar(50), @makh varchar(20)
AS
BEGIN TRAN 
	IF IS_ROLEMEMBER('khach_hang') = 0 AND IS_ROLEMEMBER('db_owner') = 0
		BEGIN
			ROLLBACK TRAN
			PRINT('TRANSACTION IS ROLLBACKED')
		END 
	ELSE
		BEGIN
			IF NOT EXISTS (SELECT * FROM DON_HANG WHERE MaDH = @madh)
				BEGIN
					ROLLBACK TRAN
					PRINT('TRANSACTION IS ROLLBACKED')
				END
			ELSE 
				BEGIN
					UPDATE DON_HANG
					SET TinhTrangDH = @ttdh
					WHERE MaKH = @makh
				END 
			COMMIT TRAN
		END

GO 
USE OnlineOrderingSystem
GRANT EXEC ON spShipOrderStatus
TO khach_hang

-- theo doi qua trinh van chuyen
GO
CREATE PROCEDURE spViewShippingProcess @madh varchar(20)
AS
BEGIN TRAN 
	IF IS_ROLEMEMBER('khach_hang') = 0 
	AND IS_ROLEMEMBER('db_owner') = 0
		BEGIN
			ROLLBACK TRAN
			PRINT('TRANSACTION IS ROLLBACKED')
		END 
	ELSE
		BEGIN
			IF NOT EXISTS (SELECT * FROM DON_HANG WHERE MaDH = @madh)
				BEGIN
					ROLLBACK TRAN
					PRINT('TRANSACTION IS ROLLBACKED')
				END
			ELSE 
				BEGIN
					SELECT TinhTrangDH
					FROM DON_HANG
					WHERE Madh = @madh 
				END 
			COMMIT TRAN
		END

GO 
USE OnlineOrderingSystem
GRANT EXEC ON spViewShippingProcess
TO khach_hang