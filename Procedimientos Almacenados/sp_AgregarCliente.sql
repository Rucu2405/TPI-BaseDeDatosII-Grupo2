CREATE OR ALTER PROCEDURE sp_AgregarCliente
(
    @DNI_Cliente INT,
    @Nombre VARCHAR(50),
    @Apellido VARCHAR(50),
    @Direccion VARCHAR(100),
    @CP SMALLINT,
    @FechaNacimiento DATE,
    @Mail VARCHAR(255)
)
AS
BEGIN
    BEGIN TRY
        DECLARE @mensaje VARCHAR(255)

        -- Validaciones obligatorias
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

        -- Validación básica de longitud (opcional)
        IF LEN(CAST(@DNI_Cliente AS VARCHAR)) < 8
        BEGIN
            RAISERROR('El DNI debe tener al menos 8 dígitos.', 16, 1)
            RETURN
        END

        -- Verificar existencia
        IF EXISTS (SELECT 1 FROM Clientes WHERE DNI_Cliente = @DNI_Cliente)
        BEGIN
            SET @mensaje = 'El cliente con DNI ' + CAST(@DNI_Cliente AS VARCHAR) + ' ya existe.' + CHAR(13) + CHAR(10) + 
                           'Verifique los clientes existentes con (SELECT * FROM Clientes)'
            RAISERROR(@mensaje, 12, 1)
            RETURN
        END

        -- Validación de email
        IF @Mail NOT LIKE '%_@__%.__%'
        BEGIN
            RAISERROR('El formato del email no es válido.', 16, 1)
            RETURN
        END

        -- Inserción
        INSERT INTO Clientes (DNI_Cliente, Nombre, Apellido, Direccion, CP, FechaNacimiento, Mail)
        VALUES (@DNI_Cliente, @Nombre, @Apellido, @Direccion, @CP, @FechaNacimiento, @Mail)

        PRINT 'Cliente agregado correctamente.'
        
    END TRY
    BEGIN CATCH
        PRINT ERROR_MESSAGE()
    END CATCH
END



