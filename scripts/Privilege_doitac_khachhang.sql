-- Các quyền của partner do admin cấp:
--		select, insert, update, delete on table SAN_PHAM, CHI_NHANH
--		select on table DON_HANG
--		update TTDH on table DON_HANG



-- add login partner account
USE OnlineOrderingSystem
GO
EXEC sp_addLogin 'login_partner','login_partner'

-- add user partner for login partner account
CREATE USER user_partner FOR LOGIN  login_partner

-- add role partner
EXEC sp_addrole 'doi_tac'

EXEC sp_addrolemember 'doi_tac',user_partner 

-- select, insert, delete, update on table SAN_PHAM, CHI_NHANH
GRANT SELECT, INSERT, DELETE, UPDATE 
ON OBJECT::SAN_PHAM 
TO doi_tac

GRANT SELECT, INSERT, DELETE, UPDATE 
ON OBJECT::CHI_NHANH 
TO doi_tac

-- SELECT ON DON_HANG
GRANT SELECT
ON OBJECT::DON_HANG
to doi_tac

-- UPDATE TTDH ON DON_HANG
GRANT UPDATE
ON OBJECT::DON_HANG(TinhTrangDH)
TO doi_tac


-- Các quyền của customer do admin cấp:
--		select TenDT, NguoiDaiDien, MaKV, MaLoai, DiaChiKD, SoDT, Email on DOI_TAC
--		select on DON_HANG

-- add login customer account
USE OnlineOrderingSystem
GO
EXEC sp_addLogin 'login_customer','login_customer'

-- add user customer for login customer account
CREATE USER user_customer FOR LOGIN  login_customer

-- add role customer
EXEC sp_addrole 'khach_hang'

EXEC sp_addrolemember 'khach_hang',user_customer 

--	select TenDT, NguoiDaiDien, MaKV, MaLoai, DiaChiKD, SoDT, Email on DOI_TAC
GRANT UPDATE
ON OBJECT::DON_HANG(TenDT, NguoiDaiDien, MaKV, MaLoai, DiaChiKD, SoDT, Email)
TO khach_hang

-- SELECT ON DON HANG
GRANT SELECT
ON OBJECT::DON_HANG
to khach_hang