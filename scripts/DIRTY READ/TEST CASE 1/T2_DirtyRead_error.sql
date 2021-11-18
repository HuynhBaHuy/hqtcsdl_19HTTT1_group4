--T1 cap nhat tinh trang don hang 
--T2 xem tinh trang don hang
go
use OnlineOrderingSystem
SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
SELECT * FROM DON_HANG WHERE MaDH = N'005'