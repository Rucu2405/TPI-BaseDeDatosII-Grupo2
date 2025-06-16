--Vista para obtener las ventas totales de cada categoría de buzos.
CREATE VIEW VW_VENTACATEGORIAS AS 
Select C.DescripcionCategoria AS Categoria, 
SUM(DP.Cantidad) AS TotalVendidos
From DetallePedido DP
INNER JOIN Productos P ON DP.IDProducto = P.IDProducto
INNER JOIN Categorias C ON P.IDCategoria = C.IDCategoria
GROUP BY C.DescripcionCategoria;

--Hacemos SELECT de esa vista ordenando de mayor venta a menor venta.
SELECT * FROM VW_VENTACATEGORIAS
ORDER BY TotalVendidos DESC;

