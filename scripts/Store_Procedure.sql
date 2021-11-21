------------------STORED PROCEDURE FOR ADMIN--------------------

---- Create a user account for System Admin in master database
---- to execute server-level stored procedure
USE master
CREATE USER user_sysadmin FOR LOGIN login_sysadmin
GRANT EXECUTE to user_sysadmin
GO
---------UPDATE INFORMATION OF LOGIN/USER ACCOUNT
-- Change login name
CREATE PROCEDURE sp_changeLoginName @oldName nvarchar(30), @newName nvarchar(30)
AS
	BEGIN TRAN CHANGELOGINNAME
		-- Check if current user is system admin
		DECLARE @currentUser AS NVARCHAR(100)
		SET @currentUser = (SELECT SYSTEM_USER)
		IF @currentUser != 'login_sysadmin'
			BEGIN
				PRINT('You do not have permission to do this. Transaction rollback...')
				ROLLBACK TRAN CHANGELOGINNAME
			END
		ELSE
			BEGIN
				-- Check invalid parameters
				IF LEN(@oldName) = 0 OR LEN(@newName) = 0
					BEGIN
						ROLLBACK TRAN CHANGELOGINNAME
						PRINT('Invalid parameter(s). Transaction rollback...')
					END
				-- Alter login name
				DECLARE @SQLQuery nvarchar(500)
				SET @SQLQuery = 'ALTER LOGIN ' + QUOTENAME(@oldName) + ' WITH NAME = ' + QUOTENAME(@newName)
				EXECUTE sp_executesql @SQLQuery
				COMMIT TRAN CHANGELOGINNAME
			END
GO
EXEC sp_ms_marksystemobject 'sp_changeLoginName'
GO

-- Change login password
CREATE PROCEDURE sp_changeLoginPassword @loginName nvarchar(30), @newPassword nvarchar(30)
AS
	BEGIN TRAN CHANGELOGINPASSWORD
		-- Check if current user is system admin
		DECLARE @currentUser AS NVARCHAR(100)
		SET @currentUser = (SELECT SYSTEM_USER)
		IF @currentUser != 'login_sysadmin'
			BEGIN
				PRINT('You do not have permission to do this. Transaction rollback...')
				ROLLBACK TRAN CHANGELOGINPASSWORD
			END
		ELSE
			BEGIN
				-- Check invalid parameters
				IF LEN(@loginName) = 0 OR LEN(@newPassword) = 0
					BEGIN
						ROLLBACK TRAN CHANGELOGINPASSWORD
						PRINT('Invalid parameter(s). Transaction rollback...')
					END
				-- Alter login password
				DECLARE @SQLQuery nvarchar(500)
				SET @SQLQuery = 'ALTER LOGIN ' + QUOTENAME(@loginName) + ' WITH PASSWORD = ' + QUOTENAME(@newPassword)
				EXECUTE sp_executesql @SQLQuery
				COMMIT TRAN CHANGELOGINPASSWORD
			END
GO
EXEC sp_ms_marksystemobject 'sp_changeLoginPassword'
GO


-- Change user name in database
USE OnlineOrderingSystem
GO
CREATE PROCEDURE sp_changeUsername @oldUsername nvarchar(30), @newUsername nvarchar(30)
AS
	BEGIN TRAN CHANGEUSERNAME
		-- Check if current user is system admin
		DECLARE @currentUser AS NVARCHAR(100)
		SET @currentUser = (SELECT SYSTEM_USER)
		IF @currentUser != 'login_sysadmin'
			BEGIN
				PRINT('You do not have permission to do this. Transaction rollback...')
				ROLLBACK TRAN CHANGEUSERNAME
			END
		ELSE
			BEGIN
				-- Check invalid parameters
				IF LEN(@oldUsername) = 0 OR LEN(@newUsername) = 0
					BEGIN
						ROLLBACK TRAN CHANGEUSERNAME
						PRINT('Invalid parameter(s). Transaction rollback...')
					END
				-- Alter user name
				DECLARE @SQLQuery nvarchar(500)
				SET @SQLQuery = 'ALTER USER ' + QUOTENAME(@oldUsername) + ' WITH NAME = ' + QUOTENAME(@newUsername)
				EXECUTE sp_executesql @SQLQuery
				COMMIT TRAN CHANGEUSERNAME
			END
GO

