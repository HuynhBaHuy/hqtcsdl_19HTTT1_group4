--T1 doi tac cap nhat tinh trang don hang
--T2 tai xe cap nhat tinh trang don hang

go
use OnlineOrderingSystem

GO
CREATE PROCEDURE sp_lostupdate_tc3_T1_fixed @madh varchar(20), @ttdh nvarchar(50)
AS
BEGIN TRAN 
	IF IS_ROLEMEMBER('doi_tac') = 0 AND IS_ROLEMEMBER('dbowner') = 0
		BEGIN
			ROLLBACK TRAN
		END
	ELSE
		BEGIN
			IF EXISTS (SELECT * FROM DON_HANG WHERE MaDH = @madh)
				BEGIN
					SELECT TinhTrangDH FROM DON_HANG with(updlock) WHERE MaDH = @madh
					WAITFOR DELAY '00:00:10'
					UPDATE DON_HANG 
					SET TinhTrangDH = @ttdh 
					WHERE MaDH = @madh
					COMMIT TRAN;
				END
			ELSE
				BEGIN
					ROLLBACK TRAN
				END
		END

