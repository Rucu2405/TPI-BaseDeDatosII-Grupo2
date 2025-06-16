ALTER PROCEDURE spObtenerDetallePedido
   ( @IDPedido INT = NULL,
   @infoCliente INT = NULL
   )
AS
BEGIN
	BEGIN TRY
	/*Declaro variable mensaje */
	DECLARE @mensaje VARCHAR(4000);

	 /* Validamos si no se envia un parametro para el pedido */  
        IF @IDPedido IS NULL    
        BEGIN    
		/* Seteamos el mensaje personalizado con salto de linea */
            SET @mensaje = 'Debe ingresar un IDPedido.' + CHAR(13) + CHAR(10) + 
                           'Si solicita informacion del cliente ingrese 1 despues de el pedido separado con una coma.' + CHAR(13) + CHAR(10) +
						   'por ejemplo: exec spObtenerDetallePedido IDPedido,1';

            RAISERROR(@mensaje, 12, 1);
            RETURN    
        END  

		 /* Obtengo descuento del voucher del pedido (isnull si no tiene descuento, le asigna 0 */
        DECLARE @descuento smallint = 
            ISNULL((SELECT VO.Descuento
             FROM Pedidos PE
             LEFT JOIN Vouchers VO ON PE.IDVoucher = VO.IDVoucher
             WHERE PE.IDPedido = @IDPedido),0);

        /* Calculo total sin descuento  */
        DECLARE @totalSinDescuento MONEY = 
            (SELECT SUM(PR.Precio * DP.Cantidad)
             FROM DetallePedido DP
             INNER JOIN Productos PR ON DP.IDProducto = PR.IDProducto
             WHERE DP.IDPedido = @IDPedido);


        DECLARE @totalConDescuento MONEY = @totalSinDescuento * (1 - (@descuento/100.0));
		


    /* Detalle del pedido */
		   SELECT 
			 DP.IDPedido AS 'Pedido N°',	 
			 '$ ' + FORMAT(@totalConDescuento,'N2') AS 'Total Pedido',
			PR.NombreProducto AS 'Producto',
			PR.Descripcion,
			DP.Cantidad,
			'$ ' + FORMAT(PR.Precio,'N2')AS 'Precio Unitario',
			'$ ' + FORMAT((PR.Precio * DP.Cantidad), 'N2') AS SubtotalProducto
			FROM DetallePedido AS DP
			INNER JOIN Productos AS PR ON DP.IDProducto = PR.IDProducto
			INNER JOIN Pedidos AS PE ON DP.IDPedido=PE.IDPedido 
				WHERE DP.IDPedido = @IDPedido
				ORDER BY DP.Cantidad DESC;

/* Si solicita la info del cliente */
	IF (@infoCliente = 1)
	BEGIN
			SELECT
			CL.Nombre +', '+ CL.Apellido 'Cliente',
			CL.DNI_Cliente 'DNI',
			CL.Direccion,
			CL.Mail,
			FORMAT(P.FechaCreado,'dd "de" MMMM "de" yyyy') AS 'Pedido creado',
			EP.NombreEstado AS 'Estado Pedido',
			 CASE 
					WHEN EP.NombreEstado = 'Entregado' THEN 
						FORMAT(P.FechaEntregado, 'dd "de" MMMM "de" yyyy')
					ELSE 
						'-'
				END AS 'Pedido entregado'
			FROM Pedidos AS P
			INNER JOIN Clientes AS CL ON P.IDCliente = CL.IDCliente
			INNER JOIN EstadoPedido AS EP ON P.IDEstado=EP.IDEstado
			WHERE P.IDPedido=@IDPedido
			
	END
	ELSE
		BEGIN 
		SELECT 'Para solicitar la información del cliente debe ingresar 1 como segundo parámetro.' AS Mensaje
	END
END TRY
BEGIN CATCH
     PRINT ERROR_MESSAGE()    
END CATCH
  

END


