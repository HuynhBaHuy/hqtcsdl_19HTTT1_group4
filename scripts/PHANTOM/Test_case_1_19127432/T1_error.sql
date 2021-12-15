USE OnlineOrderingSystem
GO

CREATE PROCEDURE sp_phantom_tc1_T1_error @madt varchar(20)
AS
BEGIN TRAN
	IF IS_ROLEMEMBER('nhan_vien') = 0 AND IS_ROLEMEMBER('db_owner') = 0
		BEGIN 
			ROLLBACK TRAN
			PRINT('TRANSACTION IS ROLLBACKED')
		END
	ELSE 
		BEGIN
			IF NOT EXISTS(SELECT h.MaHD FROM HOP_DONG h WHERE MaDT = @madt)
				BEGIN
					ROLLBACK TRAN
					PRINT('TRANSACTION IS ROLLBACKED')
				END 
			ELSE
				BEGIN
					Waitfor Delay '00:00:10'
					DECLARE @mahd varchar(20)
					SET @mahd = (SELECT h.MaHD FROM HOP_DONG h WHERE MaDT = @madt)

					DELETE FROM CT_HOPDONG
					WHERE MaHD = @mahd

					DELETE FROM HOP_DONG
					WHERE MaHD = @mahd

					COMMIT
				END
		END