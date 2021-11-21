--Cycle deadlock
--Test case 2
-- T2 - Doi Tac
GO
CREATE PROCEDURE sp_deadlock_tc2_T2 @madh varchar(20), @madt varchar(20)
AS
BEGIN TRAN 
	IF IS_ROLEMEMBER('doi_tac') = 0 AND IS_ROLEMEMBER('dbowner') = 0
		BEGIN
			ROLLBACK TRAN
		END
	ELSE
		BEGIN
			IF NOT EXISTs(SELECT MaDH FROM DON_HANG WHERE MaDH = @madh AND MaDT = @madt)
			BEGIN
				ROLLBACK TRAN
			END
			UPDATE DON_HANG WITH (XLOCK)
			SET TinhTrangDH = 'Da xuat hang'
			WHERE MaDH = @madh

			SELECT MaTX
			FROM GIAO_HANG
			WHERE MaDH = @madh
			COMMIT TRAN
		END

GO 
USE OnlineOrderingSystem
GRANT EXEC ON sp_deadlock_tc2_T2
TO tai_xe

GO 
USE OnlineOrderingSystem
EXEC sp_deadlock_tc2_T2 '004','005'