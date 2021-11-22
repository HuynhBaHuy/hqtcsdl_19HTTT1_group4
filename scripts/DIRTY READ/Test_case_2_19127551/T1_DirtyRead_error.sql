--T1 doi tac xem danh sach hop dong cua minh
--T2 nhan vien cap nhat hop dong 

go
use OnlineOrderingSystem
GO
CREATE PROCEDURE sp_dirtyread_tc2_T1 @madt nvarchar(20)
AS
BEGIN TRAN 
	IF IS_ROLEMEMBER('doi_tac') = 0 AND IS_ROLEMEMBER('dbowner') = 0
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


