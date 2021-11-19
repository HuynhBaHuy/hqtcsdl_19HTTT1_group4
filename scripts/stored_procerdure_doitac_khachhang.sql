USE OnlineOrderingSystem


-- STORE PROCEDURE FOR DOI_TAC
-- cap nhat thoi gian hieu luc va phan tram hoa hong 
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
			IF NOT EXISTS(SELECT h.MaDT FROM DOI_TAC d JOIN HOP_DONG h ON (d.MaDT = h.MaHD) WHERE d.MaSoThue = @masothue)
				BEGIN
					ROLLBACK TRAN
					PRINT('TRANSACTION IS ROLLBACKED')
				END 
			ELSE
				BEGIN
					DECLARE @madt varchar(20)
					DECLARE @doanhsoban float

					SET @madt = (SELECT h.MaDT FROM DOI_TAC d JOIN HOP_DONG h ON (d.MaDT = h.MaHD) WHERE d.MaSoThue = @masothue)
				
					-- Check if the input effective time is valid
					IF(@tg_hlhd < (SELECT h.TG_HieuLucHD FROM HOP_DONG h WHERE h.MaDT = @madt))
						BEGIN
							ROLLBACK TRAN
							PRINT('TRANSACTION IS ROLLBACKED')
						END
					ELSE
						BEGIN
							SET @doanhsoban = (SELECT SUM(d.TongPhiSP) FROM DON_HANG d WHERE d.MaDT = @madt)
				
							UPDATE HOP_DONG
							SET TG_HieuLucHD = @tg_hlhd, PhanTramHoaHong = (@pthh * @doanhsoban) / 100
							where MaDT = @madt

							COMMIT TRAN
						END
				END
		END

-- grant exec cho doi_tac
GO 
use OnlineOrderingSystem
GRANT EXEC ON spUpdateTimeContractTerm 
TO doi_tac

--EXEC spUpdateTimeContractTerm '022', '2025-02-12', '35'  

-- them thong tin san pham va chi nhanh cung cap san pham nay
GO
CREATE PROCEDURE spAddProduct @maSP varchar(20), @maCN varchar(20), @tensanpham nvarchar(50), @loai varchar(20), @gia float
AS
BEGIN TRAN 
	IF IS_ROLEMEMBER('doi_tac') = 0 AND IS_ROLEMEMBER('db_owner') = 0
		BEGIN 
			ROLLBACK TRAN
			PRINT('TRANSACTION IS ROLLBACKED')
		END
	ELSE 
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
-- grant exec cho doi_tac
GO 
USE OnlineOrderingSystem
GRANT EXEC ON spAddProduct 
TO doi_tac
--EXEC spAddProduct N'104', N'136', N'Dầu', N'222', 20000
-- sua thong tin san pham va chi nhanh cung cap san pham nay
GO
CREATE PROCEDURE spUpdateProduct @maSP varchar(20), @maCN varchar(20), @tensanpham nvarchar(50), @loai varchar(20), @gia float
AS
BEGIN TRAN 
	IF IS_ROLEMEMBER('doi_tac') = 0 AND IS_ROLEMEMBER('db_owner') = 0
		BEGIN 
			ROLLBACK TRAN
			PRINT('TRANSACTION IS ROLLBACKED')
		END
	ELSE
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
	
-- grant exec cho doi_tac
GO 
USE OnlineOrderingSystem
GRANT EXEC ON spUpdateProduct 
TO doi_tac
--EXEC spUpdateProduct N'000', N'136', N'Tương ớt', N'222', 20000
-- xoa thong tin san pham va chi nhanh cung cap san pham nay
GO
CREATE PROCEDURE spDeleteProduct @maSP varchar(20), @maCN varchar(20), @tensanpham nvarchar(50), @loai varchar(20), @gia float
AS
BEGIN TRAN 
	IF IS_ROLEMEMBER('doi_tac') = 0 AND IS_ROLEMEMBER('db_owner') = 0
		BEGIN 
			ROLLBACK TRAN
			PRINT('TRANSACTION IS ROLLBACKED')
		END
	ELSE
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
	
-- grant exec cho doi_tac
GO 
USE OnlineOrderingSystem
GRANT EXEC ON spDeleteProduct 
TO doi_tac

--EXEC spDeleteProduct N'000', N'136', N'Tương ớt', N'222', 20000
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
		IF NOT EXISTS (SELECT * FROM DON_HANG WHERE MaDH = @madh)
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
--EXEC spViewOrderInformation N'000'
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
--EXEC spUpdateOrderStatus N'000', N'Dang Giao Hang'

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
--EXEC spViewPartnerList

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
--EXEC spViewProductListOfPartner N'000'
--DROP PROC spSelectOrderInformation spSelectOrderInformation
-- chon san pham, so luong tuong ung, hinh thuc thanh toan va dia chi giao hang
CREATE PROCEDURE spSelectOrderInformation @masp nvarchar(20), @soluong int, @ht_tt nvarchar(50), @tenduong nvarchar(50), @makv nvarchar(20)
AS
BEGIN TRAN 
	IF IS_ROLEMEMBER('khach_hang') = 0 AND IS_ROLEMEMBER('db_owner') = 0
		BEGIN
			ROLLBACK TRAN
			PRINT('TRANSACTION IS ROLLBACKED')
		END 
	ELSE
		IF NOT EXISTS (SELECT * FROM SAN_PHAM WHERE MaSP = @masp)
			BEGIN
			ROLLBACK TRAN
			PRINT('TRANSACTION IS ROLLBACKED')
		END
		ELSE
			BEGIN
				select @masp as MaSP, @soluong as SoLuong, @ht_tt as HinhThucThanhToan, @tenduong as TenDuong, @makv as MaKhuVuc
			END
	COMMIT TRAN
