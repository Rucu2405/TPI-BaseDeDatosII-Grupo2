    CREATE OR ALTER TRIGGER tr_EliminarCliente
    ON Clientes
    INSTEAD OF DELETE
    AS
    BEGIN
        -- Verifico si tiene pedidos "en curso"
        IF EXISTS (
            SELECT 1
            FROM deleted d
            JOIN Pedidos p ON p.IDCliente = d.IDCliente
            WHERE p.IDEstado IN (1, 2)
        )
        BEGIN
            RAISERROR('No se puede eliminar el cliente porque tiene pedidos en estado pendiente o enviado.', 16, 1);
            RETURN;
        END

        -- Elimino primero los detalles de los pedidos del cliente
        DELETE FROM DetallePedido
        WHERE IDPedido IN (
            SELECT IDPedido
            FROM Pedidos
            WHERE IDCliente IN (SELECT IDCliente FROM deleted)
        );

        -- Si no hay pedidos en curso, eliminamos primero los pedidos relacionados
        DELETE FROM Pedidos
        WHERE IDCliente IN (SELECT IDCliente FROM deleted);

        -- Luego eliminamos al cliente
        DELETE FROM Clientes
        WHERE IDCliente IN (SELECT IDCliente FROM deleted);
    END;
