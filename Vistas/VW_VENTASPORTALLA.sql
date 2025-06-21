--Vista para obtener las ventas totales de cada talle de meyor a menor--

CREATE VIEW VW_VENTASPORTALLA AS
SELECT 
    T.DescripcionTalle,
    SUM(DP.Cantidad) AS TotalVendidos
FROM DetallePedido DP
JOIN Productos P ON DP.IDProducto = P.IDProducto
JOIN Talles T ON P.IDTalle = T.IDTalle
GROUP BY T.DescripcionTalle;
GO

--Hacemos SELECT de esa vista ordenando de mayor venta a menor venta.
SELECT * FROM VW_VENTASPORTALLA