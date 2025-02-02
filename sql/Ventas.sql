use inventario 
go 

if exists (select * from sysobjects where name = 'Ventas')
begin
drop table Ventas  
end 


CREATE TABLE Ventas (
    Id INT IDENTITY(1,1) PRIMARY KEY,
    Fecha DATETIME DEFAULT GETDATE(),
    ClienteId INT,
    Total DECIMAL(10, 2) NOT NULL
);