
--Conversion deadlock
--Test case 1
-- T2 - Tai Xe
GO
CREATE PROCEDURE sp_deadlock_tc1_T2 @madh varchar(20)
AS
BEGIN TRAN 
	IF IS_ROLEMEMBER('tai_xe') = 0 AND IS_ROLEMEMBER('dbowner') = 0
		BEGIN
			ROLLBACK TRAN
		END
	ELSE
		BEGIN
			SET TRAN ISOLATION LEVEL SERIALIZABLE
			SELECT TenDuong FROM DON_HANG WITH (Holdlock) WHERE MaDH = @madh
			UPDATE DON_HANG WITH (XLOCK)
			SET TinhTrangDH = 'Tai xe nhan hang'
			WHERE MaDH = @madh
			COMMIT TRAN
		END
