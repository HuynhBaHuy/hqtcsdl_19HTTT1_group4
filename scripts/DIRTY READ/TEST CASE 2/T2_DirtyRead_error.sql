--T1 xem danh sach hop dong
--T2 cap nhat hop dong 
go
use OnlineOrderingSystem
BEGIN TRANSACTION
  SELECT PhanTramHoaHong FROM HOP_DONG WHERE MaDT = N'057'    
  UPDATE HOP_DONG SET PhanTramHoaHong = PhanTramHoaHong + PhanTramHoaHong*0.2 WHERE MaDT = N'057'
  -- Waiting for updating
  Waitfor Delay '00:00:10'
  -- Cancel due to lost network. Rollback transaction
ROLLBACK TRANSACTION