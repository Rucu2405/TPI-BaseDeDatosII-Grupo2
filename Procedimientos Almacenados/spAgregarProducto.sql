CREATE OR ALTER PROCEDURE spAgregarProducto
(
    @NombreProducto VARCHAR(100) = NULL,
    @IDCategoria INT = NULL,
    @Precio MONEY = NULL,
    @IDTalle INT = NULL,
	@Stock INT = NULL,
    @Descripcion VARCHAR(255) = NULL
)
AS
BEGIN
    BEGIN TRY
	/*Declaro variable mensaje */
	DECLARE @mensaje VARCHAR(4000)

        /* Validamos que se envíen los parámetros */
        IF @NombreProducto IS NULL
        BEGIN
            RAISERROR('Debe ingresar un nombre para el producto.', 16, 1)
            RETURN
        END

        IF @IDCategoria IS NULL
        BEGIN
            RAISERROR('Debe ingresar una categoría.', 16, 1)
            RETURN
        END

        IF @Precio IS NULL
        BEGIN
            RAISERROR('Debe ingresar un precio.', 16, 1)
            RETURN
        END

        IF @IDTalle IS NULL
        BEGIN
            RAISERROR('Debe ingresar un talle.', 16, 1)
            RETURN
        END

		 IF @Stock IS NULL OR @Stock <=10
        BEGIN
            RAISERROR('Debe ingresar correctamente el stock. ¡Recordar que el stock minimo es 10!', 16, 1)
            RETURN
        END

        /* Verificamos existencia de categoría */
        IF NOT EXISTS (SELECT 1 FROM Categorias WHERE IDCategoria = @IDCategoria)
        BEGIN
		SET @mensaje = 'No existe esa categoria.'+CHAR(13) + CHAR(10) + 
					   'Verifique cuales son con (Select * from Categorias)'
            RAISERROR(@mensaje, 12, 1);
	         RETURN
        END

        /* Verificamos existencia de talle */
        IF NOT EXISTS (SELECT 1 FROM Talles WHERE IDTalle = @IDTalle)
        BEGIN
		SET @mensaje = 'No existe ese talle.'+CHAR(13) + CHAR(10) + 
					   'Verifique cuales son con (Select * from Talles)'
            RAISERROR(@mensaje, 12, 1);
       
            RETURN
        END  		 	  

        /* Si está todo correcto, insertamos el producto */
        INSERT INTO Productos (NombreProducto, IDCategoria, Precio, Descripcion, IDTalle)
        VALUES (@NombreProducto, @IDCategoria, @Precio, @Descripcion, @IDTalle)
        PRINT 'Producto agregado correctamente.'

		/*Agregamos el stock del producto, con scope tenemos el ID del producto creado recientemente y le asignamos stock minimo de 10 */
		INSERT INTO Stock(IDProducto,Stock,StockMinimo)
		VALUES(SCOPE_IDENTITY(),@Stock,10)
		 PRINT 'Stock agregado correctamente.'

    END TRY
    BEGIN CATCH
        PRINT ERROR_MESSAGE()
    END CATCH
END
