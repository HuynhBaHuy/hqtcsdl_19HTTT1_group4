--T1 nhan vien 1 cua doi tac cap nhat thoi gian hieu luc hop dong 
--T2 nhan vien 2 cua doi tac cap nhat thoi gian hieu luc hop dong
-- T2
go
use OnlineOrderingSystem

GO
CREATE PROCEDURE sp_lostupdate_tc1_T2 @mahd nvarchar(20), @tg_hlhd date
AS
BEGIN TRAN 
	IF IS_ROLEMEMBER('doi_tac') = 0 AND IS_ROLEMEMBER('dbowner') = 0
		BEGIN
			ROLLBACK TRAN
		END
	ELSE
		BEGIN
			IF EXISTS (SELECT * FROM HOP_DONG WHERE MaHD = @mahd)
				BEGIN
					SELECT TG_HieuLucHD FROM HOP_DONG WHERE MaHD = @mahd
					UPDATE HOP_DONG SET TG_HieuLucHD = @tg_hlhd
					WHERE MaHD = @mahd
					COMMIT TRAN;
				END
			ELSE
				BEGIN
					ROLLBACK TRAN
				END
		END

GO 
USE OnlineOrderingSystem
GRANT EXEC ON sp_lostupdate_tc1_T2
TO doi_tac

GO 
USE OnlineOrderingSystem
EXEC sp_lostupdate_tc1_T2 N'085','2027-01-05'