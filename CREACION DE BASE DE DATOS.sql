--Crear base de datos
CREATE DATABASE TPI_GP02
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

--Tabla de Pedidos
CREATE TABLE Pedidos (
    IDPedido INT IDENTITY(1,1) PRIMARY KEY NOT NULL,
	IDCliente INT FOREIGN KEY REFERENCES Clientes(IDCliente) NOT NULL,
	IDVoucher INT FOREIGN KEY REFERENCES Vouchers(IDVoucher),
	PrecioFinalPedido MONEY NOT NULL,
	FechaCreado DATE NOT NULL,
	FechaEntregado DATE
);
GO

--Tabla Estados
CREATE TABLE Estados (
    IDEstado INT IDENTITY(1,1) PRIMARY KEY NOT NULL,
    NombreEstado VARCHAR(50) NOT NULL
);
GO

--Tabla EstadoPedido
CREATE TABLE EstadoPedido (
    IDPedido INT PRIMARY KEY FOREIGN KEY REFERENCES Pedidos(IDPedido) NOT NULL,
    IDEstado INT FOREIGN KEY REFERENCES Estados(IDEstado) NOT NULL	
);
GO

--Tabla Categorías
CREATE TABLE Categorias (
    IDCategoria INT IDENTITY(1,1) PRIMARY KEY NOT NULL,
	Nombre VARCHAR(50) NOT NULL
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
	Cantidad INT NOT NULL,
	PrecioXCantidad MONEY NOT NULL
);






