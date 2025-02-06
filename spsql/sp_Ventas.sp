use inventario
go

IF EXISTS (SELECT 1 FROM sysobjects WHERE name = 'sp_Ventas')
BEGIN
    DROP PROCEDURE sp_Ventas
END
GO

CREATE PROCEDURE sp_Ventas
    @i_Operacion CHAR(1), -- C para Crear, R para Leer, U para Actualizar, D para Eliminar
    @i_Id INT = NULL,
    @i_Fecha DATETIME = NULL,
    @i_ClienteId INT = NULL,
    @i_Total DECIMAL(10, 2) = NULL
AS
BEGIN
    SET NOCOUNT ON;
    
    IF @i_Operacion = 'C'
    BEGIN
        INSERT INTO Ventas (Fecha, ClienteId, Total)
        VALUES (ISNULL(@i_Fecha, GETDATE()), @i_ClienteId, @i_Total);
    END
    
    IF @i_Operacion = 'R'
    BEGIN
        IF @i_Id IS NULL
            SELECT * FROM Ventas;
        ELSE
            SELECT * FROM Ventas WHERE Id = @i_Id;
    END
END;
