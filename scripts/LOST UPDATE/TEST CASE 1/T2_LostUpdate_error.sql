--T1 cap nhat thoi gian hieu luc hop dong 
--T2 cap nhat thoi gian hieu luc hop dong
go
use OnlineOrderingSystem
BEGIN TRANSACTION
  DECLARE @tg_hlhd date
  SELECT @tg_hlhd = TG_HieuLucHD FROM HOP_DONG WHERE MaHD=N'085'
 
  SET @tg_hlhd = '2027-06-05'
  UPDATE HOP_DONG SET TG_HieuLucHD = @tg_hlhd WHERE MaHD=N'085'
COMMIT TRANSACTION