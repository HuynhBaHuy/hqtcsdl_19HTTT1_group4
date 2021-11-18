--T1 cap nhat so luong san pham trong chi tiet don hang
--T2 xem chi tiet don hang
go
use OnlineOrderingSystem
SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
SELECT * FROM CT_DONHANG WHERE MaDH =N'005'