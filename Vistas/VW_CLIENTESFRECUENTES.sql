--Vista para obtener los TOP 5 compradores de mayor a menor--

CREATE OR ALTER VIEW VW_TOP_COMPRADORES AS
SELECT TOP 5
    C.IDCliente,
    C.Nombre + ' ' + C.Apellido AS Cliente,
    COUNT(DISTINCT P.IDPedido) AS CantidadPedidos,
    SUM(DP.Cantidad) AS TotalProductosComprados,
     '$ ' + CONVERT(VARCHAR,CAST(SUM((PR.Precio * DP.Cantidad) - ((PR.Precio * DP.Cantidad) * ISNULL(V.Descuento, 0) / 100)) 
           AS MONEY), 1) AS TotalGastado
FROM 
    Clientes C
    JOIN Pedidos P ON C.IDCliente = P.IDCliente
    JOIN DetallePedido DP ON P.IDPedido = DP.IDPedido
    JOIN Productos PR ON DP.IDProducto = PR.IDProducto
    LEFT JOIN Vouchers V ON P.IDVoucher = V.IDVoucher
GROUP BY 
    C.IDCliente, C.Nombre, C.Apellido
ORDER BY 
    SUM(DP.Cantidad) DESC;
    
--Hacemos SELECT de esa vista de los clientes con mas productos comprados.
SELECT * FROM VW_TOP_COMPRADORES