

-----System Admin will have the permission to alter login/user accounts and to lock/unlock login/user accounts-----
-- Create login account for System Admin
USE master
exec sp_addLogin 'login_sysadmin','login_sysadmin'
USE master
GRANT ALTER ANY LOGIN TO login_sysadmin
GO
---- Create user account for System Admin in database
CREATE USER user_sysadmin FOR LOGIN login_sysadmin
USE OnlineOrderingSystem
GRANT ALTER ANY USER TO user_sysadmin
GO

-----Database Admin will have the permission to alter role
---- Create role database admin
USE OnlineOrderingSystem
exec sp_addrole 'database_admin'
---- Add the user account of System Admin as role database_admin
exec sp_addrolemember 'database_admin','user_sysadmin'
GRANT ALTER ON ROLE::khach_hang TO database_admin
GRANT ALTER ON ROLE::doi_tac TO database_admin
GRANT ALTER ON ROLE::tai_xe TO database_admin
GRANT ALTER ON ROLE::nhan_vien TO database_admin

-- GRANT SELECT TO database_admin WITH GRANT OPTION; PHẦN NÀY LÀM SAU

