use inventario 
go

IF EXISTS (SELECT 1 FROM sysobjects WHERE name = 'sp_DetalleVenta')
BEGIN
    DROP PROCEDURE sp_DetalleVenta
END
GO

CREATE PROCEDURE sp_DetalleVenta
    @i_Operacion      CHAR(1), 
    @i_Id             INT = NULL,
    @i_VentaId        INT = NULL,
    @i_PiezaId        INT = NULL,
    @i_Cantidad       INT = NULL,
    @i_PrecioUnitario DECIMAL(10, 2) = NULL
AS
    
    IF @i_Operacion = 'I'
    BEGIN
        INSERT INTO DetalleVenta (VentaId, PiezaId, Cantidad, PrecioUnitario)
        VALUES (@i_VentaId, @i_PiezaId, @i_Cantidad, @i_PrecioUnitario);
    END
    
    IF @i_Operacion = 'Q'
    BEGIN
        IF @i_Id IS NULL
            SELECT * FROM DetalleVenta;
        ELSE
            SELECT * FROM DetalleVenta WHERE Id = @i_Id;
    END
    


return 0
go