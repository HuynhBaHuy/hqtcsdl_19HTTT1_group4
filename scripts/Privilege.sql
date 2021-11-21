-- Dưới đây là các quyền của driver do admin cấp
-- Driver permission: 
--		select,insert,update on table TAI_XE
--		select on KhuVuc
--		select, insert, update on GIAO_HANG
--		update TTDH on DON_HANG



-- add login driver account
USE OnlineOrderingSystem
GO
EXEC sp_addLogin 'login_driver','login_driver'

-- add user driver for login driver account
CREATE USER user_driver FOR LOGIN  login_driver

-- add role driver
EXEC sp_addrole 'tai_xe'

EXEC sp_addrolemember 'tai_xe',user_driver 

-- select,insert,update on table TAI_XE
GRANT SELECT, INSERT, UPDATE 
ON OBJECT::TAI_XE 
TO tai_xe

-- select on khu vuc
GRANT SELECT 
ON OBJECT::KHU_VUC
TO tai_xe

-- select, insert, update on GIAO_HANG
GRANT SELECT, INSERT, UPDATE
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

-- Dưới đây là các quyền của employees do admin cấp
-- Employees permission:
--		select [ALL COLUMN] on Hop dong
--		update [THOIGIAN HOP DONG] on DOI Tac
--		select [ALL COLUMN] on DOI TAC

-- add login employees account
EXEC sp_addLogin 'login_nhanvien','login_nhanvien'

-- add user driver for login driver account
CREATE USER user_nhanvien FOR LOGIN  login_nhanvien

-- add role driver
EXEC sp_addrole 'nhan_vien'

EXEC sp_addrolemember 'nhan_vien',user_nhanvien 

--select [ALL COLUMN] on Hop dong
GRANT SELECT 
ON OBJECT::HOP_DONG
TO nhan_vien

--update [THOIGIAN HOP DONG] on HopDong
GRANT UPDATE 
ON OBJECT::HOP_DONG(TG_HieuLucHD)
TO nhan_vien

--select [ALL COLUMN] on DOI TAC
GRANT SELECT 
ON OBJECT::DOI_TAC
TO nhan_vien