use inventario 
go 

if exists (select * from sysobjects where name = 'Piezas')
begin
drop table Piezas  
end 

CREATE TABLE Piezas (
    Id            INT IDENTITY(1,1) PRIMARY KEY,
    Codigo        VARCHAR(50) UNIQUE NOT NULL,       -- Código único de la pieza
    Nombre        VARCHAR(100) NOT NULL,             -- Nombre de la pieza
    Descripcion   VARCHAR(255),                 -- Descripción detallada

    Marca         VARCHAR(50),                        -- Marca del vehículo compatible
    Modelo        VARCHAR(50),                       -- Modelo del vehículo compatible
    Anio          INT,                                  -- Año del vehículo compatible
    Motor         VARCHAR(50),                        -- Especificaciones del motor

    Precio        DECIMAL(10, 2) NOT NULL,            -- Precio de la pieza
    Stock         INT DEFAULT 0,                       -- Cantidad disponible en inventario

    ProveedorId   INT,  -- Relación con la tabla Proveedores
    FechaIngreso  DATE DEFAULT GETDATE()        -- Fecha en que la pieza ingresó al inventario
);