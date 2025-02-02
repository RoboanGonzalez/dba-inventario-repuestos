use inventario 
go 

if exists (select * from sysobjects where name = 'cliente')
begin
drop table cliente  
end 
CREATE TABLE Clientes (
    Id INT IDENTITY(1,1) PRIMARY KEY,
    Nombre NVARCHAR(100) NOT NULL,
    Telefono NVARCHAR(20),
    Email NVARCHAR(100),
    Direccion NVARCHAR(255)
);