
USE TPI_GP02
GO


--Vouchers
INSERT INTO Vouchers (Descuento) VALUES (10), (15), (20);
GO

--EstadosPedido
INSERT INTO EstadoPedido (NombreEstado) VALUES 
('Pendiente'), 
('Enviado'), 
('Entregado'), 
('Cancelado');
GO

--Categorias
INSERT INTO Categorias (DescripcionCategoria) VALUES
('Buzos Cuello Redondo'),
('Buzos Con Capucha'),
('Buzos Oversize'),
('Buzos Estampados'),
('Buzos con Cremallera');
GO

--Talles
INSERT INTO Talles (DescripcionTalle) VALUES ('S'), ('M'), ('L'), ('XL');
GO

--Productos 
INSERT INTO Productos (NombreProducto, IDCategoria, Precio, Descripcion, IDTalle) VALUES
('Ráfaga', 1, 2500, 'Buzo de algodón azul cuello redondo', 2),
('Terral', 2, 2700, 'Buzo rojo con capucha', 3),
('Pulsar', 3, 2600, 'Buzo oversize color negro', 1),
('Nómada', 4, 2400, 'Buzo estampado color gris', 4),
('Bruma', 5, 2550, 'Buzo verde con cremallera', 2);
GO

--Stock 
INSERT INTO Stock (IDProducto, Stock, StockMinimo) VALUES
(1, 50, 10),
(2, 40, 10),
(3, 60, 15),
(4, 70, 10),
(5, 55, 10);
GO

--Clientes
INSERT INTO Clientes (DNI_Cliente, Nombre, Apellido, Direccion, CP, FechaNacimiento, Mail) VALUES
(12345678, 'Juan', 'Pérez', 'Calle Falsa 123', 1400, '1985-04-12', 'juan.perez@mail.com'),
(23456789, 'María', 'González', 'Av. Siempre Viva 742', 1405, '1990-08-22', 'maria.gonzalez@mail.com'),
(34567890, 'Carlos', 'Ramírez', 'Calle Luna 456', 1410, '1978-01-05', 'carlos.ramirez@mail.com'),
(45678901, 'Ana', 'Torres', 'Av. Sol 789', 1415, '1995-11-30', 'ana.torres@mail.com'),
(56789012, 'Luis', 'Fernández', 'Calle Estrella 321', 1420, '1982-06-15', 'luis.fernandez@mail.com');
GO

--Pedidos
INSERT INTO Pedidos (IDEstado, IDCliente, IDVoucher, FechaCreado, FechaEntregado) VALUES
(3, 1, 1,  '2025-05-01', '2025-05-05'),
(2, 1, 2,  '2025-05-03', '2025-05-08'),
(1, 2, NULL,  '2025-05-05', NULL),
(4, 2, 1,  '2025-05-06', '2025-05-10'),
(1, 3, 3,  '2025-05-07', NULL),
(3, 3, NULL,  '2025-05-10', '2025-05-15'),
(4, 4, 2,  '2025-05-11', '2025-05-16'),
(1, 4, NULL,  '2025-05-13', NULL),
(3, 5, 1,  '2025-05-15', '2025-05-20'),
(2, 5, 3,  '2025-05-16', NULL),
(3, 1, NULL,  '2025-05-18', '2025-05-22'),
(1, 2, 2,  '2025-05-20', NULL),
(4, 3, 1,  '2025-05-22', '2025-05-27'),
(1, 4, 3,  '2025-05-24', NULL),
(3, 5, NULL,  '2025-05-26', '2025-05-30');
GO

--DetallePedido 
INSERT INTO DetallePedido (IDPedido, IDProducto, Cantidad) VALUES
(1, 1, 1),
(2, 2, 1),
(2, 2, 1),
(2, 2, 1),
(2, 2, 1),
(3, 3, 1),
(4, 4, 1),
(5, 5, 2),
(6, 1, 1),
(6, 3, 1),
(7, 2, 1),
(8, 4, 1),
(9, 1, 1),
(9, 3, 4),
(9, 2, 5),
(10, 5, 1),
(11, 3, 1),
(12, 4, 1),
(12, 2, 2),
(12, 1, 3),
(12, 4, 10),
(13, 5, 1),
(14, 2, 1),
(15, 3, 1);
GO