use inventario
go

if exists (select 1 
             from sysobjects 
            where name = 'sp_clientes')
begin
     drop procedure sp_clientes  
end 
go

create procedure sp_clientes
(
    @i_fecha_proceso datetime,
    @i_operacion     char(1),
    @i_Nombre        VARCHAR(100),
    @i_id            int = 0,
    @i_Telefono      VARCHAR(20) = null,
    @i_Email         VARCHAR(100) = null,
    @i_Direccion     VARCHAR(255) = null,
    @o_error         int = 0,
    @o_msj_error     varchar(500) = ''

)
as
declare @w_error     int,
        @w_msj_error varchar(500)

Select  @w_error     = 0,
        @w_msj_error = ''


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

if @i_operacion = 'I'
begin 
     insert into Clientes (
         Nombre,
         Telefono,
         Email,
         Direccion
     )
     values
     (
         @i_Nombre,
         @i_Telefono,
         @i_Email,
         @i_Direccion
     )

     if @@ERROR != 0
      begin 
           select @w_error = 1,
                  @w_msj_error = 'ERROR AL INSERTAR CLIENTE'
      end -- if @@ERROR != 0
end -- if @i_operacion = 'U'

if @i_operacion = 'U'
Begin 
     update Clientes
        set Nombre = @i_Nombre,
            Telefono = @i_Telefono,
            Email = @i_Email,
            Direccion = @i_Direccion
      where Id = @i_id
     
      if @@ERROR != 0
      begin 
           select @w_error = 2,
                  @w_msj_error = 'ERROR AL ACTUALIZAR CLIENTE'
      end -- if @@ERROR != 0
end -- if @i_operacion = 'U'

if @w_error != 0
begin 
select @o_error     = @w_error,
       @o_msj_error = @w_msj_error

end 

return @w_error
GO