GO 
USE OnlineOrderingSystem
GRANT EXEC ON spSelectOrderInformation
TO khach_hang
--EXEC spSelectOrderInformation N'000', 5, N'PayPal', N'Nguyễn Chí Thanh', N'586'
-- xac nhan dong y, don hang se duoc chuyen den doi tac va tai xe (tao don hang)
GO
CREATE PROCEDURE spCreateOrder @madh nvarchar(20), @madt nvarchar(20), @makh nvarchar(20), @ht_tt nvarchar(50), @tenduong nvarchar(50), @makv nvarchar(20), @masp nvarchar(20), @soluong int
AS
BEGIN TRAN 
	IF IS_ROLEMEMBER('khach_hang') = 0 AND IS_ROLEMEMBER('db_owner') = 0
		BEGIN
			ROLLBACK TRAN
			PRINT('TRANSACTION IS ROLLBACKED')
		END 
	ELSE
		BEGIN
			IF EXISTS (SELECT * FROM DON_HANG where MaDH = @madh)
				BEGIN
					ROLLBACK TRAN
					PRINT('TRANSACTION IS ROLLBACKED')
				END
			ELSE
				BEGIN
					INSERT DON_HANG
					VALUES (@madh, @madt, @makh, @ht_tt, @tenduong, @makv, 0, 0, null)
					INSERT CT_DONHANG
					VALUES (@madh, @masp, @soluong)
					UPDATE DON_HANG
					SET TongPhiSP = (SELECT SUM(ct.SoLuong*sp.Gia) FROM SAN_PHAM sp JOIN CT_DONHANG ct ON ct.MaDH = @madh and sp.MaSP = ct.MaSP group by ct.MaDH) where MaDH = @madh
				END
			COMMIT TRAN
		END
GO 
USE OnlineOrderingSystem
GRANT EXEC ON spCreateOrder
TO khach_hang
DROP PROC spCreateOrder
EXEC spCreateOrder N'100', N'007', N'001', N'PayPal', N'Nguyễn Chí Thanh', N'586', N'026', 1
-- cap nhap don hang
GO
CREATE PROCEDURE spUpdateOrder @madh nvarchar(20), @madt nvarchar(20), @makh nvarchar(20), @ht_tt nvarchar(50), @tenduong nvarchar(50), @makv nvarchar(20), @masp nvarchar(20), @soluong int
AS
BEGIN TRAN 
	IF IS_ROLEMEMBER('khach_hang') = 0 AND IS_ROLEMEMBER('db_owner') = 0
		BEGIN
			ROLLBACK TRAN
			PRINT('TRANSACTION IS ROLLBACKED')
		END 
	ELSE
		BEGIN
			IF NOT EXISTS (SELECT * FROM DON_HANG where MaDH = @madh)
				BEGIN
					ROLLBACK TRAN
					PRINT('TRANSACTION IS ROLLBACKED')
				END
			ELSE 
				IF EXISTS (SELECT * FROM CT_DONHANG WHERE Madh = @madh AND MaSP = @masp)
					BEGIN
						UPDATE CT_DONHANG
						SET SoLuong = @soluong
						WHERE MaDH = @madh And MaSP = @masp
						UPDATE DON_HANG
						SET  HinhThuc_ThanhToan = @ht_tt, TenDuong = @tenduong, MaKV = @makv
						WHERE MaDH = @madh
						UPDATE DON_HANG
						SET TongPhiSP = (SELECT SUM(ct.SoLuong*sp.Gia) FROM SAN_PHAM sp JOIN CT_DONHANG ct ON ct.MaDH = @madh and sp.MaSP = ct.MaSP group by ct.MaDH) where MaDH = @madh
					END
				IF NOT EXISTS (SELECT * FROM CT_DONHANG WHERE Madh = @madh AND MaSP = @masp)
					BEGIN
						INSERT CT_DONHANG
						VALUES (@madh, @masp, @soluong)
						UPDATE DON_HANG
						SET TongPhiSP = (SELECT SUM(ct.SoLuong*sp.Gia) FROM SAN_PHAM sp JOIN CT_DONHANG ct ON ct.MaDH = @madh and sp.MaSP = ct.MaSP group by ct.MaDH) where MaDH = @madh
					END
		COMMIT TRAN
	END
GO 
USE OnlineOrderingSystem
GRANT EXEC ON spUpdateOrder
TO khach_hang
DROP PROC spUpdateOrder
EXEC spUpdateOrder N'100', N'007', N'001', N'PayPal', N'Nguyễn Chí Thanh', N'586', N'146', 1

-- theo doi qua trinh van chuyen
GO
CREATE PROCEDURE spViewShippingProcess @madh varchar(20)
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
--EXEC spViewShippingProcess N'000'
