CREATE OR ALTER TRIGGER tr_InsertarPedidoGenerarVoucher
ON Pedidos
AFTER INSERT
AS
BEGIN

    DECLARE @IDCliente INT;
    DECLARE @IDPedido INT;
    DECLARE @NuevoIDVoucher INT;

    DECLARE pedido_cursor CURSOR FOR
    SELECT IDCliente, IDPedido FROM inserted;

    OPEN pedido_cursor;
    FETCH NEXT FROM pedido_cursor INTO @IDCliente, @IDPedido;

    WHILE @@FETCH_STATUS = 0
    BEGIN
        -- Me fijo si antes  de este pedido, el cliente tenía exactamente 5
        IF (SELECT COUNT(*) FROM Pedidos WHERE IDCliente = @IDCliente AND IDPedido < @IDPedido) = 5
        BEGIN
            INSERT INTO Vouchers (Descuento) VALUES (10);
            SET @NuevoIDVoucher = SCOPE_IDENTITY();

            UPDATE Pedidos
            SET IDVoucher = @NuevoIDVoucher
            WHERE IDPedido = @IDPedido;
        END

        FETCH NEXT FROM pedido_cursor INTO @IDCliente, @IDPedido;
    END

    CLOSE pedido_cursor;
    DEALLOCATE pedido_cursor;
END;
