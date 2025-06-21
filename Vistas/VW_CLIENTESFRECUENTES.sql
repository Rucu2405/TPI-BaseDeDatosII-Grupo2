--Vista para obtener los TOP 5 compradores de meyor a menor--

CREATE VIEW VW_CLIENTESFRECUENTES AS
SELECT 
    C.IDCliente,
    C.Nombre,
    C.Apellido,
    COUNT(P.IDPedido) AS CantidadPedidos
FROM Clientes C
JOIN Pedidos P ON C.IDCliente = P.IDCliente
GROUP BY C.IDCliente, C.Nombre, C.Apellido
HAVING COUNT(P.IDPedido) > 5;

--Hacemos SELECT de esa vista ordenando de mayor a menor los clientes con mas compras.
SELECT * FROM VW_CLIENTESFRECUENTES