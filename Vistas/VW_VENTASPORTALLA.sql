--Vista para obtener las ventas totales de cada talle de meyor a menor--

CREATE OR ALTER VIEW VW_ESTADISTICAS_VENTAS_POR_TALLE AS
SELECT 
    T.DescripcionTalle AS Talle,
    COUNT(DISTINCT P.IDPedido) AS CantidadPedidos,
    SUM(DP.Cantidad) AS UnidadesVendidas,
    SUM(PR.Precio * DP.Cantidad) AS VentasBrutas,
    SUM((PR.Precio * DP.Cantidad) * ISNULL(V.Descuento, 0) / 100) AS TotalDescuentos,
    SUM((PR.Precio * DP.Cantidad) - ((PR.Precio * DP.Cantidad) * ISNULL(V.Descuento, 0) / 100)) AS VentasNetas,
    ROUND(AVG(PR.Precio), 2) AS PrecioPromedioPorUnidad
FROM 
    Pedidos P
    INNER JOIN DetallePedido DP ON P.IDPedido = DP.IDPedido
    INNER JOIN Productos PR ON DP.IDProducto = PR.IDProducto
    INNER JOIN Talles T ON PR.IDTalle = T.IDTalle
    LEFT JOIN Vouchers V ON P.IDVoucher = V.IDVoucher
GROUP BY 
    T.DescripcionTalle


    --Hacemos SELECT de esa vista ordenando de mayor venta a menor venta.
SELECT * FROM VW_ESTADISTICAS_VENTAS_POR_TALLE ORDER BY 
    UnidadesVendidas DESC;