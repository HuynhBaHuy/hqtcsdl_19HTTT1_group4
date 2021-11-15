



USE OnlineOrderingSystem


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

