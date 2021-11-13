-- Các quyền của đối tác:
--		select, insert, update, delete on table SAN_PHAM, CHI_NHANH
--		select on table KHU_VUC
--		select on table LOAI_HANG
--		select on table DOI_TAC (MaDT, TenDT)
--		select on table DON_HANG
--		update TTDH on table DON_HANG
--		select on CT_HOPDONG
--		select on HOP_DONG

-- add login_doitac account
USE OnlineOrderingSystem
GO
EXEC sp_addLogin 'login_doitac','login_doitac'

-- add user_doitac for login_doitac account
CREATE USER user_doitac FOR LOGIN  login_doitac

-- add role doi_tac
EXEC sp_addrole 'doi_tac'

EXEC sp_addrolemember 'doi_tac',user_doitac 

-- select, insert, delete, update on table SAN_PHAM, CHI_NHANH
GRANT SELECT, INSERT, DELETE, UPDATE 
ON OBJECT::SAN_PHAM 
TO doi_tac

GRANT SELECT, INSERT, DELETE, UPDATE 
ON OBJECT::CHI_NHANH 
TO doi_tac

-- SELECT ON KHU_VUC
GRANT SELECT
ON OBJECT::KHU_VUC
TO doi_tac

-- SELECT ON LOAI_HANG
GRANT SELECT
ON OBJECT::LOAI_HANG
TO doi_tac

-- SELECT ON DOI_TAC (MaDT, TenDT)
GRANT SELECT
ON OBJECT::DOI_TAC(MaDT, TenDT)
TO doi_tac

-- SELECT ON DON_HANG
GRANT SELECT
ON OBJECT::DON_HANG
to doi_tac

-- UPDATE TTDH ON DON_HANG
GRANT UPDATE
ON OBJECT::DON_HANG(TinhTrangDH)
TO doi_tac

-- SELECT ON HOP_DONG
GRANT SELECT
ON OBJECT::HOP_DONG
TO doi_tac

-- SELECT ON CT_HOPDONG
GRANT SELECT
ON OBJECT::CT_HOPDONG
TO doi_tac

-- Các quyền của khách hàng:
--		select MaDT, TenDT, NguoiDaiDien, MaKV, MaLoai, DiaChiKD, SoDT, Email on DOI_TAC
--		select on DON_HANG
--		select on CT_DONHANG
--		select on KHU_VUC
--		select on KHACH_HANG(MaKH, TenKH)
--		select on SAN_PHAM(MaSP, TenSanPham, Gia,Loai)
--		select on LOAI_HANG
-- add login_khachhang account
USE OnlineOrderingSystem
GO
EXEC sp_addLogin 'login_khachhang','login_khachhang'

-- add user_khachhang for login_khachhang account
CREATE USER user_khachhang FOR LOGIN  login_khachhang

-- add role customer
EXEC sp_addrole 'khach_hang'

EXEC sp_addrolemember 'khach_hang',user_khachhang 

--	select MaDT, TenDT, NguoiDaiDien, MaKV, MaLoai, DiaChiKD, SoDT, Email on DOI_TAC
GRANT SELECT
ON OBJECT::DOI_TAC(MaDT, TenDT, NguoiDaiDien, MaKV, MaLoai, DiaChiKD, SoDT, Email)
TO khach_hang

-- SELECT ON DON HANG
GRANT SELECT
ON OBJECT::DON_HANG
to khach_hang

-- SELECT ON CT_DONHANG
GRANT SELECT 
ON OBJECT::CT_DONHANG
to khach_hang

-- SELECT ON KHU_VUC
GRANT SELECT
ON OBJECT::KHU_VUC
TO khach_hang

-- SELECT ON KHACH_HANG(MaKH, TenKH)
GRANT SELECT
ON OBJECT::KHACH_HANG(MaKH, TenKH)
TO khach_hang

--SELECT ON SAN_PHAM(MaSP, TenSanPham, Gia,Loai)
GRANT SELECT 
ON OBJECT::SAN_PHAM(MaSP,TenSanPham,Loai,Gia)
TO khach_hang

--SELECT ON LOAI_HANG
GRANT SELECT 
ON OBJECT::LOAI_HANG
TO khach_hang

-- Dưới đây là các quyền của tài xế:
-- Driver permission: 
--		select on  TAI_XE
--		select on DON_HANG
--		select on KhuVuc
--		select, insert on GIAO_HANG
--		update TTDH on DON_HANG
--		select on KHACH_HANG (MaKH, TenKH)



-- add login_taixe account
USE OnlineOrderingSystem
GO
EXEC sp_addLogin 'login_taixe','login_taixe'

-- add user_taixe for login_taixe account
CREATE USER user_taixe FOR LOGIN  login_taixe

