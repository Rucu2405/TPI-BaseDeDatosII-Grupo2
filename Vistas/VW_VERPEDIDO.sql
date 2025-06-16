--Vista para obtener el detalle de todos los pedidos, con el preciofinal calculado si tiene un voucher de descuento.
CREATE VIEW VW_VERPEDIDO AS 
Select P.IDPedido, 
C.Nombre + ', ' + C.Apellido as NombreApellidoCliente, 
PR.NombreProducto, 
PR.Descripcion, 
DP.Cantidad, ( (PR.Precio * DP.Cantidad) - ( (PR.Precio * DP.Cantidad) * ISNULL(V.Descuento, 0) / 100 ) ) as  PrecioFinal, 
EP.NombreEstado as Estado 
From Pedidos P
INNER JOIN Clientes C ON P.IDCliente = C.IDCliente
INNER JOIN DetallePedido DP ON P.IDPedido = DP.IDPedido
INNER JOIN Productos PR ON DP.IDProducto = PR.IDProducto
LEFT JOIN Vouchers V ON P.IDVoucher = V.IDVoucher
INNER JOIN EstadoPedido EP ON P.IDEstado = EP.IDEstado

--Hacemos SELECT para ver todos los pedidos ordenados por Nombre y apellido por ejemplo
SELECT * FROM VW_VERPEDIDO
ORDER BY NombreApellidoCliente;

