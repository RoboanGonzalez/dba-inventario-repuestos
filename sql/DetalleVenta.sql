CREATE TABLE DetalleVenta (
    Id INT IDENTITY(1,1) PRIMARY KEY,
    VentaId INT ,
    PiezaId INT ,
    Cantidad INT NOT NULL,
    PrecioUnitario DECIMAL(10, 2) NOT NULL,
    Subtotal AS (Cantidad * PrecioUnitario) PERSISTED
);