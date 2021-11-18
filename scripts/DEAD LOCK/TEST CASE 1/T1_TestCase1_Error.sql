--Conversion deadlock
--Test case 1
-- T1 - doi tac
GO
CREATE PROCEDURE sp_deadlock_tc1_T1 @madt varchar(20), @madh varchar(20)
AS
BEGIN TRAN 
IF IS_ROLEMEMBER('doi_tac') = 0 AND IS_ROLEMEMBER('dbowner') = 0
BEGIN
	ROLLBACK TRAN
END
ELSE
BEGIN
SET TRAN ISOLATION LEVEL SERIALIZABLE
IF EXISTS (SELECT* FROM DON_HANG WITH (Holdlock) WHERE MaDT = @madt AND MaDH = @madh)
BEGIN
	Waitfor Delay '0:0:10';
	UPDATE DON_HANG 
	SET TinhTrangDH = 'Da xuat hang khoi kho'
	WHERE MaDH = @madh
	COMMIT TRAN;
END
ELSE
BEGIN
	ROLLBACK TRAN
END
END

GO 
USE OnlineOrderingSystem
GRANT EXEC ON sp_deadlock_tc1_T1
TO doi_tac

--GO 
--USE OnlineOrderingSystem
--EXEC sp_deadlock_tc1_T1 '001','007'