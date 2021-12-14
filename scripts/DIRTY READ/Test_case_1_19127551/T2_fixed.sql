--T1 tai xe cap nhat tinh trang don hang 
--T2 khach hang xem tinh trang don hang
go
use OnlineOrderingSystem
GO
CREATE PROCEDURE sp_dirtyread_T2_fixed @madh nvarchar(20)
AS
BEGIN TRAN 
	IF IS_ROLEMEMBER('khach_hang') = 0 AND IS_ROLEMEMBER('dbowner') = 0
		BEGIN
			ROLLBACK TRAN
		END
	ELSE
		BEGIN
			--SET TRANSACTION ISOLATION LEVEL READ COMMITTED
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
