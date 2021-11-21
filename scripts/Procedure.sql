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
CREATE PROCEDURE spCreateOrder @madt varchar(20), @makh varchar(20), @ht_tt nvarchar(50), @tenduong nvarchar(50), @makv varchar(20), @tt_dh nvarchar(50)
AS
BEGIN TRAN 
	IF IS_ROLEMEMBER('khach_hang') = 0 AND IS_ROLEMEMBER('db_owner') = 0
		BEGIN
			ROLLBACK TRAN
			PRINT('TRANSACTION IS ROLLBACKED')
		END 
	ELSE
		BEGIN
			IF NOT EXISTS (SELECT * FROM DON_HANG WHERE Makh = @makh)
				BEGIN
					ROLLBACK TRAN
					PRINT('TRANSACTION IS ROLLBACKED')
				END
			ELSE 
				BEGIN
					INSERT DON_HANG
					VALUES (null, @madt, @makh, @ht_tt, @tenduong, @makv, 0, 0, @tt_dh)
				END 
			COMMIT TRAN
		END
GO
CREATE PROCEDURE spSelectOrderInformation @madh varchar(20), @masp varchar(20), @soluong int
AS
BEGIN TRAN 
	IF IS_ROLEMEMBER('khach_hang') = 0 AND IS_ROLEMEMBER('db_owner') = 0
		BEGIN
			ROLLBACK TRAN
			PRINT('TRANSACTION IS ROLLBACKED')
		END 
	ELSE
		BEGIN
			IF NOT EXISTS (SELECT * FROM DON_HANG WHERE Madh = @madh)
				BEGIN
					ROLLBACK TRAN
					PRINT('TRANSACTION IS ROLLBACKED')
				END
			ELSE 
				BEGIN
					IF NOT EXISTS (SELECT * FROM CT_DONHANG WHERE MaDH = @madh and MaSP = @masp)
						BEGIN
							UPDATE CT_DONHANG
							SET SoLuong = @soluong
							where MaSP = @masp and MaDH = @madh
						END
					ELSE
						BEGIN
						INSERT CT_DONHANG
						VALUES (@madh, @masp, @soluong)
						END
					UPDATE DON_HANG
					SET TongPhiSP = (SELECT SUM(ct.SoLuong*sp.Gia) FROM SAN_PHAM sp JOIN CT_DONHANG ct ON sp.MaSP = ct.MaSP where ct.MaDH = @madh)  
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
CREATE PROCEDURE spShipOrderStatus @matx varchar(20), @madh varchar(20), @ttdh nvarchar(50), @makh varchar(20)
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
					INSERT GIAO_HANG (MaTX,MaDH)
					VALUES (@maTX,@madh)
				END 
			COMMIT TRAN
		END

GO 
USE OnlineOrderingSystem
GRANT EXEC ON spShipOrderStatus
TO khach_hang
EXEC spShipOrderStatus N'977', N'468', N'Tai Xe Dang Giao Hang', N'844'

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
EXEC spViewShippingProcess N'468'



-- STORE PROCEDURE FOR TAI_XE
-- hien thi danh sach don hang theo khu vuc 
GO 
CREATE PROCEDURE spViewOrderList @matx varchar(20)
AS
BEGIN TRAN
	IF IS_ROLEMEMBER('tai_xe') = 0 AND IS_ROLEMEMBER('db_owner') = 0
		BEGIN 
			ROLLBACK TRAN
			PRINT('TRANSACTION IS ROLLBACKED')
		END
	ELSE 
	BEGIN
		IF NOT EXISTS(SELECT MATX FROM TAI_XE WHERE  MaTX = @matx)
			BEGIN
				ROLLBACK TRAN
				PRINT('TRANSACTION IS ROLLBACKED')
			END 
		ELSE 
			BEGIN
				DECLARE @makv varchar(20);
				SET @makv = (SELECT MAKV FROM TAI_XE WHERE MaTX = @matx)
				SELECT DH.*
				FROM DON_HANG DH
				WHERE DH.MaKV = @makv AND DH.MaDH NOT IN (SELECT MADH FROM GIAO_HANG) 
			END
		COMMIT TRAN
	END



-- grant exec cho tai_xe
GO 
use OnlineOrderingSystem
GRANT EXEC ON spViewOrderList 
TO tai_xe



