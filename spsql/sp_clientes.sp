use inventario
go

create procedure sp_clientes
(
    @i_fecha_proceso datetime,
    @i_operacion char(1),
    @i_Nombre NVARCHAR(100),
    @i_Telefono NVARCHAR(20) = null,
    @i_Email NVARCHAR(100) = null,
    @i_Direccion NVARCHAR(255) = null

)
as

if @i_operacion = 'Q'
begin 

select    'ID'         = Id,
          'NOMBRE'     = Nombre,
          'TELEFONO'   = Telefono,
          'EMAIL'      = Email,
          'DIRRECCION' = Direccion
from Clientes
where Nombre like @i_Nombre

end -- if @i_operacion = 'Q'



return 0
go