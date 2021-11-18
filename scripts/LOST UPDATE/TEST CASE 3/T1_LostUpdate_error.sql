--T1 cap nhat tinh trang don hang
--T2 cap nhat tinh trang don hang
go
use OnlineOrderingSystem
BEGIN TRANSACTION
  DECLARE @ttdh nvarchar(50)
  SELECT @ttdh = TinhTrangDH FROM DON_HANG WHERE MaDH = N'005'
  -- Transaction takes 10 seconds
  WAITFOR DELAY '00:00:10'
  SET @ttdh = N'Da gui hang cho tai xe'
  UPDATE DON_HANG SET TinhTrangDH = @ttdh WHERE MaDH = N'005'
COMMIT TRANSACTION
