CREATE OR ALTER PROCEDURE sp_AgregarCliente
(
    @DNI_Cliente VARCHAR(15) = NULL,
    @Nombre VARCHAR(50) = NULL,
    @Apellido VARCHAR(50) = NULL,
    @Direccion VARCHAR(100) = NULL,
    @CP VARCHAR(10) = NULL,
    @FechaNacimiento DATE = NULL,
    @Mail VARCHAR(100) = NULL
)
AS
BEGIN
    BEGIN TRY
      --Declaro variable mensaje 
        DECLARE @mensaje VARCHAR(4000)

       --validamos que se envíen los parámetros obligatorios
        IF @DNI_Cliente IS NULL
        BEGIN
            RAISERROR('Debe ingresar el DNI del cliente.', 16, 1)
            RETURN
        END

        IF @Nombre IS NULL
        BEGIN
            RAISERROR('Debe ingresar el nombre del cliente.', 16, 1)
            RETURN
        END

        IF @Apellido IS NULL
        BEGIN
            RAISERROR('Debe ingresar el apellido del cliente.', 16, 1)
            RETURN
        END

        -- Validación adicional para DNI (ejemplo: longitud mínima) 
        IF LEN(@DNI_Cliente) < 8
        BEGIN
            RAISERROR('El DNI debe tener al menos 8 caracteres.', 16, 1)
            RETURN
        END

       --Verificamos que el DNI no exista 
        IF EXISTS (SELECT 1 FROM Clientes WHERE DNI_Cliente = @DNI_Cliente)
        BEGIN
            SET @mensaje = 'El cliente con DNI ' + @DNI_Cliente + ' ya existe.' + CHAR(13) + CHAR(10) + 
                          'Verifique los clientes existentes con (SELECT * FROM Clientes)'
            RAISERROR(@mensaje, 12, 1)
            RETURN
        END

        -- Validación básica de email si se proporciona 
        IF @Mail IS NOT NULL AND @Mail NOT LIKE '%_@__%.__%'
        BEGIN
            RAISERROR('El formato del email no es válido.', 16, 1)
            RETURN
        END

       -- Si está todo correcto, insertamos el cliente 
        INSERT INTO Clientes (DNI_Cliente, Nombre, Apellido, Direccion, CP, FechaNacimiento, Mail)
        VALUES (@DNI_Cliente, @Nombre, @Apellido, @Direccion, @CP, @FechaNacimiento, @Mail)
        
        PRINT 'Cliente agregado correctamente.'
        
    END TRY
    BEGIN CATCH
        PRINT ERROR_MESSAGE()
    END CATCH
END

