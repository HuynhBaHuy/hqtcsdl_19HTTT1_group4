USE OnlineOrderingSystem
GO

CREATE PROCEDURE spUpdateOrderStatusForDriver_T1_error @matx varchar(20), @madh varchar(20), @ttdh nvarchar(50)
AS
BEGIN TRAN
	IF IS_ROLEMEMBER('tai_xe') = 0 AND IS_ROLEMEMBER('db_owner') = 0
		BEGIN
			ROLLBACK TRAN
			PRINT('TRANSACTION IS ROLLBACKED')
		END
	ELSE
		BEGIN
			IF NOT EXISTS (SELECT * FROM GIAO_HANG WHERE MaTX = @matx AND MaDH = @madh)
				BEGIN
					ROLLBACK TRAN
					PRINT('TRANSACTION IS ROLLBACKED')
				END
			ELSE
				BEGIN
					IF (SELECT TinhTrangDH FROM DON_HANG WHERE MaDH = @madh) = 'Hoàn trả hàng'
						-- Not allow to update order status when the order is refunded
						BEGIN
							ROLLBACK TRAN
							PRINT('TRANSACTION IS ROLLBACKED')
						END
					ELSE
						-- Not allow to update order status when the order is marked at delivered, except refund
						BEGIN
							Waitfor Delay '0:0:10'
							IF ((SELECT TinhTrangDH FROM DON_HANG WHERE MaDH = @madh) = 'Đã giao hàng' AND @ttdh != 'Đã hoàn trả hàng')
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
		END
