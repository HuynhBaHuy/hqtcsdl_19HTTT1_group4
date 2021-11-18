--T1 cap nhat so luong san pham trong chi tiet don hang
--T2 xem chi tiet don hang
go
use OnlineOrderingSystem
BEGIN TRANSACTION
  SELECT * FROM CT_DONHANG WHERE MaSP = N'503' and MaDH = N'005'
  UPDATE CT_DONHANG SET SOLUONG = SoLuong + 10 WHERE MaSP = N'503' and MaDH = N'005'
  -- Waiting for updating
  Waitfor Delay '00:00:10'
  -- Cancel due to insuffient product. Rollback transaction
ROLLBACK TRANSACTION