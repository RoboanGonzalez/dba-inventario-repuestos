use inventario 
go 

if exists (select * from sysobjects where name = 'Proveedores')
begin
drop table Proveedores  
end 

CREATE TABLE Proveedores (
    Id        INT IDENTITY(1,1) PRIMARY KEY,
    Nombre    VARCHAR(100) NOT NULL,
    Contacto  VARCHAR(50)   ,
    Telefono  VARCHAR(20)   ,
    Email     VARCHAR(100)  ,
    Direccion VARCHAR(255)
);