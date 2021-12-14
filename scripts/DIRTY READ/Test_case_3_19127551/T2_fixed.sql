--T1 doi tac cap nhat gia san pham 
--T2 khach hang xem chi tiet san pham
go
use OnlineOrderingSystem
GO
CREATE PROCEDURE sp_dirtyread_tc3_T2_fixed @madt nvarchar(20)
AS
BEGIN TRAN 
	IF IS_ROLEMEMBER('khach_hang') = 0 AND IS_ROLEMEMBER('dbowner') = 0
		BEGIN
			ROLLBACK TRAN
		END
	ELSE
		BEGIN
			--SET TRANSACTION ISOLATION LEVEL READ COMMITTED
			IF EXISTS (SELECT * FROM SAN_PHAM sp JOIN CHI_NHANH cn on sp.MaCN = cn.MaCN and cn.MaDT = @madt)
				BEGIN
					SELECT sp.MaSP, sp.TenSanPham, sp.Loai, lh.TenLoai, sp.Gia FROM SAN_PHAM sp JOIN CHI_NHANH cn on sp.MaCN = cn.MaCN and cn.MaDT = @madt JOIN LOAI_HANG lh ON sp.Loai = lh.MaLoai
					COMMIT TRAN;
				END
			ELSE
				BEGIN
					ROLLBACK TRAN
				END
		END

