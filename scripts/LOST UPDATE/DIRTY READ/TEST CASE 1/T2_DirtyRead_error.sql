--T1 tai xe cap nhat tinh trang don hang 
--T2 khach hang xem tinh trang don hang
go
use OnlineOrderingSystem
GO
CREATE PROCEDURE sp_dirtyread_tc1_T2 @madh nvarchar(20)
AS
BEGIN TRAN 
	IF IS_ROLEMEMBER('khach_hang') = 0 AND IS_ROLEMEMBER('dbowner') = 0
		BEGIN
			ROLLBACK TRAN
		END
	ELSE
		BEGIN
			SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
			IF EXISTS (SELECT * FROM DON_HANG WHERE MaDH = @madh)
				BEGIN
					SELECT TinhTrangDH FROM DON_HANG WHERE MaDH = @madh
					COMMIT TRAN;
				END
			ELSE
				BEGIN
					ROLLBACK TRAN
				END
		END

GO 
USE OnlineOrderingSystem
GRANT EXEC ON sp_dirtyread_tc1_T2
TO khach_hang

GO 
USE OnlineOrderingSystem
EXEC sp_dirtyread_tc1_T2 N'100'