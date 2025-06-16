--Crear base de datos
CREATE DATABASE TPI_GP02
collate Latin1_General_CI_AI
GO
USE TPI_GP02
GO

--Tabla de Clientes
CREATE TABLE Clientes (
    IDCliente INT IDENTITY(1,1) PRIMARY KEY NOT NULL,
    DNI_Cliente INT NOT NULL,
	Nombre VARCHAR(50) NOT NULL,
	Apellido VARCHAR(50) NOT NULL,
	Direccion VARCHAR(100) NOT NULL,
	CP SMALLINT NOT NULL,
	FechaNacimiento DATE NOT NULL,
	Mail VARCHAR(255) NOT NULL
);
GO

--Tabla de Vouchers
CREATE TABLE Vouchers (
    IDVoucher INT IDENTITY(1,1) PRIMARY KEY NOT NULL,
	Descuento SMALLINT NOT NULL
);
GO

--Tabla EstadoPedido
CREATE TABLE EstadoPedido (
    IDEstado INT IDENTITY(1,1) PRIMARY KEY NOT NULL,	
	NombreEstado VARCHAR(50) NOT NULL
);
GO

--Tabla de Pedidos
CREATE TABLE Pedidos (
    IDPedido INT IDENTITY(1,1) PRIMARY KEY NOT NULL,
	IDEstado INT FOREIGN KEY REFERENCES EstadoPedido(IDEstado) NOT NULL,
	IDCliente INT FOREIGN KEY REFERENCES Clientes(IDCliente) NOT NULL,
	IDVoucher INT FOREIGN KEY REFERENCES Vouchers(IDVoucher),
	FechaCreado DATE NOT NULL default GETDATE(),
	FechaEntregado DATE
);
GO

--Tabla Categorías
CREATE TABLE Categorias (
    IDCategoria INT IDENTITY(1,1) PRIMARY KEY NOT NULL,
	DescripcionCategoria VARCHAR(50) NOT NULL
);
GO

--Tabla Talles 
CREATE TABLE Talles (
    IDTalle INT IDENTITY(1,1) PRIMARY KEY NOT NULL,
	DescripcionTalle VARCHAR(20) NOT NULL
);
GO

--Tabla Productos
CREATE TABLE Productos (
    IDProducto INT IDENTITY(1,1) PRIMARY KEY NOT NULL,
	NombreProducto VARCHAR(100) NOT NULL,
	IDCategoria INT FOREIGN KEY REFERENCES Categorias(IDCategoria) NOT NULL,
	Precio MONEY NOT NULL,
	Descripcion VARCHAR(255),
	IDTalle INT FOREIGN KEY REFERENCES Talles(IDTalle) NOT NULL
);
GO

--Tabla Stock
CREATE TABLE Stock (
    IDStock INT IDENTITY(1,1) PRIMARY KEY NOT NULL,
	IDProducto INT FOREIGN KEY REFERENCES Productos(IDProducto) NOT NULL,
	Stock INT NOT NULL,
	StockMinimo INT NOT NULL
);
GO

--Tabla DetallePedido
CREATE TABLE DetallePedido (
    IDDetallePedido INT IDENTITY(1,1) PRIMARY KEY NOT NULL,
	IDPedido INT FOREIGN KEY REFERENCES Pedidos(IDPedido) NOT NULL,
	IDProducto INT FOREIGN KEY REFERENCES Productos(IDProducto) NOT NULL,
	Cantidad INT NOT NULL
);






