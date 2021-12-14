--T1 nhan vien 1 cua doi tac cap nhat gia san pham 
--T2 nhan vien 2 cua doi tac cap nhat gia san pham
use OnlineOrderingSystem
GO
CREATE PROCEDURE sp_lostupdate_tc2_T1_fixed @masp nvarchar(20), @giasp float
AS
BEGIN TRAN 
	IF IS_ROLEMEMBER('doi_tac') = 0 AND IS_ROLEMEMBER('dbowner') = 0
		BEGIN
			ROLLBACK TRAN
		END
	ELSE
		BEGIN
			IF EXISTS (SELECT * FROM SAN_PHAM WHERE MaSP = @masp)
				BEGIN
					SELECT * FROM SAN_PHAM with(updlock) WHERE MaSP = @masp
					UPDATE SAN_PHAM 
					SET Gia = @giasp 
					WHERE MaSP = @masp
					COMMIT TRAN;
				END
			ELSE
				BEGIN
					ROLLBACK TRAN
				END
		END
