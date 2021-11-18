--T1 xem danh sach hop dong
--T2 cap nhat hop dong 
go
use OnlineOrderingSystem
SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
SELECT * FROM HOP_DONG WHERE MaDT = N'057'

