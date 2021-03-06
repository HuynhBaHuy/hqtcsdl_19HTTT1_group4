--T1 nhan vien xem danh sach hop dong
--T2 doi tac cap nhat hop dong 

go
use OnlineOrderingSystem
GO
CREATE PROCEDURE sp_dirtyread_tc2_T1_error @madt varchar(20)
AS
BEGIN TRAN 
	SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
	IF IS_ROLEMEMBER('nhan_vien') = 0 AND IS_ROLEMEMBER('db_owner') = 0
		BEGIN
			ROLLBACK TRAN
		END
	ELSE
		BEGIN
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

