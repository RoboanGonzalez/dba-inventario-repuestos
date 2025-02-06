use inventario
go

if exists (select 1 from sysobjects where name = 'sp_proveedores')
begin

drop procedure sp_proveedores

end 
go

create procedure sp_proveedores
(
    @i_fecha_proceso datetime,
    @i_operacion     char(1),
    @i_Id            INT          = NULL,
    @i_Nombre        VARCHAR(100) = NULL,
    @i_Contacto      VARCHAR(50)  = NULL,
    @i_Telefono      VARCHAR(20)  = NULL,
    @i_Email         VARCHAR(100) = NULL,
    @i_Direccion     VARCHAR(255) = NULL,
    @o_error         INT          = 0 out,
    @o_msj_error     VARCHAR(255) = '' out
)
as

declare @w_error     int,
        @w_msj_error varchar(255)

select @w_error     = 0,
       @w_msj_error = ''


if @i_operacion = 'Q'
begin

select 'ID' = Id       ,
       'NOMBRE' = Nombre,   
       'CONTACTO' = Contacto, 
       'TELEFONO' = Telefono ,
       'EMAIL' = Email    ,
       'DIRECCION' = Direccion
from Proveedores
where nombre like @i_Nombre
end

if @i_operacion = 'I'
begin

insert into Proveedores
(
Nombre    ,
Contacto  ,
Telefono  ,
Email     ,
Direccion 
)
values
(  
@i_Nombre        ,
@i_Contacto      ,
@i_Telefono      ,
@i_Email         ,
@i_Direccion     
)
if @@ERROR != 0
begin 
Select @w_error = 1,
@w_msj_error = 'Error al insertar en la tabla Proveedores'
end

end -- if @i_operacion = 'I'

if @i_operacion = 'U'
begin

update Proveedores
set Nombre        =   isnull(@i_Nombre    ,Nombre   )   ,
Contacto      =   isnull(@i_Contacto  ,Contacto )   ,
Telefono      =   isnull(@i_Telefono  ,Telefono )   ,
Email         =   isnull(@i_Email     ,Email    )   ,
Direccion     =   isnull(@i_Direccion ,Direccion)   
where Id = @i_Id

end -- if @i_operacion = 'U'


if @i_operacion = 'D'
begin

delete Proveedores
where Id = @i_Id

end -- if @i_operacion = 'D'

if @w_error != 0
begin 
select @o_error = @w_error,
       @o_msj_error = @w_msj_error
end 

return @w_error
go