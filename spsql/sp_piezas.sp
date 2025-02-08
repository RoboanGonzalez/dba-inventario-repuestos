use inventario
go 

if exists (select 1 from sysobjects where name = 'sp_piezas')
begin 
drop procedure sp_piezas
end 
go
create procedure sp_piezas
(
    @i_operacion      char(1),
    @i_Id             INT            = 0 ,
    @i_Codigo         VARCHAR(50)    = null ,       -- Codigo unico de la pieza
    @i_Nombre         VARCHAR(100)   = null ,       -- Nombre de la pieza
    @i_Descripcion    VARCHAR(255)   = null ,       -- Descripcion detallada
    @i_Marca          VARCHAR(50)    = null ,       -- Marca del vehiculo compatible
    @i_Modelo         VARCHAR(50)    = null ,       -- Modelo del vehiculo compatible
    @i_Anio           int            = 0, 
    @i_Motor          VARCHAR(50)    = null ,       -- Especificaciones del motor
    @i_Precio         DECIMAL(10, 2) = null ,       -- Precio de la pieza
    @i_Stock          INT            = 0    ,       -- Fecha en que la pieza ingreso al inventario
    @i_IdProveedor    int            = 0 
)
as

SELECT @i_Codigo         = UPPER(@i_Codigo     ),
       @i_Nombre         = UPPER(@i_Nombre     ),
       @i_Descripcion    = UPPER(@i_Descripcion),
       @i_Marca          = UPPER(@i_Marca      ),
       @i_Modelo         = UPPER(@i_Modelo     ),
       @i_Motor          = UPPER(@i_Motor      )
       

if @i_operacion = 'Q'
begin 

if @i_Codigo != ''
   begin 
        select 'ID'            = Id          ,
               'CODIGO'        = Codigo      ,
               'NOMBRE'        = Nombre      ,
               'DESCRIPCION'   = Descripcion ,
               'MARCA'         = Marca       ,
               'MODELO'        = Modelo      ,
               'ANIOAUTO'          = Anio        ,
               'MOTOR'         = Motor       ,
               'PRECIO'        = Precio      ,
               'STOCK'         = Stock       ,
               'PROVEEDORID'  = isnull(ProveedorId,0) ,
               'FECHAINGRESO'  = FechaIngreso
          from Piezas
         where Codigo          = @i_Codigo
    end 
           
if isnull(@i_Marca,'') != '' and isnull(@i_Modelo,'') != '' and isnull(@i_Anio,0) != 0 and isnull(@i_Nombre,'') != ''
   begin 
        select 'ID'            = Id          ,
               'CODIGO'        = Codigo      ,
               'NOMBRE'        = Nombre      ,
               'DESCRIPCION'   = Descripcion ,
               'MARCA'         = Marca       ,
               'MODELO'        = Modelo      ,
               'ANIOAUTO'      = Anio        ,
               'MOTOR'         = Motor       ,
               'PRECIO'        = Precio      ,
               'STOCK'         = Stock       ,
               'PROVEEDORID'  = isnull(ProveedorId,0) ,
               'FECHAINGRESO'  = FechaIngreso
          from Piezas
         where Marca           = @i_Marca
           and Modelo          = @i_Modelo
           and Anio            = @i_Anio
           and Nombre like '%' + @i_Nombre + '%'
   end 
                     
if isnull(@i_Nombre,'') != '' and isnull(@i_Modelo,'') = '' and isnull(@i_Anio,0) = 0 and isnull(@i_Marca,'') = ''
begin 

print 'entre'
    select 'ID'            = Id          ,
           'CODIGO'        = Codigo      ,
           'NOMBRE'        = Nombre      ,
           'DESCRIPCION'   = Descripcion ,
           'MARCA'         = Marca       ,
           'MODELO'        = Modelo      ,
           'ANIOAUTO'          = Anio        ,
           'MOTOR'         = Motor       ,
           'PRECIO'        = Precio      ,
           'STOCK'         = Stock       ,
           'PROVEEDORID'  = isnull(ProveedorId,0) ,
           'FECHAINGRESO'  = FechaIngreso
      from Piezas
     where Nombre like '%'+ @i_Nombre + '%'
end 

if isnull(@i_Motor,'') != '' 
begin 
    select 'ID'            = Id          ,
           'CODIGO'        = Codigo      ,
           'NOMBRE'        = Nombre      ,
           'DESCRIPCION'   = Descripcion ,
           'MARCA'         = Marca       ,
           'MODELO'        = Modelo      ,
           'ANIOAUTO'          = Anio        ,
           'MOTOR'         = Motor       ,
           'PRECIO'        = Precio      ,
           'STOCK'         = Stock       ,
           'PROVEEDORID'  = isnull(ProveedorId,0) ,
           'FECHAINGRESO'  = FechaIngreso
      from Piezas
     where Motor = @i_Motor
end -- if isnull(@i_Motor,'') != '' 

end -- if @i_operacion = 'Q'

if @i_operacion = 'I'
begin 
     INSERT INTO Piezas (
         Codigo, 
         Nombre, 
         Descripcion, 
         Marca, 
         Modelo, 
         Anio, 
         Motor, 
         Precio, 
         Stock, 
         ProveedorId
     )
     VALUES (      
         @i_Codigo     ,
         @i_Nombre     ,
         @i_Descripcion,
         @i_Marca      ,
         @i_Modelo     ,
         @i_Anio       ,
         @i_Motor      ,
         @i_Precio     ,
         @i_Stock      ,
         @i_IdProveedor 
     );

end -- if @i_operacion = 'I'

if @i_operacion = 'U'
begin 
     update Piezas
        set  Codigo        = isnull(@i_Codigo      , Codigo      )     , 
             Nombre        = isnull(@i_Nombre      , Nombre      )     , 
             Descripcion   = isnull(@i_Descripcion , Descripcion )     , 
             Marca         = isnull(@i_Marca       , Marca       )     , 
             Modelo        = isnull(@i_Modelo      , Modelo      )     , 
             Anio          = isnull(@i_Anio        , Anio        )     , 
             Motor         = isnull(@i_Motor       , Motor       )     , 
             Precio        = isnull(@i_Precio      , Precio      )     , 
             Stock         = isnull(@i_Stock       , Stock       ) 
    where id = @i_Id
end -- if @i_operacion = 'U'

if @i_operacion = 'D'
begin 
     delete Piezas
      where id = @i_Id
end -- if @i_operacion = 'D'

return 0
go