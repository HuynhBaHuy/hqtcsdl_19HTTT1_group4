--T1 khach hang xem danh sach hop dong
--T2 nhan vien cap nhat hop dong 

go
use OnlineOrderingSystem
GO
CREATE PROCEDURE sp_dirtyread_tc2_T1 @madt nvarchar(20)
AS
BEGIN TRAN 
	IF IS_ROLEMEMBER('khach_hang') = 0 AND IS_ROLEMEMBER('dbowner') = 0
		BEGIN
			ROLLBACK TRAN
		END
	ELSE
		BEGIN
			SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
			IF EXISTS (SELECT * FROM HOP_DONG WHERE MaDT = @madt)
				BEGIN
					SELECT * FROM HOP_DONG WHERE MaDT = @madt
					COMMIT TRAN;
				END
			ELSE
				BEGIN
					ROLLBACK TRAN
				END
		END

GO 
USE OnlineOrderingSystem
GRANT EXEC ON sp_dirtyread_tc2_T1
TO khach_hang

--GO 
--USE OnlineOrderingSystem
--EXEC sp_dirtyread_tc2_T1 N'057'

