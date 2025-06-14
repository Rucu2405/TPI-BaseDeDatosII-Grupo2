CREATE PROCEDURE spVerificarPedidosXestado (@idestado INT = null)    

AS    
BEGIN

    BEGIN TRY    
        /* Validamos si no se envia un parametro para el estado, se informan los disponibles */  
        IF @idestado IS NULL    
        BEGIN    
            RAISERROR('Debe ingresar un valor para el estado: 1-Pendiente, 2-En Proceso, 3-Entregado, 4-Cancelado.', 12, 1)    
            RETURN    
        END    
    
        /* Validamos que el estado exista */
        IF @idestado < 1 OR @idestado > 4    
        BEGIN    
            RAISERROR('Ingrese un estado entre 1 y 4: 1-Pendiente, 2-En Proceso, 3-Entregado, 4-Cancelado.', 12, 1)    
            RETURN    
        END    
    
       
        SELECT     
            P.IDPedido,    
            EP.NombreEstado,    
            C.Nombre + ' ' + C.Apellido AS [Nombre y Apellido Cliente],    
            C.DNI_Cliente,    
            C.Mail,    
            V.Descuento    
        FROM Pedidos AS P    
        INNER JOIN EstadoPedido AS EP ON P.IDEstado = EP.IDEstado    
        INNER JOIN Clientes AS C ON P.IDCliente = C.IDCliente    
        LEFT JOIN Vouchers AS V ON P.IDVoucher = V.IDVoucher    
        WHERE P.IDEstado = @idestado    
        ORDER BY C.DNI_Cliente    
    
        -- contamos los pedidos, si no hay, se informa que no tenemos pedidos con el estado a buscar. 
        IF @@ROWCOUNT = 0    
        BEGIN    
            PRINT 'No hay pedidos con el estado ingresado.'    
        END    

    END TRY    
    BEGIN CATCH    
        PRINT ERROR_MESSAGE()    
    END CATCH    
END    