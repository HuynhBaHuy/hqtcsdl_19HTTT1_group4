USE OnlineOrderingSystem
GO
CREATE PROCEDURE spUpdateOrderStatusForPartner_T2_error @madt varchar(20),  @madh varchar(20), @ttdh nvarchar(50)
AS
BEGIN TRAN
	IF IS_ROLEMEMBER('doi_tac') = 0 AND IS_ROLEMEMBER('db_owner') = 0
		BEGIN
			ROLLBACK TRAN
			PRINT('TRANSACTION IS ROLLBACKED')
		END
	ELSE
		BEGIN
			IF NOT EXISTS (SELECT * FROM DON_HANG WHERE MaDH = @madh and MaDT = @madt)
				BEGIN
					ROLLBACK TRAN
					PRINT('TRANSACTION IS ROLLBACKED')
				END
			ELSE
				BEGIN
					IF (SELECT TinhTrangDH FROM DON_HANG WHERE MaDH = @madh) = N'Hoàn trả hàng'
						-- Not allow to update order status when the order is refunded
						BEGIN
							ROLLBACK TRAN
							PRINT('TRANSACTION IS ROLLBACKED')
						END
					ELSE IF ((SELECT TinhTrangDH FROM DON_HANG WHERE MaDH = @madh) = N'Đã giao hàng' AND @ttdh != N'Hoàn trả hàng')
						-- Not allow to update order status when the order is marked at delivered, except refund
						BEGIN
							ROLLBACK TRAN
							PRINT('TRANSACTION IS ROLLBACKED')
						END
					ELSE
						BEGIN
							UPDATE DON_HANG
							SET TinhTrangDH = @ttdh
							WHERE MaDH = @madh
							COMMIT TRAN
						END
				END
		END