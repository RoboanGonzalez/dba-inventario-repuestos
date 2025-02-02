CREATE TABLE Piezas (
    Id INT IDENTITY(1,1) PRIMARY KEY,
    Nombre NVARCHAR(100) NOT NULL,
    Codigo NVARCHAR(50) UNIQUE NOT NULL,
    Marca NVARCHAR(50),
    Modelo NVARCHAR(50),
    Descripcion NVARCHAR(255),
    Precio DECIMAL(10, 2) NOT NULL,
    Stock INT DEFAULT 0,
    ProveedorId INT ,
    FechaIngreso DATE DEFAULT GETDATE()
);