use inventario 
go 

if exists (select * from sysobjects where name = 'Proveedores')
begin
drop table Proveedores  
end 

CREATE TABLE Proveedores (
    Id INT IDENTITY(1,1) PRIMARY KEY,
    Nombre NVARCHAR(100) NOT NULL,
    Contacto NVARCHAR(50),
    Telefono NVARCHAR(20),
    Email NVARCHAR(100),
    Direccion NVARCHAR(255)
);