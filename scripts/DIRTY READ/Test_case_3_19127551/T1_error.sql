--T1 doi tac cap nhat gia san pham 
--T2 khach hang xem chi tiet san pham
go
use OnlineOrderingSystem
GO
CREATE PROCEDURE sp_dirtyread_tc3_T1_error @madt varchar(20), @masp varchar(20), @gia float
AS
BEGIN TRAN 
	SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
	IF IS_ROLEMEMBER('doi_tac') = 0 AND IS_ROLEMEMBER('db_owner') = 0
		BEGIN
			PRINT('ROLLBACK TRAN')
			ROLLBACK TRAN
		END
	ELSE
		BEGIN
			IF EXISTS (SELECT * FROM SAN_PHAM sp JOIN CHI_NHANH cn on sp.MaCN = cn.MaCN and cn.MaDT = @madt)
				BEGIN
					SELECT * FROM SAN_PHAM WHERE MaSP = @masp    
					UPDATE SAN_PHAM SET GIA = @gia WHERE MaSP = @masp 
					-- Waiting for updating
					Waitfor Delay '00:00:10'
					-- Cancel update due to lost network. Rollback transaction
					PRINT('ROLLBACK TRAN')
					ROLLBACK TRAN
				END
		END
