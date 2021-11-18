-----System Admin will have the permission to alter login/user accounts and to lock/unlock login/user accounts-----
-- Create a login account for System Admin (Assume that there is only one system admin)
USE master
exec sp_addLogin 'login_sysadmin','login_sysadmin'
GRANT ALTER ANY LOGIN TO login_sysadmin
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