-- chon don hang phuc vu
GO
CREATE PROCEDURE spSelectOrder @maTX varchar(20), @madh varchar(20)
AS
BEGIN TRAN 
	IF IS_ROLEMEMBER('tai_xe') = 1 OR IS_ROLEMEMBER('db_owner') = 1
		BEGIN
			IF NOT EXISTS(SELECT * FROM TAI_XE WHERE MaTX = @maTX) 
			OR EXISTS (SELECT * FROM GIAO_HANG WHERE MaDH = @madh) 
			OR NOT EXISTS (SELECT * FROM DON_HANG WHERE MaDH = @madh) 
			OR NOT EXISTS (SELECT * FROM DON_HANG dh, TAI_XE tx WHERE dh.MaKV = tx.MaKV AND dh.MaDH = @madh AND tx.MaTX = @maTX)
				BEGIN
					ROLLBACK TRAN
					PRINT('TRANSACTION IS ROLLBACKED')
				END 
			ELSE 
				BEGIN 
					INSERT GIAO_HANG (MaTX,MaDH)
					VALUES (@maTX,@madh)
				END
			COMMIT TRAN
		END
	ELSE
		BEGIN
			ROLLBACK TRAN
			PRINT('TRANSACTION IS ROLLBACKED')
		END

-- grant exec cho tai_xe
GO 
USE OnlineOrderingSystem
GRANT EXEC ON spSelectOrder 
TO tai_xe

-- cap nhat tinh trang don hang 
GO 
CREATE PROCEDURE spUpdateOrderStatus @matx varchar(20), @madh varchar(20), @ttdh nvarchar(50)
AS
BEGIN TRAN
	IF IS_ROLEMEMBER('tai_xe') = 0 AND IS_ROLEMEMBER('db_owner') = 0
		BEGIN
			ROLLBACK TRAN
			PRINT('TRANSACTION IS ROLLBACKED')
		END
	ELSE
		BEGIN
		IF NOT EXISTS (SELECT * FROM GIAO_HANG WHERE MaTX = @matx AND MaDH = @madh)
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
to tai_xe


-- hien thi danh sach don hang ma tai xe da nhan  va phi van chuyen cua tung don hang
GO 
CREATE PROCEDURE spViewMyOrders @matx varchar(20)
AS
BEGIN TRAN
	IF IS_ROLEMEMBER('tai_xe') = 0 AND IS_ROLEMEMBER('db_owner') = 0
		BEGIN
			ROLLBACK TRAN
			PRINT('TRANSACTION IS ROLLBACKED')
		END
	ELSE
		BEGIN
			IF NOT EXISTS(SELECT * FROM TAI_XE WHERE MaTX = @matx)
				BEGIN 
					ROLLBACK TRAN
				END
			ELSE 
				BEGIN
					SELECT * FROM DON_HANG WHERE MADH IN (SELECT MADH FROM GIAO_HANG WHERE MaTX = @matx)
				END
			COMMIT TRAN
		END

-- GRANT 
GO 
USE OnlineOrderingSystem
GRANT EXEC ON spViewMyOrders
TO tai_xe

GO
USE OnlineOrderingSystem
EXEC spViewMyOrders '004'




-- STORE PROCEDURE FOR nhan vien 

-- xem danh sach hop dong da lap cua doi tac
GO
CREATE PROCEDURE spGetExpiredContract @madt varchar(20)
AS
BEGIN TRAN 
	IF IS_ROLEMEMBER('nhan_vien') = 0 
	AND IS_ROLEMEMBER('doi_tac') = 0
	AND IS_ROLEMEMBER('db_owner') = 0
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
			SELECT hd.*
			FROM HOP_DONG hd
			WHERE hd.MaDT = @madt AND CAST( GETDATE() AS Date ) < hd.TG_HieuLucHD
		END 
		COMMIT TRAN
	END

GO 
USE OnlineOrderingSystem
GRANT EXEC ON spGetExpiredContract
TO nhan_vien


-- xem danh sach hop dong da lap cua doi tac
GO
CREATE PROCEDURE spGetAllConstractList @madt varchar(20)
AS
BEGIN TRAN 
	IF IS_ROLEMEMBER('nhan_vien') = 0 
	AND IS_ROLEMEMBER('doi_tac') = 0
	AND IS_ROLEMEMBER('db_owner') = 0
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
					SELECT hd.*
					FROM HOP_DONG hd
					WHERE hd.MaDT = @madt 
				END 
			COMMIT TRAN
		END

GO 
USE OnlineOrderingSystem
GRANT EXEC ON spGetAllConstractList
TO nhan_vien

-----------------STORED PROCEDURE FOR ADMIN--------------------

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

SELECT * 
FROM master.INFORMATION_SCHEMA.ROUTINES
WHERE ROUTINE_TYPE = 'PROCEDURE'