---------ADD/DELETE ACCOUNT OF ADMINS AND EMPLOYEES
-- Add login account for admin/employee
USE master
GO
CREATE PROCEDURE sp_addLoginAccount @loginName nvarchar(30), @loginPassword nvarchar(30)
AS
	BEGIN TRAN ADDLOGINACCOUNT
		-- Check if current user is system admin
		DECLARE @currentUser AS NVARCHAR(100)
		SET @currentUser = (SELECT SYSTEM_USER)
		IF @currentUser != 'login_sysadmin'
			BEGIN
				PRINT('You do not have permission to do this. Transaction rollback...')
				ROLLBACK TRAN ADDLOGINACCOUNT
			END
		ELSE
			BEGIN
				-- Check invalid parameters
				IF LEN(@loginName) = 0 OR LEN(@loginPassword) = 0
					BEGIN
						ROLLBACK TRAN ADDLOGINACCOUNT
						PRINT('Invalid parameter(s). Transaction rollback...')
					END
				-- Add login
				DECLARE @SQLQuery nvarchar(500)
				SET @SQLQuery = 'CREATE LOGIN ' + @loginName + ' WITH PASSWORD = ' + quotename(@loginPassword,'''')
				EXECUTE sp_executesql @SQLQuery
				COMMIT TRAN ADDLOGINACCOUNT
			END
GO
EXEC sp_ms_marksystemobject 'sp_addLoginAccount'
GO

-- Add user account for admin
CREATE PROCEDURE sp_addUserForAdmin @userName nvarchar(30), @loginName nvarchar(30)
AS
	BEGIN TRAN ADDUSERFORADMIN
		-- Check if current user is system admin
		DECLARE @currentUser AS NVARCHAR(100)
		SET @currentUser = (SELECT SYSTEM_USER)
		IF @currentUser != 'login_sysadmin'
			BEGIN
				PRINT('You do not have permission to do this. Transaction rollback...')
				ROLLBACK TRAN ADDLOGINFORADMIN
			END
		ELSE
			BEGIN
				-- Check invalid parameters
				IF LEN(@userName) = 0 OR LEN(@loginName) = 0
					BEGIN
						ROLLBACK TRAN ADDUSERFORADMIN
						PRINT('Invalid parameter(s). Transaction rollback...')
					END
				-- Add user for admin
				DECLARE @SQLQuery nvarchar(500)
				SET @SQLQuery = 'USE OnlineOrderingSystem CREATE USER ' + @userName + ' FOR LOGIN ' + @loginName
				EXECUTE sp_executesql @SQLQuery

				-- Add role for admin
				SET @SQLQuery = 'USE OnlineOrderingSystem ALTER ROLE db_owner ADD MEMBER ' + @userName
				EXECUTE sp_executesql @SQLQuery
				COMMIT TRAN ADDUSERFORADMIN
			END
GO

-- Add user account for employee
CREATE PROCEDURE sp_addUserForEmployee @userName nvarchar(30), @loginName nvarchar(30)
AS
	BEGIN TRAN ADDUSERFOREMPLOYEE
		-- Check if current user is system admin
		DECLARE @currentUser AS NVARCHAR(100)
		SET @currentUser = (SELECT SYSTEM_USER)
		IF @currentUser != 'login_sysadmin'
			BEGIN
				PRINT('You do not have permission to do this. Transaction rollback...')
				ROLLBACK TRAN ADDUSERFOREMPLOYEE
			END
		ELSE
			BEGIN
				-- Check invalid parameters
				IF LEN(@userName) = 0 OR LEN(@loginName) = 0
					BEGIN
						ROLLBACK TRAN ADDUSERFOREMPLOYEE
						PRINT('Invalid parameter(s). Transaction rollback...')
					END
				-- Add user for employee
				DECLARE @SQLQuery nvarchar(500)
				SET @SQLQuery = 'USE OnlineOrderingSystem CREATE USER ' + @userName + ' FOR LOGIN ' + @loginName
				EXECUTE sp_executesql @SQLQuery

				-- Add role for employee
				SET @SQLQuery = 'USE OnlineOrderingSystem ALTER ROLE nhan_vien ADD MEMBER ' + @userName
				EXECUTE sp_executesql @SQLQuery
				COMMIT TRAN ADDUSERFOREMPLOYEE
			END
GO

-- Delete user account of admin/employee
CREATE PROCEDURE sp_deleteUserAccount @userName nvarchar(30)
AS
	BEGIN TRAN DELETEUSERACCOUNT
		-- Check if current user is system admin
		DECLARE @currentUser AS NVARCHAR(100)
		SET @currentUser = (SELECT SYSTEM_USER)
		IF @currentUser != 'login_sysadmin'
			BEGIN
				PRINT('You do not have permission to do this. Transaction rollback...')
				ROLLBACK TRAN DELETEUSERACCOUNT
			END
		ELSE
			BEGIN
				-- Check invalid parameters
				IF LEN(@userName) = 0
					BEGIN
						ROLLBACK TRAN DELETEUSERACCOUNT
						PRINT('Invalid parameter(s). Transaction rollback...')
					END
				-- Delete user account
				DECLARE @SQLQuery nvarchar(500)
				SET @SQLQuery = 'DROP USER ' + @userName
				EXECUTE sp_executesql @SQLQuery
				COMMIT TRAN DELETEUSERACCOUNT
			END
GO

-- Lock login account of admin/employee
CREATE PROCEDURE sp_lockLoginAccount @loginName nvarchar(30)
AS
	BEGIN TRAN LOCKLOGINACCOUNT
		-- Check if current user is system admin
		DECLARE @currentUser AS NVARCHAR(100)
		SET @currentUser = (SELECT SYSTEM_USER)
		IF @currentUser != 'login_sysadmin'
			BEGIN
				PRINT('You do not have permission to do this. Transaction rollback...')
				ROLLBACK TRAN LOCKLOGINACCOUNT
			END
		ELSE
			BEGIN
				-- Check invalid parameters
				IF LEN(@loginName) = 0
					BEGIN
						ROLLBACK TRAN LOCKLOGINACCOUNT
						PRINT('Invalid parameter(s). Transaction rollback...')
					END
				-- Delete user account
				DECLARE @SQLQuery nvarchar(500)
				SET @SQLQuery = 'USE master ALTER LOGIN ' + QUOTENAME(@loginName) + ' DISABLE'
				EXECUTE sp_executesql @SQLQuery
				COMMIT TRAN LOCKLOGINACCOUNT
			END
GO

-- Unlock login account of admin/employee
CREATE PROCEDURE sp_unlockLoginAccount @loginName nvarchar(30)
AS
	BEGIN TRAN UNLOCKLOGINACCOUNT
		-- Check if current user is system admin
		DECLARE @currentUser AS NVARCHAR(100)
		SET @currentUser = (SELECT SYSTEM_USER)
		IF @currentUser != 'login_sysadmin'
			BEGIN
				PRINT('You do not have permission to do this. Transaction rollback...')
				ROLLBACK TRAN UNLOCKLOGINACCOUNT
			END
		ELSE
			BEGIN
				-- Check invalid parameters
				IF LEN(@loginName) = 0
					BEGIN
						ROLLBACK TRAN UNLOCKLOGINACCOUNT
						PRINT('Invalid parameter(s). Transaction rollback...')
					END
				-- Delete user account
				DECLARE @SQLQuery nvarchar(500)
				SET @SQLQuery = 'USE master ALTER LOGIN ' + QUOTENAME(@loginName) + ' ENABLE'
				EXECUTE sp_executesql @SQLQuery
				COMMIT TRAN UNLOCKLOGINACCOUNT
			END
GO

-- Lock user account of admin/employee
CREATE PROCEDURE sp_lockUserAccount @userName nvarchar(30)
AS
	BEGIN TRAN LOCKUSERACCOUNT
		-- Check if current user is system admin
		DECLARE @currentUser AS NVARCHAR(100)
		SET @currentUser = (SELECT SYSTEM_USER)
		IF @currentUser != 'login_sysadmin'
			BEGIN
				PRINT('You do not have permission to do this. Transaction rollback...')
				ROLLBACK TRAN LOCKUSERACCOUNT
			END
		ELSE
			BEGIN
				-- Check invalid parameters
				IF LEN(@userName) = 0
					BEGIN
						ROLLBACK TRAN LOCKUSERACCOUNT
						PRINT('Invalid parameter(s). Transaction rollback...')
					END
				-- Delete user account
				DECLARE @SQLQuery nvarchar(500)
				SET @SQLQuery = 'USE OnlineOrderingSystem DENY CONNECT ON DATABASE::OnlineOrderingSystem TO ' + @userName
				EXECUTE sp_executesql @SQLQuery
				COMMIT TRAN LOCKUSERACCOUNT
			END
GO

-- Unlock user account of admin/employee
CREATE PROCEDURE sp_unlockUserAccount @userName nvarchar(30)
AS
	BEGIN TRAN UNLOCKUSERACCOUNT
		-- Check if current user is system admin
		DECLARE @currentUser AS NVARCHAR(100)
		SET @currentUser = (SELECT SYSTEM_USER)
		IF @currentUser != 'login_sysadmin'
			BEGIN
				PRINT('You do not have permission to do this. Transaction rollback...')
				ROLLBACK TRAN UNLOCKUSERACCOUNT
			END
		ELSE
			BEGIN
				-- Check invalid parameters
				IF LEN(@userName) = 0
					BEGIN
						ROLLBACK TRAN UNLOCKUSERACCOUNT
						PRINT('Invalid parameter(s). Transaction rollback...')
					END
				-- Delete user account
				DECLARE @SQLQuery nvarchar(500)
				SET @SQLQuery = 'USE OnlineOrderingSystem GRANT CONNECT ON DATABASE::OnlineOrderingSystem TO ' + @userName
				EXECUTE sp_executesql @SQLQuery
				COMMIT TRAN UNLOCKUSERACCOUNT
			END
GO


-- Insert partner
CREATE TYPE branchList AS TABLE (
	maCN varchar(20),
	maDT varchar(20),
	maKV varchar(20),
	diaChiCuThe nvarchar(50)
)
GO

CREATE PROCEDURE sp_insertPartner 
@maDT varchar(20),
@tenDT nvarchar(50),
@nguoiDaiDien nvarchar(50),
@maKV varchar(20),
@soChiNhanh int,
@soLuongDH int,
@maLoai varchar(20),
@diaChiKD nvarchar(50),
@soDT varchar(15),
@email varchar(50),
@maSoThue varchar(20),
@danhSachChiNhanh branchList READONLY
AS
	BEGIN TRAN INSERTPARTNER
		-- Check if current user has db_owner role
		IF IS_ROLEMEMBER('db_owner') = 0
			BEGIN
				PRINT('You do not have permission to do this. Transaction rollback...')
				ROLLBACK TRAN INSERTPARTNER
			END
		ELSE
			BEGIN
				-- Check if partner exist
				IF EXISTS (SELECT * FROM DOI_TAC WHERE MaDT = @maDT)
					BEGIN
						ROLLBACK TRAN INSERTPARTNER
						PRINT('Partner already exists. Transaction rollback...')
					END
				-- Insert partner
				INSERT INTO DOI_TAC VALUES(@maDT, @tenDT, @nguoiDaiDien, @maKV, @soChiNhanh, @soLuongDH, @maLoai, @diaChiKD, @soDT, @email, @maSoThue)
				
				-- Insert list of branches
				INSERT INTO CHI_NHANH SELECT * FROM @danhSachChiNhanh
				
				COMMIT TRAN INSERTPARTNER
			END
GO

-- Insert customer
CREATE PROCEDURE sp_insertCustomer
@maKH varchar(20),
@tenKH nvarchar(50),
@soDT varchar(15)
AS
	BEGIN TRAN INSERTCUSTOMER
		-- Check if current user has db_owner role
		IF IS_ROLEMEMBER('db_owner') = 0
			BEGIN
				PRINT('You do not have permission to do this. Transaction rollback...')
				ROLLBACK TRAN INSERTPARTNER
			END
		ELSE
			BEGIN
				-- Check if customer exist
				IF EXISTS (SELECT * FROM KHACH_HANG WHERE MaKH = @maKH)
					BEGIN
						ROLLBACK TRAN INSERTCUSTOMER
						PRINT('Customer already exists. Transaction rollback...')
					END
				-- Insert customer
				INSERT INTO KHACH_HANG VALUES(@maKH, @tenKH, @soDT)
				
				COMMIT TRAN INSERTCUSTOMER
			END
GO

-- Insert driver
CREATE PROCEDURE sp_insertDriver
@maTX varchar(20),
@tenTX nvarchar(50),
@cmnd varchar(15),
@soDT varchar(15),
@diaChi nvarchar(100),
@bienSo varchar(15),
@maKV varchar(20),
@email varchar(50),
@taiKhoanNH nvarchar(100)
AS
	BEGIN TRAN INSERTDRIVER
		-- Check if current user has db_owner role
		IF IS_ROLEMEMBER('db_owner') = 0
			BEGIN
				PRINT('You do not have permission to do this. Transaction rollback...')
				ROLLBACK TRAN INSERTDRIVER
			END
		ELSE
			BEGIN
				-- Check if driver exist
				IF EXISTS (SELECT * FROM TAI_XE WHERE MaTX = @maTX)
					BEGIN
						ROLLBACK TRAN INSERTDRIVER
						PRINT('Customer already exists. Transaction rollback...')
					END
				-- Insert driver
				INSERT INTO TAI_XE VALUES(@maTX, @tenTX, @cmnd, @soDT, @diaChi, @bienSo, @maKV, @email, @taiKhoanNH)
				
				COMMIT TRAN INSERTDRIVER
			END
GO
