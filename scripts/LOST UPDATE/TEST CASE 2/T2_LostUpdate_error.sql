--T1 cap nhat gia san pham 
--T2 cap nhat gia san pham
go
use OnlineOrderingSystem
BEGIN TRANSACTION
  DECLARE @giasp float
  SELECT @giasp = Gia FROM SAN_PHAM WHERE MaSP =N'146'
  -- Transaction takes 10 seconds
  WAITFOR DELAY '00:00:10'
  SET @giasp = @giasp + @giasp*0.2
  UPDATE SAN_PHAM SET Gia = @giasp WHERE MaSP=N'146'
COMMIT TRANSACTION