-- add role tai_xe
EXEC sp_addrole 'tai_xe'

EXEC sp_addrolemember 'tai_xe',user_taixe

-- select on table TAI_XE
GRANT SELECT 
ON OBJECT::TAI_XE 
TO tai_xe

-- select on khu vuc
GRANT SELECT 
ON OBJECT::KHU_VUC
TO tai_xe

-- select, insert on GIAO_HANG
GRANT SELECT,INSERT
ON OBJECT::GIAO_HANG
TO tai_xe

-- SELECT ON DON HANG
GRANT SELECT
ON OBJECT::DON_HANG
to tai_xe

-- UPDATE TTDH ON DON_HANG
GRANT UPDATE
ON OBJECT::DON_HANG(TinhTrangDH)
TO tai_xe


-- SELECT ON KHACH_HANG (MaKH, TenKH, SoDT)
GRANT SELECT
ON OBJECT::KHACH_HANG(MaKH, TenKH,SoDT)
TO tai_xe

-- Dưới đây là các quyền của nhân viên:
-- Nhân viên permission:
--		select [ALL COLUMN] on HOP_DONG
--		update [TG_HieuLucHD,%hoahong] on HOP_DONG
--		select [ALL COLUMN] on DOI_TAC
--		select on LOAI_HANG
--		insert on HOP_DONG
--		select, insert, update on CT_HOPDONG
--		select on CHI_NHANH
--		select on KHU_VUC

-- add login_nhanvien account
EXEC sp_addLogin 'login_nhanvien','login_nhanvien'

-- add user_nhanvien for login_nhanvien account
CREATE USER user_nhanvien FOR LOGIN  login_nhanvien

-- add role nhan_vien
EXEC sp_addrole 'nhan_vien'

EXEC sp_addrolemember 'nhan_vien',user_nhanvien 

--SELECT [ALL COLUMN] ON HOP_DONG
GRANT SELECT 
ON OBJECT::HOP_DONG
TO nhan_vien

--UPDATE [TG_HieuLucHD,%hoahong] ON HOP_DONG
GRANT UPDATE 
ON OBJECT::HOP_DONG(TG_HieuLucHD,PhanTramHoaHong)
TO nhan_vien

--SELECT [ALL COLUMN] ON DOI_TAC
GRANT SELECT 
ON OBJECT::DOI_TAC
TO nhan_vien

--SELECT [ALL COLUMN] ON LOAI_HANG
GRANT SELECT
ON OBJECT::LOAI_HANG
TO nhan_vien

--INSERT ON HOP_DONG
GRANT INSERT
ON OBJECT::HOP_DONG
TO nhan_vien

-- SELECT [ALL COLUMN] ON CT_HOPDONG
GRANT SELECT,INSERT, UPDATE
ON OBJECT::CT_HOPDONG
TO nhan_vien

-- SELECT ON CHI_NHANH
GRANT SELECT
ON OBJECT::CHI_NHANH 
TO nhan_vien

-- SELECT ON KHU_VUC
GRANT SELECT
ON OBJECT::KHU_VUC
TO nhan_vien
----------------------ADMIN ROLE---------------------------
-----System Admin will have the permission to alter login/user accounts and to lock/unlock login/user accounts-----
-- Create a login account for System Admin (Assume that there is only one system admin)
USE master
exec sp_addLogin 'login_sysadmin','login_sysadmin'
GRANT ALTER ANY LOGIN TO login_sysadmin
---- Create a user account for System Admin in master database
CREATE USER user_sysadmin FOR LOGIN login_sysadmin
GRANT EXECUTE to user_sysadmin
GO
---- Create a user account for System Admin in database, this account will have a db owner permission
USE OnlineOrderingSystem
CREATE USER user_sysadmin FOR LOGIN login_sysadmin
exec sp_addrolemember 'db_owner','user_sysadmin'
GO

-----Database Admin will have the permission as a db owner
-- Create three login accounts for Database Admins (Assume that there are three database admin)
USE master
exec sp_addLogin 'login_dbadmin1','login_dbadmin1'
exec sp_addLogin 'login_dbadmin2','login_dbadmin2'
exec sp_addLogin 'login_dbadmin3','login_dbadmin3'
GO
-- Create three user accounts for Database Admins
USE OnlineOrderingSystem
CREATE USER user_dbadmin1 FOR LOGIN login_dbadmin1
CREATE USER user_dbadmin2 FOR LOGIN login_dbadmin2
CREATE USER user_dbadmin3 FOR LOGIN login_dbadmin3
-- Add three user accounts of Database Admins into role db_owner
exec sp_addrolemember 'db_owner','user_dbadmin1'
exec sp_addrolemember 'db_owner','user_dbadmin2'
exec sp_addrolemember 'db_owner','user_dbadmin3'
GO

