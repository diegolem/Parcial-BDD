USE master;
GO

IF EXISTS(SELECT * FROM sys.databases WHERE name='CollegeCentralAmerica_LaLibertad')
DROP DATABASE CollegeCentralAmerica_LaLibertad

--Creacion de la BDD
create database CollegeCentralAmerica_LaLibertad

use CollegeCentralAmerica_LaLibertad

--Creacion de tablas
Create table departamento(
idDepartamento int primary key IDENTITY(1,1) NOT NULL,
nombre varchar(100) NOT NULL,
descripcion varchar(250) NOT NULL 
)

Create table procesos(
idProceso int primary key IDENTITY(1,1) NOT NULL,
nombre varchar(30) NOT NULL,
duracion int NOT NULL,
idDepartamento int foreign key references departamento(idDepartamento)
)

Create table tipoCliente(
idTipo int primary key IDENTITY(1,1) NOT NULL,
nombre varchar(25) NOT NULL,
)
Create table clientes(
idCliente int primary key IDENTITY(1,1) NOT NULL,
nombre varchar(35) NOT NULL,
dui char(10) NOT NULL,
nit char(17) NOT NULL,
direccion varchar(150) NOT NULL,
telefono varchar(9) NOT NULL,
correo varchar(50) NOT NULL,
idTipo int foreign key references tipoCliente(idTipo)
)
Create table metodologia(
idMetodologia int primary key IDENTITY(1,1) NOT NULL,
nombre varchar(100) NOT NULL,
)

Create table modulo(
idModulo int primary key IDENTITY(1,1) NOT NULL,
nombre varchar(60) NOT NULL,
cantidadProduccion int NOT NULL,
idMetodologia int foreign key references metodologia(idMetodologia)
)

Create table factura(
idFactura int primary key IDENTITY(1,1) NOT NULL,
requiredDate date NOT NULL,
orderDate date NOT NULL,
finishedDate date NOT NULL,
shipmentDate date NOT NULL,
total money NULL,
direccion varchar(250) NOT NULL,
idCliente int foreign key references clientes(idCliente)
)
Create table tipoVariante(
idVariante int primary key IDENTITY(1,1) NOT NULL,
nombre varchar(25) NOT NULL
)
Create table detalles(
idDetalle int primary key IDENTITY(1,1) NOT NULL,
descripcion varchar(200) NOT NULL,
precio money NOT NULL,
idProceso int foreign key references procesos(idProceso)
)

Create table detalleVarianteDetalle(
idVariante int foreign key references tipoVariante(idVariante),
idDetalle int foreign key references detalles(idDetalle)
)

Create table flujoTrabajo(
idFlujo int primary key IDENTITY(1,1) NOT NULL,
idVariante int foreign key references tipoVariante(idVariante)
)
Create table detalleFlujoTrabajoProcesos(
idFlujo int foreign key references flujoTrabajo(idFlujo),
idProceso int foreign key references procesos(idProceso)
)
Create table estadoSeguimiento(
idEstadoSeguimiento int primary key IDENTITY(1,1) NOT NULL,
nombre varchar(25) NOT NULL
)
Create table estadoOrden(
idEstadoOrden int primary key IDENTITY(1,1) NOT NULL,
nombre varchar(25) NOT NULL
)
Create table prenda(
idPrenda int primary key IDENTITY(1,1) NOT NULL,
nombre varchar(100) NOT NULL,
precio money NOT NULL
)
Create table estilo(
idEstilo int primary key IDENTITY(1,1) NOT NULL,
codigo char(5) NOT NULL,
idPrenda int foreign key references prenda(idPrenda)
)

Create table tipoTalla(
idTipoTalla int primary key IDENTITY(1,1) NOT NULL,
nombre varchar(40) NOT NULL,
abreviacion char(4) NOT NULL
)
Create table tallaUbicacion(
idUbicacion int primary key IDENTITY(1,1) NOT NULL,
ubicacion varchar(50) NOT NULL
)

Create table talla(
idTalla int primary key IDENTITY(1,1) NOT NULL,
cantidadTela decimal(18, 2) NOT NULL,
idTipoTalla int foreign key references tipoTalla(idTipoTalla),
idPrenda int foreign key references prenda(idPrenda),
idEstilo int foreign key references estilo(idEstilo)
)
Create table medida(
idMedida int primary key IDENTITY(1,1) NOT NULL,
dimension decimal(18,2) NOT NULL,
idTalla int foreign key references talla(idTalla),
idUbicacion int foreign key references tallaUbicacion(idUbicacion)
)
Create table color(
idColor int primary key IDENTITY(1,1) NOT NULL,
nombre varchar(50) NOT NULL
)

Create table ordenVenta(
idOrdenVenta int primary key IDENTITY(1,1) NOT NULL,
monto money NOT NULL,
cantidad int NOT NULL,
idFactura int foreign key references factura(idFactura),
idEstilo int foreign key references estilo(idEstilo),
idFlujo int foreign key references flujoTrabajo(idFlujo),
idColor int foreign key references color(idColor),
idEstado int foreign key references estadoOrden(idEstadoOrden)
)


Create table ordenDeVentaTalla(
idOrdenVentaTalla int primary key IDENTITY(1,1) NOT NULL,
cantidad int NOT NULL,
cantidadExtra int NOT NULL,
cantidadTela decimal(18,2) NOT NULL,
idTalla int foreign key references talla(idTalla),
idModulo int foreign key references modulo(idModulo),
idOrdenVenta int foreign key references ordenVenta(idOrdenVenta)
)
Create table seguimientoOrden(
idSeguimiento int primary key IDENTITY(1,1) NOT NULL,
idEstado int foreign key references estadoSeguimiento(idEstadoSeguimiento),
idOrdenVenta int foreign key references ordenVenta(idOrdenVenta),
idProceso int foreign key references procesos(idProceso)
)
Create table tipoUnidadMedidas(
idTipoUnidad char(6) primary key NOT NULL,
nombre varchar(60) NOT NULL
)

Create Table tipoMateriaPrima(
idTipoMateriaPrima int primary key IDENTITY(1,1) NOT NULL,
nombre varchar(60) NOT NULL,
idMedicion char(6) foreign key references tipoUnidadMedidas(idTipoUnidad)
)

Create table estante(
idEstante char(1) primary key NOT NULL
)
Create table nivel(
idNivel int primary key IDENTITY(1,1) NOT NULL,
nivel int NOT NULL
)
Create table columna(
idColumna int primary key IDENTITY(1,1) NOT NULL,
columna int NOT NULL
)

Create table Compartimiento(
idCompartimiento char(3) primary key NOT NULL,
estado tinyint NOT NULL,
idEstante char(1) foreign key references estante(idEstante),
idNivel int foreign key references nivel(idNivel),
idColumna int foreign key references columna(idColumna)

)

Create table Proveedor(
idProveedor int primary key IDENTITY(1,1) NOT NULL,
nombre varchar(100) NOT NULL,
direccion varchar(200) NOT NULL,
telefono char(9) NOT NULL,
correo varchar(50) NOT NULL
)

Create table MateriaPrima(
idMateriaPrima int primary key IDENTITY(1,1) NOT NULL,
descripcion varchar(200) NOT NULL,
existencia decimal(18,2) NOT NULL,
stockMaximo decimal(18,2) NOT NULL,
idTipoMateriaPrima int foreign key references tipoMateriaPrima(idTipoMateriaPrima),
idCompartimiento char(3) foreign key references compartimiento(idCompartimiento) NOT NULL,
idColor int foreign key references color(idColor),
idProveedor int foreign key references proveedor(idProveedor)
)

Create table estadoCompras(
idEstadoCompras int primary key IDENTITY(1,1) NOT NULL,
nombre varchar(25) NOT NULL
)

Create Table compras(
idCompras int primary key IDENTITY(1,1) NOT NULL,
cantidad decimal(18,2) NOT NULL,
idEstado int foreign key references estadoCompras(idEstadoCompras),
idMateriaPrima int foreign key references materiaPrima(idMateriaPrima)
)

 --En la tabla procesos, la duración debe ser mayor a 0 y menor a 28
	ALTER TABLE procesos
	ADD CONSTRAINT chkduracion
	CHECK ((duracion > 0 ) AND (duracion < 28)) 
 --En cada campo donde posea teléfono que siga formato (XXXXXXX ó XXXX-XXX).
 
 --El campo código en Estilo debe ser: [A-Z]{2}[0-9]{3}, ademas debe ser unico
 	ALTER TABLE [estilo] ADD CONSTRAINT chkCodigoEstilo CHECK (codigo LIKE '%[A-Z][A-Z][0-9][0-9][0-9]%')
	
	ALTER TABLE estilo 
	ADD CONSTRAINT uCodigo UNIQUE (codigo)
	
--Campos emails o de correo electrónico deben ser únicos.
	ALTER TABLE clientes
	ADD CONSTRAINT uCorreo UNIQUE (correo)
	ALTER TABLE clientes ADD CONSTRAINT CHK_Cliente_Correo CHECK (correo LIKE '%_@__%.__%');

	ALTER TABLE proveedor
	ADD CONSTRAINT uCorreoP UNIQUE (correo)
	ALTER TABLE proveedor ADD CONSTRAINT CHK_Proveedor_Correo CHECK (correo LIKE '%_@__%.__%');
--Campo abreviacion debe ser unico
	ALTER TABLE tipoTalla
	ADD CONSTRAINT uAbreviacion UNIQUE (abreviacion)
--En todas las tabas que se tenga un total o cantidad deben ser mayores a 0.
	ALTER TABLE modulo
	ADD CONSTRAINT chkCantidadProduccion
	CHECK (cantidadProduccion > 0)

	ALTER TABLE ordenDeVentaTalla
	ADD CONSTRAINT chkCantidad
	CHECK (cantidad > 0)

	ALTER TABLE ordenDeVentaTalla
	ADD CONSTRAINT chkCantidadExtra
	CHECK (cantidadExtra > 0)

	ALTER TABLE ordenDeVentaTalla
	ADD CONSTRAINT chkCantidadTela
	CHECK (cantidadTela > 0)

	ALTER TABLE materiaPrima
	ADD CONSTRAINT chkStockMaximo
	CHECK (stockMaximo > 0)

	ALTER TABLE talla
	ADD CONSTRAINT chkCantidadTelaTalla
	CHECK (cantidadTela > 0)

	ALTER TABLE compras
	ADD CONSTRAINT chkCantidadCompra
	CHECK (cantidad > 0)

	--Nivel y columna (campos nivel y columna respectivamente) deben ser números mayores a 0 y únicos.
	ALTER TABLE nivel
	ADD CONSTRAINT chkNivel
	CHECK (nivel > 0)

	ALTER TABLE columna
	ADD CONSTRAINT chkColumna
	CHECK (columna > 0)

	--En la tabla estante en id, solo debe aceptar de la A – Z.
	ALTER TABLE [estante] ADD CONSTRAINT chkIdEstante CHECK (idEstante LIKE '[A-Z]')

	--En cada campo donde posea teléfono que siga formato (XXXXXXX ó XXXX-XXX).
	ALTER TABLE clientes
	ADD CONSTRAINT chkTelefono
	CHECK( telefono LIKE '%[267][0-9][0-9][0-9][-][0-9][0-9][0-9][0-9]%')

	ALTER TABLE proveedor
	ADD CONSTRAINT chkTelefonoP
	CHECK (telefono LIKE '%[267][0-9][0-9][0-9][-][0-9][0-9][0-9][0-9]%')

	ALTER TABLE clientes
	ADD CONSTRAINT UTelefono
	UNIQUE(telefono)

	ALTER TABLE proveedor
	ADD CONSTRAINT UTelefonoP
	UNIQUE(telefono)

-- Nombres

	ALTER TABLE departamento
	ADD CONSTRAINT CHK_departamento_nombre
	CHECK (nombre NOT LIKE '%[^a-z]%');

	ALTER TABLE tipoCliente
	ADD CONSTRAINT CHK_tipocliente_nombre
	CHECK (nombre NOT LIKE '%[^a-z]%');

	ALTER TABLE metodologia
	ADD CONSTRAINT CHK_metodologia_nombre
	CHECK (nombre NOT LIKE '%[^a-z]%');

	ALTER TABLE estadoOrden
	ADD CONSTRAINT CHK_estadoOrden_nombre
	CHECK (nombre NOT LIKE '%[^a-z]%');

	ALTER TABLE tipoVariante
	ADD CONSTRAINT CHK_tipoVariante_nombre
	CHECK (nombre NOT LIKE '%[^a-z]%');

	ALTER TABLE estadoCompras
	ADD CONSTRAINT CHK_estadoCompras_nombre
	CHECK (nombre NOT LIKE  '%[^a-z]%');

	ALTER TABLE estadoSeguimiento
	ADD CONSTRAINT CHK_estadoSeguimiento_nombre
	CHECK (nombre NOT LIKE '%[^a-z]%');

--Creaccion de Esquemas
create schema Venta;
create schema Compra;
create schema Produccion;
create schema Bodega;
create schema Producto;

--Asignacion de Tablas a su respectivo Esquema
ALTER SCHEMA Venta TRANSFER object::dbo.tipoCliente
ALTER SCHEMA Venta TRANSFER object::dbo.clientes
ALTER SCHEMA Venta TRANSFER object::dbo.factura

ALTER SCHEMA Compra TRANSFER object::dbo.compras
ALTER SCHEMA Compra TRANSFER object::dbo.estadoCompras
ALTER SCHEMA Compra TRANSFER object::dbo.proveedor

ALTER SCHEMA Produccion TRANSFER object::dbo.seguimientoOrden
ALTER SCHEMA Produccion TRANSFER object::dbo.ordenDeVentaTalla
ALTER SCHEMA Produccion TRANSFER object::dbo.ordenVenta
ALTER SCHEMA Produccion TRANSFER object::dbo.estadoSeguimiento
ALTER SCHEMA Produccion TRANSFER object::dbo.detalleFlujoTrabajoProcesos 
ALTER SCHEMA Produccion TRANSFER object::dbo.flujoTrabajo
ALTER SCHEMA Produccion TRANSFER object::dbo.detalleVarianteDetalle
ALTER SCHEMA Produccion TRANSFER object::dbo.detalles
ALTER SCHEMA Produccion TRANSFER object::dbo.tipoVariante
ALTER SCHEMA Produccion TRANSFER object::dbo.modulo
ALTER SCHEMA Produccion TRANSFER object::dbo.metodologia
ALTER SCHEMA Produccion TRANSFER object::dbo.procesos
ALTER SCHEMA Produccion TRANSFER object::dbo.departamento
ALTER SCHEMA Produccion TRANSFER object::dbo.estadoOrden

ALTER SCHEMA Bodega TRANSFER object::dbo.tipoUnidadMedidas
ALTER SCHEMA Bodega TRANSFER object::dbo.tipoMateriaPrima
ALTER SCHEMA Bodega TRANSFER object::dbo.estante
ALTER SCHEMA Bodega TRANSFER object::dbo.nivel
ALTER SCHEMA Bodega TRANSFER object::dbo.compartimiento 
ALTER SCHEMA Bodega TRANSFER object::dbo.materiaPrima
ALTER SCHEMA Bodega TRANSFER object::dbo.columna
 
ALTER SCHEMA Producto TRANSFER object::dbo.prenda
ALTER SCHEMA Producto TRANSFER object::dbo.estilo
ALTER SCHEMA Producto TRANSFER object::dbo.tipoTalla
ALTER SCHEMA Producto TRANSFER object::dbo.tallaUbicacion
ALTER SCHEMA Producto TRANSFER object::dbo.talla
ALTER SCHEMA Producto TRANSFER object::dbo.medida

-- Vistas
--1. Vista completa de los productos de inventario.
	CREATE VIEW productos AS	
		SELECT MT.nombre AS [Tipo de Producto], M.Descripcion AS [Producto] 
		FROM Bodega.MateriaPrima M 	
		INNER JOIN Bodega.TipoMateriaPrima MT ON M.idTipoMateriaPrima = MT.idTipoMateriaPrima
	;
-- 2. Vista completa de los trabajos en proceso.
	CREATE VIEW trabajosProceso AS	
		SELECT O.cantidad AS [Cantidad], O.monto AS  [Monto ($)], C.nombre AS [Cliente]	, F.idFactura AS [Factura (ID)]
		FROM Produccion.OrdenVenta O INNER JOIN Produccion.estadoOrden E ON O.idEstado = E.idEstadoOrden	
		INNER JOIN Venta.Factura F ON O.idFactura = F.idFactura	
		INNER JOIN Venta.Clientes C ON F.idCliente	= C.idCliente	WHERE E.idEstadoOrden = 2
	; --Por ejemplo si en el id 2 es "En proceso";
-- 3. Vista de los trabajos que aún no han sido implementados.
	CREATE VIEW trabajosPendientes AS	
		SELECT O.cantidad AS [Cantidad], O.monto AS  [Monto ($)], C.nombre AS [Cliente]	
		FROM Produccion.OrdenVenta O 
		INNER JOIN Produccion.estadoOrden E ON O.idEstado = E.idEstadoOrden	
		INNER JOIN Venta.Factura F ON O.idFactura = F.idFactura	
		INNER JOIN Venta.Clientes C ON F.idCliente	= C.idCliente	WHERE E.idEstadoOrden = 3
; --Por ejemplo si en el id 1 es "pendiente";
-- 4. Vista de los productos que están en fase de desabastecimiento junto con los proveedores y sus
--    datos de contacto.
	CREATE VIEW productosNecesitados AS	
		SELECT MP.descripcion AS [Producto], P.nombre AS [Proveedor], P.telefono, P.correo	
		FROM Compra.compras C 
		INNER JOIN Compra.estadoCompras EC ON C.idEstado = EC.idEstadoCompras	
		INNER JOIN Bodega.MateriaPrima MP ON C.idMateriaPrima = MP.idMateriaPrima 
		INNER JOIN Compra.Proveedor P ON	MP.idProveedor = P.idProveedor WHERE EC.idEstadoCompras != 3
	; -- Donde 1 es 'Realizada', los otros pueden ser 'urgente'etc.;
-- 5. Vista de total piezas que se han trabajado por módulo, agrupadas por medio de su categoría.
	CREATE VIEW piezasModulo AS
		SELECT P.idPrenda, P.nombre AS [Categoría], M.nombre AS [Módulo], COUNT(*) AS [Cantidad] 
		FROM Produccion.ordenDeVentaTalla OT 
		INNER JOIN Produccion.modulo M ON OT.idModulo = M.idModulo
		INNER JOIN Producto.talla T ON OT.idTalla = T.idTalla 
		INNER JOIN Producto.prenda P ON P.idPrenda = T.idPrenda
		GROUP BY P.idPrenda, P.nombre, M.nombre
	;
-- 6. Vista de total de compras realizadas por clientes a lo largo de cada año.
	CREATE VIEW comprasCliente AS	
		SELECT F.idCliente, C.nombre, COUNT(*) AS [Compras], DATEPART(yyyy, F.orderDate) AS [Año]
		FROM Venta.Factura F 
		INNER JOIN Venta.Clientes C ON F.idCliente = C.idCliente	
		GROUP BY F.idCliente, C.nombre, DATEPART(yyyy, F.orderDate)
	;
-- 7. Vista de Trabajos y Sales Orders asignadas a cada módulo.
	CREATE VIEW ordenModulos AS
		SELECT M.idModulo, M.nombre, COUNT(*) AS [Ordenes Asignadas] FROM Produccion.ordenVenta OV
		INNER JOIN Produccion.ordenDeVentaTalla OVT ON OV.idOrdenVenta = OVT.idOrdenVentaTalla
		INNER JOIN Produccion.modulo M ON OVT.idModulo = M.idModulo
		GROUP BY M.idModulo, M.nombre
	;
-- 8. Vista de Telas (Todos los datos junto con el nombre del proveedor) en Inventario.
-- 9. Vista de Hilos (Todos los datos junto con el nombre del proveedor) en inventario.
-- 10. Vista de Cordones (Todos los datos junto con el nombre del proveedor) en inventario.
-- 11. Vista de las Sales Order con categoría BLANKS.
-- 12. Vista de las Sales Order con categoría SCREEN PRINTING.
-- 13. Vista de las Sales Order con categoría Sublimation.
-- 14.  Vista de las Sales Order que tienen un tiempo de retraso en la fecha de Finalización.
-- Creacion de errores //////////////////////////////////////////////////////////////////////////////
exec sp_dropmessage 50018
exec sp_dropmessage 50019
exec sp_dropmessage 50020

exec sp_addmessage 50018, 20,  N'No se puede actualizar el estado pues el proceso anterior no ha sido completado', 'us_english'
exec sp_addmessage 50019, 21,  N'No se puede seleccionar un processo que no sea de la misma variante', 'us_english'
exec sp_addmessage 50020, 22,  N'No existe la suficiente tela para la ordeb', 'us_english'

-- TRIGGERS /////////////////////////////////////////////////////////////////////////////////////////////////////////////
--Trigger #1
    /*Deberán de validar todas aquellas transacciones dentro de la base de datos de manera que las
    operaciones tales como las compras del material, y los datos relativos a las Sales Orders sean
    coherentes, independientemente se trate de una inserción o de una actualización*/
CREATE TRIGGER verificarComprasInsert
	ON Compra.compras
	AFTER INSERT
	AS
    BEGIN
        DECLARE
            @verificarCantidad DECIMAL(18,2),
            @idMateria INT
        BEGIN
            SELECT @verificarCantidad = cantidad FROM inserted
            SELECT @idMateria = idMateriaPrima FROM inserted
            --Ingreso de datos
            IF (@verificarCantidad < 0)
            BEGIN
                PRINT 'La cantidad no debe ser menor a 0'
                ROLLBACK TRAN
            END
        END
	END
GO
	
--Verificar la modificacion de la cantidad
CREATE TRIGGER verificarComprasUpdate
	ON Compra.compras
	FOR UPDATE
	AS
	DECLARE @cantidad DECIMAL(18,2)
	BEGIN
		IF UPDATE(cantidad)
		SELECT @cantidad = cantidad FROM inserted
		BEGIN
			IF(@cantidad < 0)
			BEGIN
				PRINT 'La cantidad no debe ser menor a 0'
				ROLLBACK TRAN
			END
		END
	END
GO
--Verificar datos de Sales Order
CREATE TRIGGER verificarSalesOrderInsert ON Produccion.ordenVenta
FOR INSERT AS
	DECLARE @monto MONEY, @cantidad DECIMAL(18,2), @factura INT, @estilo INT, @flujo INT, @color INT, @estado INT
	BEGIN
		SELECT @monto = monto FROM inserted
		SELECT @cantidad = cantidad FROM inserted
		SELECT @factura = idFactura FROM inserted
		SELECT @estilo = idEstilo FROM inserted
		SELECT @flujo = idFlujo FROM inserted
		SELECT @color = idColor FROM inserted
		SELECT @estado = idEstado FROM inserted
	IF(@cantidad < 0)
	BEGIN
		PRINT 'La cantidad no debe ser menor a 0'
		ROLLBACK TRAN
	END
	IF(@monto < 0)
	BEGIN
		PRINT 'El monto no puede ser menor que 0'
		ROLLBACK TRAN
	END
END
GO
--Verificar Sales Order Update 
CREATE TRIGGER verificarSalesOrderUpdate
	ON Produccion.ordenVenta
	FOR Update
	AS
	DECLARE
		@monto MONEY,
		@cantidad DECIMAL(18,2)
	BEGIN
		IF UPDATE(monto)
		SELECT @monto = monto FROM inserted
		BEGIN
			IF(@monto < 0)
			BEGIN
				PRINT 'El monto no debe ser menor a 0'
				ROLLBACK TRAN
			END
		END
		IF UPDATE(cantidad)
		BEGIN
			SELECT @cantidad = cantidad FROM inserted
			BEGIN
				IF(@cantidad < 0)
				BEGIN
					PRINT 'La cantidad no puede ser menor a 0'
					ROLLBACK TRAN
				END
			END
		END
	END
GO

/*
	Se deberá de validar mediante Triggers, que, el flujo de trabajo se cumpla de manera
	secuencial, es decir, no se podrá actualizar el estado de una Sales Order A MENOS que todos
	los pasos anteriores hayan sido completados, por ejemplo: En el flujo mostrado a continuación,
	no se puede actualizar el estado Packing Ready a menos que se hayan completado de forma
	satisfactoria los estos Screen Printing y Quality Assurance.
*/
--TRIGGER #2
create trigger actualizar_EstadoOrden
on Produccion.SeguimientoOrden
after update
as
	-- Informacion sobre la fila a modificar
	declare @id int, @id_orden int, @primer_proceso bit, @ultimo_proceso bit, @proceso_completado bit = 0, @completo varchar(25) = 'Finalizado'
	
	select @id = inserted.idSeguimiento, @id_orden = inserted.idOrdenVenta 
	from inserted

	-- Obtenemos la informacion sobre el proceso
	select top 1 @primer_proceso = (case when Produccion.SeguimientoOrden.idSeguimiento = @id then 1 else 0 end) 
	from Produccion.SeguimientoOrden 
	where Produccion.SeguimientoOrden.idOrdenVenta = @id_orden 
	order by Produccion.SeguimientoOrden.idSeguimiento asc

	select top 1 @ultimo_proceso = (case when Produccion.SeguimientoOrden.idSeguimiento = @id then 1 else 0 end) 
	from Produccion.SeguimientoOrden 
	where Produccion.SeguimientoOrden.idOrdenVenta = @id_orden 
	order by Produccion.SeguimientoOrden .idSeguimiento desc

	-- Revisamos que elementos es el actual
	if @ultimo_proceso = 1 -- en caso de que el proseco a modificar sea el ultimo
	begin
		select top 1  @proceso_completado = (case when Produccion.estadoSeguimiento.nombre = @completo then 1 else 0 end) 
		from (
			select top 2 Produccion.SeguimientoOrden.idSeguimiento, Produccion.SeguimientoOrden.idEstado 
			from Produccion.SeguimientoOrden 
			where Produccion.SeguimientoOrden.idOrdenVenta = @id_orden 
			order by Produccion.SeguimientoOrden.idSeguimiento desc) as orde 
		inner join Produccion.estadoSeguimiento 
		on Produccion.estadoSeguimiento.idEstadoSeguimiento = orde.idEstado 
		order by orde.idSeguimiento asc
	end

	if @primer_proceso = 0 and @ultimo_proceso = 0 -- en caso que no sea elultimo
	begin
		-- Se obtiene el indice de la fila anterior de todo el registro
		declare @fila_anterior int = -1, @estado_anterior varchar(25) = ''
		
		select @fila_anterior = (case when Produccion.SeguimientoOrden.idSeguimiento = @id then row_number() over(order by Produccion.SeguimientoOrden.idSeguimiento) else @fila_anterior end) 
		from Produccion.SeguimientoOrden 
		where Produccion.SeguimientoOrden.idOrdenVenta = @id_orden
		
		-- Se obtiene el estado de la fila anterior
		select @estado_anterior = (case when row_number() over(order by Produccion.SeguimientoOrden.idSeguimiento) = @fila_anterior then Produccion.estadoSeguimiento.nombre else @estado_anterior end) 
		from Produccion.SeguimientoOrden 
		inner join Produccion.estadoSeguimiento 
		on Produccion.estadoSeguimiento.idEstadoSeguimiento = Produccion.SeguimientoOrden.idEstado 
		where Produccion.SeguimientoOrden.idOrdenVenta = @id_orden

		-- Comprobamos que el estado anterior sea completado
		set @proceso_completado = case when @estado_anterior = @completo then 1 else 0 end
	end

	if @proceso_completado = 0
	begin
		ROLLBACK TRANSACTION
		RAISERROR(50019,21,1)
	end
go

/* En el momento de realizar la asignación de telas para las Sales Order, la tela que se asigna
deberá de descontarse del inventario para evitar conflictos en los próximos pedidos.
*/
--Triggers #3
CREATE TRIGGER descontarTela
	ON Produccion.ordenVenta
	FOR UPDATE	
	AS
	DECLARE @tela decimal(18,2),@color int,@id int,@existencia decimal(18,2)
	BEGIN
		SELECT @tela = ovt.cantidadTela FROM Produccion.ordenDeVentaTalla AS ovt INNER JOIN Produccion.ordenVenta AS odv
		ON odv.idOrdenVenta = ovt.idOrdenVenta
		SELECT @color = idColor FROM inserted
		IF(@tela > -1)
		BEGIN
			SELECT @existencia = existencia FROM Bodega.MateriaPrima AS mp INNER JOIN Bodega.tipoMateriaPrima AS tmp
			ON tmp.idTipoMateriaPrima = mp.idTipoMateriaPrima WHERE tmp.nombre = 'Tela' AND mp.idColor = @color
			if(@tela < @existencia)
			BEGIN
			UPDATE mp SET existencia = (existencia - @tela) FROM Bodega.MateriaPrima AS mp INNER JOIN Bodega.tipoMateriaPrima
			AS tmp ON tmp.idTipoMateriaPrima = mp.idTipoMateriaPrima WHERE idColor = @color AND tmp.nombre = 'Tela'
			PRINT 'Las existencias de tela se han actualizado'
			END
			ELSE
			BEGIN
				PRINT 'La cantidad de tela sobrepasa las existencias'
				ROLLBACK TRAN
			END
		END
		ELSE
		BEGIN
			PRINT 'Porfavor revise el valor de la cantidad de Tela de la orden'
			ROLLBACK TRAN
		END
	END
GO

/*Se deberá verificar que para cada uno de los pedidos, los únicos cambios que serán admisibles
en la fecha de adquisición siempre y cuando esto sea en una fecha POSTERIOR a la
establecida (Esto pues, porque un cambio a un tiempo menor afectaría todos los tiempos de
trabajo de la empresa).
*/
--Trigger #4
CREATE TRIGGER fechaFinalizacionUpdate
	on Venta.factura
	AFTER UPDATE
	AS DECLARE @fechaI DATE,@fechaD DATE,@id INT,@idR INT
	BEGIN
		select @fechaI = requiredDate,@idR = idFactura from inserted
		select @id = idFactura from Venta.factura where idFactura = @idR
		select @fechaD = requiredDate from deleted WHERE idFactura = @id
		IF UPDATE(requiredDate)
		BEGIN
			IF(@fechaI > @fechaD)
			BEGIN
				UPDATE Venta.factura SET requiredDate = @fechaI WHERE idFactura = @idR
			END	
			ELSE
			BEGIN
				PRINT 'Le fecha modificada no puede ser menos a la que se tenia anteriormente'
				ROLLBACK TRAN
			END
		END
	END
GO
/*Para el proceso de las compras, la cantidad de producto a comprar junto con el de bodega NO
PUEDE sobrepasar el límite del Stock Máximo que Maneja la empresa (7500 YDS para la tela).
*/
--TRIGGER #5
CREATE TRIGGER StockMaximoCompras on Compra.compras
AFTER INSERT
AS 
	DECLARE @cantidadM DECIMAL(18,2),@compra decimal(18,2),@stockmax decimal(18,2), @idM int,@bodega decimal(18,2),@sumatoria decimal(18,2),@idEstado INT
	BEGIN
		SELECT @compra = cantidad FROM inserted
		SELECT @idM = idMateriaPrima FROM inserted
		SELECT @idEstado = idEstado FROM inserted
		SELECT @stockmax = stockMaximo FROM Bodega.MateriaPrima WHERE idMateriaPrima = @idM
		SELECT @bodega = existencia FROM Bodega.MateriaPrima WHERE idMateriaPrima = @idM
		SET @sumatoria = @compra + @bodega
		IF(@sumatoria > @stockmax)
		BEGIN
			PRINT 'La compra sobrepasa los valores del almacenamiento máximo'
			ROLLBACK TRAN
		END
		ELSE
		BEGIN
			IF(@idEstado = 3)
			BEGIN
				UPDATE Bodega.MateriaPrima SET existencia = (@bodega + @compra) WHERE idMateriaPrima = @idM
				PRINT 'La materia prima comprada se agrego exitosamente'
			END
		END
	END
GO
/*
	Se debe verificar que por ejemplo, si una Sales Order ha sido Catalogada como Blanks, el
	workflow que se va a asignar no contenga ningún proceso especial de sublimado o serigrafía, lo
	mismo aplica para las demás categorías co
*/
--TRIGGER #6
create trigger comprobar_copatibilidadProcesosFlujo
on Produccion.detalleFlujoTrabajoProcesos
after insert, update
as
	-- Obtenemos el proceso a que hacemos mencion
	declare @id_proceso int, @id_variante int
	
	select @id_proceso = inserted.idProceso, @id_variante = flujoTrabajo.idVariante 
	from inserted 
	inner join Produccion.flujoTrabajo 
	on Produccion.flujoTrabajo.idFlujo = inserted.idFlujo
	
	-- Obtenemos si hay un ralacion con el detalle
	declare @cantidad_detalle int = 0

	select @cantidad_detalle = count(*) 
	from Produccion.Detalles 
	where Produccion.Detalles.idProceso = @id_proceso

	-- Comprobamos que el proceso posea detalles
	if @cantidad_detalle > 0
	begin
		declare @coincide_variante bit = 0

		select @coincide_variante = (case when Produccion.detalleVarianteDetalle.idVariante = @id_variante then 1 else @coincide_variante end) 
		from Produccion.Detalles 
		inner join Produccion.detalleVarianteDetalle 
		on Produccion.detalleVarianteDetalle.idDetalle = Produccion.Detalles.idDetalle 
		where Produccion.Detalles.idProceso = @id_proceso
		
		if @coincide_variante = 0
		begin
			ROLLBACK TRANSACTION
			RAISERROR(50018,20,1)
		end
	end
go
/*Deberá verificarse también que por ejemplo, no sean asignados dos estampados en la misma
zona a una misma Sales Order*/
--Trigger #7
CREATE TRIGGER verificarEstampado ON Produccion.detalleVarianteDetalle
FOR INSERT
AS
	DECLARE @idVariante INT,@detalleID INT
	BEGIN
		SELECT @idVariante = idVariante FROM inserted
		SELECT @detalleID = idDetalle FROM inserted
		IF (SELECT COUNT(*) FROM Produccion.detalleVarianteDetalle WHERE idDetalle = @detalleID AND idVariante = @idVariante) > 1
		BEGIN
				PRINT 'Ya hay un estampado en esta ubicacion para esta orden'
				ROLLBACK TRAN
		END
		ELSE
		BEGIN
			PRINT 'La variante fue agregada correctamente'
		END
	END
GO
CREATE TRIGGER verificarCompartimiento ON Bodega.MateriaPrima
FOR INSERT
AS
	DECLARE @idCompartimiento CHAR(3),@idMateriaPrima INT
	SELECT @idCompartimiento = idCompartimiento FROM inserted
	IF(SELECT estado FROM Bodega.Compartimiento WHERE idCompartimiento = @idCompartimiento) = 0
	BEGIN
		PRINT 'El compartimiento esta disponible'
		UPDATE Bodega.Compartimiento SET estado = 2 WHERE idCompartimiento = @idCompartimiento
	END
	ELSE IF(SELECT estado FROM Bodega.Compartimiento WHERE idCompartimiento = @idCompartimiento) = 1
	BEGIN
		PRINT 'El compartimiento ya esta ocupado'
		ROLLBACK TRAN
	END
GO
-- Funciones /////////////////////////////////////////////////////////////////////////////////////////////////
create function Produccion.getPiezasExtras(@piezas int) RETURNS int
as
begin
	declare @count int = 0
   if @piezas < 0
	begin
		set @count = 0
	end

	if @piezas > 0 and @piezas <= 20
	begin
		set @count = 1
	end

	if @piezas > 20 and @piezas <= 40
	begin
		set @count = 2
	end

	if @piezas > 40 and @piezas <= 60
	begin
		set @count = 3
	end

	if @piezas > 60 and @piezas <= 80
	begin
		set @count = 4
	end

	if @piezas > 80
	begin
		set @count = 5
	end

	return @count
end
GO
create procedure Produccion.obtenerPiezasExtras @piezas int
as
	if @piezas < 0
	begin
		return 0
	end

	if @piezas > 0 and @piezas <= 20
	begin
		return 1
	end

	if @piezas > 20 and @piezas <= 40
	begin
		return 2
	end

	if @piezas > 40 and @piezas <= 60
	begin
		return 3
	end

	if @piezas > 60 and @piezas <= 80
	begin
		return 4
	end

	if @piezas > 80
	begin
		return 5
	end
go
-- Procedimientos Almacenados ////////////////////////////////////////////////////////////////////////////

/*Como parte de la estrategia de seguridad de la base de datos, se busca que los procesos de inserción
y modificación de los datos sea manejado por los procedimientos almacenados para los cuales debe
tener que deben ser creados para TODAS LAS TABLAS que se crean en la base de datos*/

--PROCEDURE de INSERT para TODAS las tablas
--Tabla Produccion.departamento
CREATE PROC Produccion.agregarDepartamento
@nombre VARCHAR(100),@descripcion VARCHAR(250)
AS
	iF NOT EXISTS(SELECT * FROM Produccion.departamento WHERE nombre = @nombre AND descripcion = @descripcion)
	BEGIN
		INSERT INTO Produccion.departamento VALUES(@nombre,@descripcion)
		PRINT 'Departamento ingresado correctamente'
	END
	ELSE
	BEGIN
		PRINT 'El departamento ya existe'
		ROLLBACK TRAN
	END
GO
--Tabla Produccion.procesos
CREATE PROC Produccion.agregarProcesos
@nombre VARCHAR(30),@duracion INT,@idDepartamento INT
AS
	IF(@duracion > 0)
	BEGIN
		INSERT INTO Produccion.procesos VALUES(@nombre,@duracion,@idDepartamento)
		PRINT 'Proceso ingresado correctamente'
	END
	ELSE
	BEGIN
		PRINT 'La duracion del proceso no puede ser negativa'
		ROLLBACK TRAN
	END
GO
--Tabla Venta.tipoCliente
CREATE PROC Venta.agregarTipoCliente
@nombre VARCHAR(25)
AS
	IF NOT EXISTS(SELECT * FROM Venta.tipoCliente WHERE nombre = @nombre)
	BEGIN
		INSERT INTO Venta.tipoCliente VALUES(@nombre)
		PRINT 'Tipo de cliente ingresado correctamente'
	END
	ELSE
	BEGIN
		PRINT 'El tipo de cliente ya existe'
		ROLLBACK TRAN
	END
GO
--Tabla Venta.clientes
--En caso de ser Tipo: Persona
CREATE PROC Venta.agregarClientePersona
@nombre VARCHAR(35),@dui CHAR(10),@nit CHAR(17),@direccion VARCHAR(150),@telefono VARCHAR(9),
@correo VARCHAR(50),@idTipo INT
AS
	IF NOT EXISTS(SELECT * FROM Venta.clientes WHERE nombre = @nombre AND dui = @dui AND nit = @nit AND telefono = @telefono AND correo = @correo AND idTipo = @idTipo)
	BEGIN
		IF(@dui LIKE '%[0-9][0-9][0-9][0-9][0-9][0-9][0-9][-][0-9]%')
		BEGIN
			IF(@nit LIKE '%[0-9][0-9][0-9][0-9][-][0-9][0-9][0-9][0-9][0-9][0-9][-][0-9][0-9][0-9][-][0-9]%')
			BEGIN
				INSERT INTO Venta.clientes VALUES(@nombre,@dui,@nit,@direccion,@telefono,@correo,@idTipo)
				PRINT 'Cliente registrado correctamente'
			END
			ELSE
			BEGIN
				PRINT 'ingrese un NIT valido 0000-000000-000-0'
				ROLLBACK TRAN
			END
		END
		ELSE
		BEGIN
			PRINT 'Ingrese un formato de DUI valido 00000000-0'
			ROLLBACK TRAN
		END
	END
	ELSE
	BEGIN
		PRINT 'El cliente ya esta registrado'
		ROLLBACK TRAN
	END
GO
--En caso de ser Tipo: Empresa
CREATE PROC Venta.agregarClienteEmpresa
@nombre VARCHAR(35),@direccion VARCHAR(150),@telefono VARCHAR(9),
@correo VARCHAR(50),@idTipo INT
AS
	DECLARE @dui VARCHAR(10),@nit VARCHAR(14)
	SET @dui = '-'
	SET @nit = '-'
	IF NOT EXISTS(SELECT * FROM Venta.clientes WHERE nombre = @nombre AND dui = @dui AND nit = @nit AND telefono = @telefono AND correo = @correo AND idTipo = @idTipo)
	BEGIN
		INSERT INTO Venta.clientes VALUES(@nombre,@dui,@nit,@direccion,@telefono,@correo,@idTipo)
		PRINT 'Cliente registrado correctamente'
	END
	ELSE
	BEGIN
		PRINT 'El cliente ya esta registrado'
		ROLLBACK TRAN
	END
GO
--Tabla Produccion.metodologia
CREATE PROC Produccion.agregarMetodologia
@nombre VARCHAR(100)
AS
	IF NOT EXISTS(SELECT * FROM Produccion.metodologia WHERE nombre = @nombre)
	BEGIN
		INSERT INTO Produccion.metodologia VALUES(@nombre)
		PRINT 'La metodologia se ingreso correctamente'
	END
	ELSE
	BEGIN
		PRINT 'La metodologia ya existe'
		ROLLBACK TRAN
	END
GO
--Tabla Produccion.modulo
CREATE PROC Produccion.agregarModulo
@nombre VARCHAR(60),@cantidadProduccion INT,@idMetodologia INT
AS
	IF NOT EXISTS(SELECT * FROM Produccion.modulo WHERE nombre = @nombre AND cantidadProduccion = @cantidadProduccion AND idMetodologia = @idMetodologia)
	BEGIN
		INSERT INTO Produccion.modulo VALUES(@nombre,@cantidadProduccion,@idMetodologia)
		PRINT 'El modulo se ingreso correctamente'
	END
	ELSE
	BEGIN
		PRINT 'El modulo ya existe'
		ROLLBACK TRAN
	END
GO
--Tabla Venta.factura
CREATE PROC Venta.agregarFactura
@requiredDate Date,@orderDate DATE,@finishedDate DATE,@shipmentDate DATE,@direccion VARCHAR(250),@idCliente INT
AS
DECLARE @total MONEY
	IF (DATEDIFF(DAY,@finishedDate,@shipmentDate) = 1)
	BEGIN
		IF(DATEDIFF(DAY,@shipmentDate,@requiredDate) = 14)
		BEGIN
			SET @total = 0
			INSERT INTO Venta.factura VALUES(@requiredDate,@orderDate,@finishedDate,@shipmentDate,@total,@direccion,@idCliente)
			PRINT 'Factura registrada correctamente'
		END
		ELSE
		BEGIN
			PRINT 'La fecha de envio debe ser dos semanas antes que la de requisicion'
			ROLLBACK TRAN
		END
	END
	ELSE
	BEGIN
		PRINT 'La fecha de envio debe ser un dia mas que la de finalizacion'
		ROLLBACK TRAN
	END
GO
--Tabla Produccion.tipoVariante
CREATE PROC Produccion.agregarTipoVariante
@nombre VARCHAR(25)
AS
	IF NOT EXISTS(SELECT * FROM Produccion.tipoVariante WHERE nombre = @nombre)
	BEGIN
		INSERT INTO Produccion.tipoVariante VALUES(@nombre)
		PRINT 'Tipo de variante ingresada correctamente'
	END
	ELSE
	BEGIN
		PRINT 'El tipo de variante ya existe'
		ROLLBACK TRAN
	END
GO
--Tabla Produccion.Detalles
CREATE PROC Produccion.agregarDetalles
@descripcion VARCHAR(200),@precio MONEY,@idProceso INT
AS
	    INSERT INTO Produccion.Detalles VALUES(@descripcion,@precio,@idProceso)
		PRINT 'Detalles ingresados correctamente'
GO
--Tabla Produccion.detalleVarianteDetalle
CREATE PROC Produccion.agregarVarianteDetalle
@idVariante INT,@idDetalle INT
AS
	IF(@idVariante = 1)
	BEGIN
		PRINT 'La categoría Blanks no incluye ningun estampado ni sublimado'
		ROLLBACK TRAN
	END
	ELSE
	BEGIN
		INSERT INTO Produccion.detalleVarianteDetalle VALUES(@idVariante,@idDetalle)
	END
GO
--Tabla Produccion.flujoTrabajo
CREATE PROC Produccion.agregarFlujoTrabajo
@idVariante INT
AS
	INSERT INTO Produccion.flujoTrabajo VALUES(@idVariante)
	PRINT 'El flujo de trabajo fue asignado correctamente'
GO
--Tabla Produccion.detalleFlujoTrabajoProcesos
CREATE PROC Produccion.agregarFlujoProceso
@idFlujo INT,@idProceso INT
AS
	IF NOT EXISTS(SELECT * FROM Produccion.detalleFlujoTrabajoProcesos WHERE idFLujo = @idFlujo AND idProceso = @idProceso)
	BEGIN
		INSERT INTO Produccion.detalleFlujoTrabajoProcesos VALUES(@idFlujo,@idProceso)
		PRINT 'Proceso asignado al flujo correctamente'
	END
	ELSE
	BEGIN
		PRINT 'El flujo con este proceso ya existe'
		ROLLBACK TRAN
	END
GO
--Tabla Produccion.estadoSeguimiento
CREATE PROC Produccion.agregarEstadoSeguimiento
@nombre VARCHAR(25)
AS
	IF NOT EXISTS(SELECT * FROM Produccion.estadoSeguimiento WHERE nombre = @nombre)
	BEGIN
		INSERT INTO Produccion.estadoSeguimiento VALUES(@nombre)
		PRINT 'El estado de seguimiento se ingreso correctamente'
	END
	ELSE
	BEGIN
		PRINT 'El estado de seguimiento ya existe'
		ROLLBACK TRAN
	END
GO
--Tabla Produccion.estadoOrden
CREATE PROC Produccion.agregarEstadoOrden
@nombre VARCHAR(25)
AS
	IF NOT EXISTS(SELECT * FROM Produccion.estadoOrden WHERE nombre = @nombre)
	BEGIN
		INSERT INTO Produccion.estadoOrden VALUES(@nombre)
		PRINT 'El estado de la orden se ingreso correctamente'
	END
	ELSE
	BEGIN
		PRINT 'El estado de la orden ya existe'
		ROLLBACK TRAN
	END
GO
--Tabla Producto.prenda
CREATE PROC Producto.agregarPrenda
@nombre VARCHAR(100),@precio MONEY
AS
	IF NOT EXISTS(SELECT * FROM Producto.prenda WHERE nombre = @nombre AND precio = @precio)
	BEGIN
		IF(@precio > 0)
		BEGIN
			INSERT INTO Producto.prenda VALUES(@nombre,@precio)
			PRINT 'La prenda se ingreso correctamente'
		END
		ELSE
		BEGIN
			PRINT 'El precio debe ser mayor que 0'
			ROLLBACK TRAN
		END
	END
	ELSE
	BEGIN
		PRINT 'La prenda ya existe'
		ROLLBACK TRAN
	END
GO
--Tabla Producto.estilo
CREATE PROC Producto.agregarEstilo
@codigo CHAR(5),@idPrenda INT
AS
	IF NOT EXISTS(SELECT * FROM Producto.estilo WHERE codigo = @codigo)
	BEGIN
		IF(@codigo LIKE '%[A-Z][A-Z][0-9][0-9][0-9]%')
		BEGIN
			INSERT INTO Producto.estilo VALUES(@codigo,@idPrenda)
			PRINT 'Estilo ingresado correctamente'
		END
	END
	ELSE
	BEGIN
		PRINT 'El estilo ya existe'
		ROLLBACK TRAN
	END
GO
-- Tabla Producto.tipoTalla
CREATE PROC Producto.agregarTipoTalla
@nombre VARCHAR(40),@abreviacion char(4)
AS
	IF NOT EXISTS(SELECT * FROM Producto.tipoTalla WHERE nombre = @nombre AND abreviacion = @abreviacion)
	BEGIN
		IF(@abreviacion IN ('2XS','XS','S','M','L','XL','2XL','3XL','4XL'))
		BEGIN
			INSERT INTO Producto.tipoTalla VALUES(@nombre,@abreviacion)
			PRINT 'Tipo de talla ingresada correctamente'
		END
		ELSE
		BEGIN
			PRINT 'Ingrese una talla valida'
			ROLLBACK TRAN
		END
	END
	ELSE
	BEGIN
		PRINT 'El tipo de talla ya existe'
		ROLLBACK TRAN
	END
GO

--Tabla Producto.tallaUbicacion
CREATE PROC Producto.agregarUbicacion
@ubicacion VARCHAR(50)
AS
	IF NOT EXISTS(SELECT * FROM Producto.tallaUbicacion WHERE ubicacion = @ubicacion)
	BEGIN
		INSERT INTO Producto.tallaUbicacion VALUES(@ubicacion)
		PRINT 'La ubicacion de la talla fue agregada correctamente'
	END
	ELSE
	BEGIN
		PRINT 'La ubicacion de la talla ya existe'
		ROLLBACK TRAN
	END
GO
--Tabla Producto.talla
CREATE PROC Producto.agregarTalla
@cantidadTela DECIMAL(18,2),@idTipoTalla INT,@idPrenda INT,@idEstilo INT
AS
	IF NOT EXISTS(SELECT * FROM Producto.talla WHERE cantidadTela = @cantidadTela AND idTipoTalla = @idTipoTalla AND idPrenda = @idPrenda AND idEstilo = @idEstilo)
	BEGIN
		IF(@cantidadTela > 0)
		BEGIN
			INSERT INTO Producto.talla VALUES(@cantidadTela,@idTipoTalla,@idPrenda,@idEstilo)
			PRINT 'Talla agregada correctamente'
		END
		ELSE
		BEGIN
			PRINT 'La cantidad de tela no puede ser menor que 0'
			ROLLBACK TRAN
		END
	END
	ELSE
	BEGIN
		PRINT 'La talla ya existe'
		ROLLBACK TRAN
	END
GO
--Tabla Producto.medida
CREATE PROC Producto.agregarMedida
@dimension DECIMAL(18,2),@idTalla INT,@idUbicacion INT
AS
	IF NOT EXISTS(SELECT * FROM Producto.medida WHERE dimension = @dimension AND idTalla = @idTalla AND idUbicacion = @idUbicacion)
	BEGIN
		IF(@dimension > 0)
		BEGIN
			INSERT INTO Producto.medida VALUES(@dimension,@idTalla,@idUbicacion)
			PRINT 'Medida ingresada correctamente'
		END
		ELSE
		BEGIN
			PRINT 'La dimension no puede ser menor que 0'
			ROLLBACK TRAN
		END
	END
	ELSE
	BEGIN
		PRINT 'La medida ya existe'
		ROLLBACK TRAN
	END
GO
--Tabla dbo.color
CREATE PROC agregarColor
@nombre VARCHAR(50)
AS
	IF NOT EXISTS(SELECT * FROM dbo.color WHERE nombre = @nombre)
	BEGIN
		INSERT INTO dbo.color VALUES(@nombre)
		PRINT 'Color ingresado correctamente'
	END
	ELSE
	BEGIN
		PRINT 'El color ya existe'
		ROLLBACK TRAN
	END
GO
--Tabla Produccion.ordenVenta
CREATE PROCEDURE Produccion.agregarOrdenVenta
	@idFactura INT,@idEstilo INT,@idFlujo INT,
	@idColor INT,@idEstado INT
	AS
    DECLARE @monto MONEY,@cantidad INT
		IF NOT EXISTS(SELECT * FROM Produccion.ordenVenta WHERE cantidad = @cantidad AND idFactura = @idFactura  AND idEstilo = @idEstilo AND idFlujo = @idFlujo AND idColor = @idColor AND idEstado = @idEstado)
		BEGIN
            SET @monto = 0.00
            SET @cantidad = 0
			INSERT INTO Produccion.ordenVenta VALUES(@monto,@cantidad,@idFactura,@idEstilo,@idFlujo,@idColor,@idEstado)
			PRINT 'Orden Ingresada Correctamente'
		END
		ELSE
		BEGIN
			PRINT 'No se pudo ingresar la Orden revise los datos' 
            ROLLBACK TRAN
        END
	GO
--Tabla Produccion.ordenDeVentaTalla
CREATE PROC Produccion.agregarOrdenVentaTalla
@cantidad INT,@cantidadTela DECIMAL(18,2),@idTalla INT,@idModulo INT,@idOrdenVenta INT
AS
DECLARE @cantidadExtra INT
	IF(@cantidad > 0 AND @cantidad < 21)
	BEGIN
		SET @cantidadExtra = 1
	END
	ELSE IF(@cantidad > 20 AND @cantidad < 41)
	BEGIN
		SET @cantidadExtra = 2
	END
	ELSE IF(@cantidad > 40 AND @cantidad < 61)
	BEGIN
		SET @cantidadExtra = 3
	END
	ELSE IF(@cantidad > 60 AND @cantidad < 81)
	BEGIN
		SET @cantidadExtra = 4
	END
	ELSE
	BEGIN
		SET @cantidadExtra = 5
	END
	IF(@cantidadExtra > 0)
	BEGIN
		INSERT INTO Produccion.ordenDeVentaTalla VALUES(@cantidad,@cantidadExtra,@cantidadTela,@idTalla,@idModulo,@idOrdenVenta)
		PRINT 'La Orden de Venta de Tallas fue ingresada correctamente'
	END
GO
--Tabla Produccion.seguimientoOrden
CREATE PROC Produccion.agregarSeguimientoOrden
@idEstado INT,@idOrdenVenta INT,@idProceso INT
AS
	INSERT INTO Produccion.seguimientoOrden VALUES(@idEstado,@idOrdenVenta,@idProceso)
	PRINT 'Seguimiento de la Orden ingresado correctamente'
GO
--Tabla tipoUnidadMedidas
CREATE PROC Produccion.agregartipoUnidadMedidas
@idTipoUnidad CHAR(6),@nombre VARCHAR(60)
AS
	IF NOT EXISTS(SELECT * FROM Bodega.tipoUnidadMedidas WHERE idTipoUnidad = @idTipoUnidad AND nombre = @nombre)
	BEGIN
		IF (@idTipoUnidad IN('YDS','GAL','LTR','UDS'))
			BEGIN
				INSERT INTO Bodega.tipoUnidadMedidas VALUES(@idTipoUnidad,@nombre)
				PRINT 'Tipo de Materia Prima ingresada correctamente'
			END
			ELSE
			BEGIN
				PRINT 'La unidad de medida no es válida'
				ROLLBACK TRAN
			END
	END
	ELSE
	BEGIN
		PRINT 'Esta unidad de medida ya existe'
		ROLLBACK TRAN
	END
GO
--Tabla Bodega.tipoMateriaPrima
CREATE PROC Bodega.agregarTipoMateriaPrima
@nombre VARCHAR(60),@idMedicion CHAR(6)
AS
	IF NOT EXISTS(SELECT * FROM Bodega.tipoMateriaPrima WHERE nombre = @nombre AND idMedicion = @idMedicion)
	BEGIN
		IF (@idMedicion IN('YDS','GAL','LTR','UDS'))
			BEGIN
				INSERT INTO Bodega.tipoMateriaPrima VALUES(@nombre,@idMedicion)
				PRINT 'Tipo de Materia Prima ingresada correctamente'
			END
			ELSE
			BEGIN
				PRINT 'La unidad de medida no es válida'
				ROLLBACK TRAN
			END
	END
	ELSE
	BEGIN
		PRINT 'El tipo de materia prima ya existe'
		ROLLBACK TRAN
	END
GO
--Tabla Bodega.estante
CREATE PROCEDURE Bodega.agregarEstante
@estante char(1)
AS
	IF NOT EXISTS(SELECT * FROM Bodega.estante WHERE idEstante = @estante)
	BEGIN
		IF (@estante LIKE '%[A-H]%')
		BEGIN
			INSERT INTO Bodega.estante VALUES(@estante)
			PRINT 'Estante ingresado correctamente'
		END
		ELSE
		BEGIN
			PRINT 'La letra del estante debe estar entre A-H'
			ROLLBACK TRAN
		END
	END
	ELSE
	BEGIN
		PRINT 'El estante ya existe'
		ROLLBACK TRAN
	END
GO
--Tabla Bodega.Nivel
CREATE PROC Bodega.agregarNivel
@nivel INT
AS
	IF NOT EXISTS(SELECT * FROM Bodega.nivel WHERE nivel = @nivel)
	BEGIN
		IF(@nivel > 0 AND @nivel < 9)
        BEGIN
            INSERT INTO Bodega.nivel VALUES(@nivel)
		    PRINT 'Nivel ingresado correctamente'
        END
        ELSE
        BEGIN
            PRINT 'El nivel debe estar entre 1-8'
            ROLLBACK TRAN
        END
	END
	ELSE
	BEGIN
		PRINT 'El nivel ya existe'
		ROLLBACK TRAN
	END
GO
--Tabla Bodega.Columna
CREATE PROCEDURE Bodega.agregarColumna
@columna INT
AS
	IF NOT EXISTS(SELECT * FROM Bodega.columna WHERE columna = @columna)
	BEGIN
		IF(@columna > 0 AND @columna < 10)
		BEGIN
			INSERT INTO Bodega.columna VALUES(@columna)
			PRINT 'Columna Ingresada correctamente'
		END
		ELSE
		BEGIN
			PRINT 'El valor de la columna debe estar entre 1-9'
			ROLLBACK TRAN
		END
	END
	ELSE
	BEGIN
		PRINT 'Esta columna ya existe'
		ROLLBACK TRAN
	END
GO
--Tabla Bodega.Compartimiento
CREATE PROCEDURE Bodega.agregarCompartimiento
@idCompartimiento CHAR(3),@estado TINYINT
AS
DECLARE @idEstante CHAR(1),@idNivel INT,@idColumna INT
	IF NOT EXISTS(SELECT * FROM Bodega.Compartimiento WHERE idCompartimiento = @idCompartimiento)
	BEGIN
		IF (@idCompartimiento LIKE '%[A-H][1-8][1-9]%')
		BEGIN
			IF(@estado > -1)
			BEGIN
                SET @idEstante = SUBSTRING(@idCompartimiento,1,1)
                SET @idNivel = SUBSTRING(@idCompartimiento,2,1)
                SET @idColumna = SUBSTRING(@idCompartimiento,3,1)
				INSERT INTO Bodega.Compartimiento VALUES(@idCompartimiento,@estado,@idEstante,@idNivel,@idColumna)
					PRINT 'Compartimiento ingresado correctamente'
			END
			ELSE
				BEGIN
					PRINT 'el estado no puede ser negativo'
					ROLLBACK TRAN
				END
		END
		ELSE
		BEGIN
			PRINT 'el valor del Compartimiento es inválido'
			ROLLBACK TRAN
		END
	END
	ELSE
	BEGIN
		PRINT 'Este compartimiento ya existe'
		ROLLBACK TRAN
	END
GO
--Tabla Compra.Proveedor
CREATE PROC Compra.agregarProveedor
@nombre VARCHAR(100),@direccion VARCHAR(200),@telefono CHAR(9),@correo VARCHAR(50)
AS
	IF NOT EXISTS (SELECT * FROM Compra.Proveedor WHERE nombre = @nombre AND direccion = @direccion AND telefono = @telefono AND correo = @correo)
	BEGIN
		INSERT INTO Compra.Proveedor VALUES(@nombre,@direccion,@telefono,@correo)
		PRINT 'Proveedor ingresado Correctamente'
	END
	ELSE
	BEGIN
		PRINT 'El proveedor ya existe'
		ROLLBACK TRAN
	END
GO
--Tabla Bodega.MateriaPrima
CREATE PROCEDURE Bodega.agregarMateriaPrima
@descripcion varchar(200),@existencia decimal(18,2),@stockMaximo decimal(18,2),@idTipoMateriaPrima INT,
@idCompartimiento CHAR(3),@idColor INT,@idProveedor INT
AS
	IF NOT EXISTS(SELECT * FROM Bodega.MateriaPrima WHERE descripcion = @descripcion AND idTipoMateriaPrima = @idTipoMateriaPrima AND idCompartimiento = @idCompartimiento)
	BEGIN
		IF(@existencia > 0)
		BEGIN
			IF(@stockMaximo > @existencia AND @stockMaximo > 0)
			BEGIN
				IF (@idCompartimiento LIKE '%[A-H][1-8][1-9]%')
				BEGIN
					INSERT INTO Bodega.MateriaPrima VALUES(@descripcion,@existencia,@stockMaximo,@idTipoMateriaPrima,@idCompartimiento,@idColor,@idProveedor)
					PRINT 'Materia Prima ingresada correctamente'
				END
				ELSE
				BEGIN
					PRINT 'Verifique el codigo del compartimiento'
					ROLLBACK TRAN
				END
			END
			ELSE
			BEGIN
				PRINT 'Porfavor verifique los valores del stockMaximo'
				ROLLBACK TRAN
			END
		END
		ELSE
		BEGIN
			PRINT 'La existencia no puede ser negativa'
			ROLLBACK TRAN
		END
	END
	ELSE
	BEGIN
		PRINT 'Este material ya existe'
		ROLLBACK TRAN
	END
GO
--Tabla Compra.estadoCompras
CREATE PROC Compra.agregarEstadoCompras
@nombre VARCHAR(25)
AS
	IF NOT EXISTS(SELECT * FROM Compra.estadoCompras WHERE nombre = @nombre)
	BEGIN
		INSERT INTO Compra.estadoCompras VALUES(@nombre)
		PRINT 'Estado de compra ingresado correctamente'
	END
	ELSE
	BEGIN
		PRINT 'El estado de Compras ya existe'
		ROLLBACK TRAN
	END
GO
--Tabla Compra.compras
CREATE PROCEDURE Compra.agregarCompra
	@cantidad DECIMAL(18,2),@idEstado INT,@idMateriaPrima INT
	AS
		IF NOT EXISTS(SELECT * FROM Compra.compras WHERE cantidad = @cantidad AND idEstado = @idEstado AND idMateriaPrima = @idMateriaPrima)
		BEGIN
			IF (@cantidad > 0)
			BEGIN
				IF(@idEstado = 1)
				BEGIN
					INSERT INTO Compra.compras VALUES(@cantidad,@idEstado,@idMateriaPrima)
					PRINT 'La compra se añadio a la cola'
				END
				ELSE IF(@idEstado = 2)
				BEGIN
					INSERT INTO Compra.compras VALUES(@cantidad,@idEstado,@idMateriaPrima)
					PRINT 'La compra es urgente por favor, abastezca los recursos rapidamente'
				END
			END
            ELSE
            BEGIN
                PRINT 'la cantidad no puede ser menor a 0'
                ROLLBACK TRAN
            END
		END
		ELSE
		BEGIN
			PRINT 'La compra ya existe'
			ROLLBACK TRAN
		END
GO
--TRIGGER para verificar el abastecimiento
CREATE TRIGGER verificarCompras
ON Bodega.materiaPrima
AFTER UPDATE
AS
    DECLARE @restaE decimal(18,2),@existencia decimal(18,2),@stockMaximo decimal(18,2),
    @porcentaje decimal(18,2),@idMateriaPrima INT
    SELECT @existencia FROM inserted
    SELECT @stockMaximo FROM inserted
    SELECT @idMateriaPrima FROM inserted
    SET @restaE = @stockMaximo - @existencia
    SET @porcentaje = (@stockMaximo * 0.15)

    IF(@restaE < @porcentaje)
    BEGIN
        UPDATE Compra.compras SET idEstado = 2 WHERE idMateriaPrima = @idMateriaPrima
        PRINT 'Revise las compras, un material se acabara pronto'
    END
    ELSE
    BEGIN
        UPDATE Compra.compras SET idEstado = 1 WHERE idMateriaPrima = @idMateriaPrima
    END
GO
--TRIGGER para actualizar monto de SalesOrder
CREATE TRIGGER asignarMontoCantidad
ON Produccion.ordenDeVentaTalla
	AFTER INSERT
	AS
	DECLARE @suma MONEY,
		@idOrdenVenta INT,
		@cantidad INT,
		@idTalla INT,
		@idPrenda INT,
		@precio MONEY,
		@montoAnterior MONEY,
        @cantidadAnterior INT
        
	SELECT @idOrdenVenta = idOrdenVenta FROM inserted
	SELECT @cantidad = cantidad FROM inserted
	SELECT @idTalla = idTalla FROM inserted	
	SELECT @idPrenda = idPrenda FROM Producto.talla WHERE idTalla = @idTalla
	SELECT @precio = precio FROM Producto.prenda WHERE idPrenda = @idPrenda
	SELECT @montoAnterior = monto FROM Produccion.ordenVenta WHERE idOrdenVenta = @idOrdenVenta
    SELECT @cantidadAnterior = cantidad FROM Produccion.ordenVenta WHERE idOrdenVenta = @idOrdenVenta
	SET @suma = @precio * @cantidad
	UPDATE Produccion.ordenVenta SET monto = (@montoAnterior + @suma),cantidad = (@cantidadAnterior + @cantidad) WHERE idOrdenVenta = @idOrdenVenta
GO
--TRIGGERS Extra
CREATE TRIGGER asignarSeguimiento ON Produccion.ordenVenta
FOR INSERT
AS
	DECLARE @idOrdenVenta INT,@idProceso INT,@idVariante INT,@idFlujo INT
	BEGIN
		SELECT @idOrdenVenta = idOrdenventa FROM inserted
		SELECT @idFlujo = idFlujo FROM inserted
		SELECT @idVariante = idVariante FROM Produccion.flujoTrabajo INNER JOIN Produccion.ordenVenta ON Produccion.ordenVenta.idFlujo = Produccion.flujoTrabajo.idFlujo
		IF(@idVariante = 1)
		BEGIN
			EXEC Produccion.agregarSeguimientoOrden 3,@idOrdenVenta,1
			EXEC Produccion.agregarSeguimientoOrden 3,@idOrdenVenta,2
			EXEC Produccion.agregarSeguimientoOrden 3,@idOrdenVenta,3
			EXEC Produccion.agregarSeguimientoOrden 3,@idOrdenVenta,4
			EXEC Produccion.agregarSeguimientoOrden 3,@idOrdenVenta,5
			EXEC Produccion.agregarSeguimientoOrden 3,@idOrdenVenta,6
			EXEC Produccion.agregarSeguimientoOrden 3,@idOrdenVenta,7
			EXEC Produccion.agregarSeguimientoOrden 3,@idOrdenVenta,10
			EXEC Produccion.agregarSeguimientoOrden 3,@idOrdenVenta,11
			EXEC Produccion.agregarSeguimientoOrden 3,@idOrdenVenta,12
			EXEC Produccion.agregarSeguimientoOrden 3,@idOrdenVenta,13
			EXEC Produccion.agregarSeguimientoOrden 3,@idOrdenVenta,14
		END
		ELSE IF(@idVariante = 2)
		BEGIN
			EXEC Produccion.agregarSeguimientoOrden 3,@idOrdenVenta,1
			EXEC Produccion.agregarSeguimientoOrden 3,@idOrdenVenta,2
			EXEC Produccion.agregarSeguimientoOrden 3,@idOrdenVenta,3
			EXEC Produccion.agregarSeguimientoOrden 3,@idOrdenVenta,4
			EXEC Produccion.agregarSeguimientoOrden 3,@idOrdenVenta,5
			EXEC Produccion.agregarSeguimientoOrden 3,@idOrdenVenta,6
			EXEC Produccion.agregarSeguimientoOrden 3,@idOrdenVenta,7
			EXEC Produccion.agregarSeguimientoOrden 3,@idOrdenVenta,8
			EXEC Produccion.agregarSeguimientoOrden 3,@idOrdenVenta,10
			EXEC Produccion.agregarSeguimientoOrden 3,@idOrdenVenta,11
			EXEC Produccion.agregarSeguimientoOrden 3,@idOrdenVenta,12
			EXEC Produccion.agregarSeguimientoOrden 3,@idOrdenVenta,13
			EXEC Produccion.agregarSeguimientoOrden 3,@idOrdenVenta,14
		END
		ELSE
		BEGIN
			EXEC Produccion.agregarSeguimientoOrden 3,@idOrdenVenta,1
			EXEC Produccion.agregarSeguimientoOrden 3,@idOrdenVenta,2
			EXEC Produccion.agregarSeguimientoOrden 3,@idOrdenVenta,3
			EXEC Produccion.agregarSeguimientoOrden 3,@idOrdenVenta,4
			EXEC Produccion.agregarSeguimientoOrden 3,@idOrdenVenta,5
			EXEC Produccion.agregarSeguimientoOrden 3,@idOrdenVenta,6
			EXEC Produccion.agregarSeguimientoOrden 3,@idOrdenVenta,7
			EXEC Produccion.agregarSeguimientoOrden 3,@idOrdenVenta,9
			EXEC Produccion.agregarSeguimientoOrden 3,@idOrdenVenta,10
			EXEC Produccion.agregarSeguimientoOrden 3,@idOrdenVenta,11
			EXEC Produccion.agregarSeguimientoOrden 3,@idOrdenVenta,12
			EXEC Produccion.agregarSeguimientoOrden 3,@idOrdenVenta,13
			EXEC Produccion.agregarSeguimientoOrden 3,@idOrdenVenta,14
		END
	END
GO
-- Procedimientos para modificar ////////////////////////////////////////////////////////////////
--Tabla Produccion.departamento
CREATE PROC Produccion.modificarDepartamento -- Tabla produccion
@nombre VARCHAR(100),@descripcion VARCHAR(250), @idDepartamento int
AS
	IF EXISTS(SELECT * FROM Produccion.departamento WHERE idDepartamento = @idDepartamento)
	BEGIN
		iF NOT EXISTS(SELECT * FROM Produccion.departamento WHERE nombre = @nombre AND descripcion = @descripcion AND idDepartamento != @idDepartamento)
		BEGIN
			UPDATE Produccion.departamento SET nombre = @nombre, descripcion = @descripcion WHERE idDepartamento = @idDepartamento
			PRINT 'Departamento se modifico correctamente'
		END
		ELSE
		BEGIN
			PRINT 'El departamento ya existe'
			ROLLBACK TRAN
		END
	END
	ELSE
	BEGIN
		PRINT 'El departamento no existe'
	END
GO
--Tabla Produccion.procesos
CREATE PROC Produccion.modificarProcesos -- Tabla proceso
@nombre VARCHAR(30),@duracion INT,@idDepartamento INT, @idProceso int
AS
	IF EXISTS(SELECT * FROM Produccion.procesos WHERE idProceso = @idProceso)
	BEGIN
		IF(@duracion > 0)
		BEGIN
			UPDATE Produccion.procesos SET nombre = @nombre, duracion = @duracion, idDepartamento = @idDepartamento WHERE idProceso = @idProceso
			PRINT 'Proceso se ha actualizado correctamente'
		END
		ELSE
		BEGIN
			PRINT 'La duracion del proceso no puede ser negativa'
			ROLLBACK TRAN
		END
	END
	ELSE
	BEGIN
		PRINT 'El registro no existe'
	END
GO
--Tabla Venta.tipoCliente
CREATE PROC Venta.modificarTipoCliente
@nombre VARCHAR(25), @idTipo int
AS
	IF EXISTS(SELECT * FROM Venta.tipoCliente WHERE idTipo = @idTipo)
	BEGIN
		IF NOT EXISTS(SELECT * FROM Venta.tipoCliente WHERE nombre = @nombre AND idTipo != @idTipo	)
		BEGIN
			UPDATE Venta.tipoCliente SET nombre = @nombre WHERE idTipo = @idTipo
			PRINT 'Tipo de cliente se actualizo correctamente'
		END
		ELSE
		BEGIN
			PRINT 'El tipo de cliente ya existe'
			ROLLBACK TRAN
		END
	END
	ELSE
	BEGIN
		PRINT 'No existe el registro'
	END
GO
--Tabla Venta.clientes
--En caso de ser Tipo: Persona
CREATE PROC Venta.modificarClientePersona
@nombre VARCHAR(35),@dui CHAR(10),@nit CHAR(14),@direccion VARCHAR(150),@telefono VARCHAR(9),
@correo VARCHAR(50),@idTipo INT, @idCliente int
AS
	IF EXISTS(SELECT * FROM Venta.clientes WHERE idCliente = @idCliente)
	BEGIN
		IF(@dui LIKE '%[0-9][0-9][0-9][0-9][0-9][0-9][0-9][-][0-9]%')
		BEGIN
			IF(@nit LIKE '%[0-9][0-9][0-9][0-9][-][0-9][0-9][0-9][0-9][0-9][0-9][-][0-9][0-9][0-9][-][0-9]%')
			BEGIN
				UPDATE Venta.clientes SET nombre = @nombre, dui = @dui, nit = @nit, direccion = @direccion, telefono = @telefono, correo = @correo, idTipo = @idTipo WHERE idCliente = @idCliente
				PRINT 'Cliente ha sido modificado exitosamente'
			END
			ELSE
			BEGIN
				PRINT 'ingrese un NIT valido 0000-000000-000-0'
				ROLLBACK TRAN
			END
		END
		ELSE
		BEGIN
			PRINT 'Ingrese un formato de DUI valido 00000000-0'
			ROLLBACK TRAN
		END
	END
	ELSE
	BEGIN
		PRINT 'El cliente no existe'
		ROLLBACK TRAN
	END
GO
--En caso de ser Tipo: Empresa
CREATE PROC Venta.modificarClienteEmpresa
@nombre VARCHAR(35),@direccion VARCHAR(150),@telefono VARCHAR(9),
@correo VARCHAR(50),@idTipo INT, @idCliente int
AS
	IF EXISTS(SELECT * FROM Venta.clientes WHERE idCliente = @idCliente)
	BEGIN
		UPDATE Venta.clientes SET nombre = @nombre,direccion = @direccion, telefono = @telefono, correo = @correo, idTipo = @idTipo WHERE idCliente = @idCliente
				PRINT 'Cliente ha sido modificado exitosamente'
	END
	ELSE
	BEGIN
		PRINT 'El cliente no existe'
		ROLLBACK TRAN
	END
GO
--Tabla Produccion.metodologia
CREATE PROC Produccion.modificarMetodologia
@nombre VARCHAR(100), @idMetodologia int
AS
	IF EXISTS(SELECT * FROM Produccion.metodologia WHERE idMetodologia = @idMetodologia)
	BEGIN
		IF NOT EXISTS(SELECT * FROM Produccion.metodologia WHERE nombre = @nombre AND idMetodologia != @idMetodologia)
		BEGIN
			UPDATE Produccion.metodologia SET nombre = @nombre WHERE idMetodologia = @idMetodologia
			PRINT 'La metodologia se modificado correctamente'
		END
		ELSE
		BEGIN
			PRINT 'La metodologia ya existe'
			ROLLBACK TRAN
		END
	END
	ELSE
	BEGIN
		PRINT 'La metodologia no existe'
	END
GO
--Tabla Produccion.modulo
CREATE PROC Produccion.modificarModulo
@nombre VARCHAR(60),@cantidadProduccion INT,@idMetodologia INT, @idModulo INT
AS
	IF EXISTS(SELECT * FROM Produccion.modulo WHERE idModulo = @idModulo)
	BEGIN
		IF NOT EXISTS(SELECT * FROM Produccion.modulo WHERE nombre = @nombre AND cantidadProduccion = @cantidadProduccion AND idMetodologia = @idMetodologia and idModulo != @idModulo)
		BEGIN
			UPDATE Produccion.modulo SET nombre = @nombre, cantidadProduccion = @cantidadProduccion, idMetodologia = @idMetodologia WHERE idModulo = @idModulo
			PRINT 'El modulo se modificado correctamente'
		END
		ELSE
		BEGIN
			PRINT 'El modulo ya existe'
			ROLLBACK TRAN
		END
	END
	ELSE
	BEGIN
		PRINT 'El modulo no existe'
	END
GO
--Tabla Venta.factura
CREATE PROC Venta.modificarFactura
@requiredDate Date,@orderDate DATE,@finishedDate DATE,@shipmentDate DATE,@direccion VARCHAR(250),@idCliente INT, @idFactura int
AS
	IF EXISTS(SELECT * FROM Venta.factura WHERE idFactura = @idFactura)
	BEGIN
		IF (DATEDIFF(DAY,@finishedDate,@shipmentDate) = 1)
		BEGIN
			IF(DATEDIFF(DAY,@shipmentDate,@requiredDate) = 14)
			BEGIN
				UPDATE Venta.factura SET requiredDate = @requiredDate, orderDate = @orderDate, finishedDate = @finishedDate, shipmentDate = @shipmentDate, direccion = @direccion, idCliente = @idCliente WHERE idFactura = @idFactura
				PRINT 'Factura se ha modificado correctamente'
			END
			ELSE
			BEGIN
				PRINT 'La fecha de envio debe ser dos semanas antes que la de requisicion'
				ROLLBACK TRAN
			END
		END
		ELSE
		BEGIN
			PRINT 'La fecha de envio debe ser un dia mas que la de finalizacion'
			ROLLBACK TRAN
		END
	END
	ELSE
	BEGIN
		PRINT 'La factura no existe'
	END
GO
--Tabla Produccion.tipoVariante
CREATE PROC Produccion.modificarTipoVariante
@nombre VARCHAR(25), @idVariante int
AS
	IF EXISTS(SELECT * FROM Produccion.tipoVariante WHERE idVariante = @idVariante)
	BEGIN
		IF NOT EXISTS(SELECT * FROM Produccion.tipoVariante WHERE nombre = @nombre AND idVariante != @idVariante)
		BEGIN
			UPDATE Produccion.tipoVariante SET nombre = @nombre WHERE idVariante = @idVariante
			PRINT 'Tipo de variante se ha modificado correctamente'
		END
		ELSE
		BEGIN
			PRINT 'El tipo de variante ya existe'
			ROLLBACK TRAN
		END
	END
	ELSE
	BEGIN
		PRINT 'No se encuentran registros'
	END
GO
--Tabla Produccion.Detalles
CREATE PROC Produccion.modificarDetalles -- Tabla detalles
@descripcion VARCHAR(200),@precio MONEY,@idProceso INT, @idDetalle int
AS
	IF EXISTS(SELECT * FROM Produccion.Detalles WHERE idDetalle = @idDetalle)
	BEGIN
		UPDATE Produccion.Detalles SET descripcion = @descripcion, precio = @precio, idProceso = @idProceso WHERE idDetalle = @idDetalle
		PRINT 'Detalles modificado correctamente'
	END
	ELSE
	BEGIN 
		PRINT 'El detalle ha buscar no existe'
	END
GO
--Tabla Produccion.detalleVarianteDetalle
CREATE PROC Produccion.ModificarVarianteDetalle @idVariante INT, @idNuevaVariante INT,@idDetalle INT
AS
	IF EXISTS(SELECT * FROM Produccion.detalleVarianteDetalle WHERE idDetalle = @idDetalle)
	BEGIN
		UPDATE Produccion.detalleVarianteDetalle SET idVariante = @idNuevaVariante WHERE idDetalle = @idDetalle AND idVariante = @idVariante
		PRINT 'La variante fue modificada correctamente'
	END
	ELSE
	BEGIN
		PRINT 'El detalle no posee ninguna variante para poder modificar'
	END
GO
--Tabla Produccion.flujoTrabajo
CREATE PROC Produccion.modificarFlujoTrabajo -- Flujo
@idVariante INT, @idFlujo INT
AS
	IF EXISTS(SELECT * FROM Produccion.flujoTrabajo WHERE idFlujo = @idFlujo)
	BEGIN
		UPDATE Produccion.flujoTrabajo SET idVariante = @idVariante WHERE idFlujo = @idFlujo
		PRINT 'El flujo de trabajo fue modificado correctamente'
	END
	ELSE
	BEGIN
		PRINT 'El flujo de trabajo no existe'
	END
GO
--Tabla Produccion.detalleFlujoTrabajoProcesos
CREATE PROC Produccion.modificarFlujoProceso @idFlujo INT,@idProceso INT, @idNuevoProceso int
AS
	IF EXISTS (SELECT * FROM Produccion.detalleFlujoTrabajoProcesos WHERE idFLujo = @idFlujo)
	BEGIN
		IF NOT EXISTS(SELECT * FROM Produccion.detalleFlujoTrabajoProcesos WHERE idFLujo = @idFlujo AND idProceso = @idNuevoProceso)
		BEGIN
			UPDATE Produccion.detalleFlujoTrabajoProcesos SET idProceso = @idProceso WHERE idFLujo = @idFlujo AND idProceso = @idProceso
			PRINT 'Se ha resignado el proceso al flujo correctamente'
		END
		ELSE
		BEGIN
			PRINT 'El flujo con este proceso ya existe'
			ROLLBACK TRAN
		END
	END
	ELSE
	BEGIN
		print 'El flujo seleccionado no posee ningun proceso'
	END
GO
--Tabla Produccion.estadoSeguimiento
CREATE PROC Produccion.modificarEstadoSeguimiento -- Tabla estado seguimiento
@nombre VARCHAR(25), @idEstadoSeguimiento int
AS
	IF EXISTS(SELECT * FROM Produccion.estadoSeguimiento WHERE idEstadoSeguimiento = @idEstadoSeguimiento)
	BEGIN
		IF NOT EXISTS(SELECT * FROM Produccion.estadoSeguimiento WHERE nombre = @nombre AND idEstadoSeguimiento != @idEstadoSeguimiento)
		BEGIN
			UPDATE Produccion.estadoSeguimiento SET nombre = @nombre WHERE idEstadoSeguimiento = @idEstadoSeguimiento
			PRINT 'El estado de seguimiento se actualizado correctamente'
		END
		ELSE
		BEGIN
			PRINT 'El estado de seguimiento ya existe'
			ROLLBACK TRAN
		END
	END
	ELSE
	BEGIN
		PRINT 'No se ha podido encontrar el estado de seguimiento solicitado'
	END
GO
--Tabla Produccion.estadoOrden
CREATE PROC Produccion.modificarEstadoOrden -- Tabla estado orden
@nombre VARCHAR(25), @idEstadoOrden int
AS
	IF EXISTS(SELECT * FROM Produccion.estadoOrden WHERE idEstadoOrden = @idEstadoOrden)
	BEGIN
		IF NOT EXISTS(SELECT * FROM Produccion.estadoOrden WHERE nombre = @nombre AND idEstadoOrden != @idEstadoOrden)
		BEGIN
			UPDATE Produccion.estadoOrden SET nombre = @nombre WHERE idEstadoOrden = @idEstadoOrden
			PRINT 'El estado de la orden se ha modificado correctamente'
		END
		ELSE
		BEGIN
			PRINT 'El estado de la orden ya existe'
			ROLLBACK TRAN
		END
	END
	ELSE
	BEGIN
		PRINT 'El estado orden no existe'
	END
GO
--Tabla Producto.prenda
CREATE PROC Producto.modificarPrenda
@nombre VARCHAR(100),@precio MONEY, @idPrenda int
AS
	IF EXISTS(SELECT * FROM Producto.prenda WHERE idPrenda = @idPrenda)
	BEGIN
		IF NOT EXISTS(SELECT * FROM Producto.prenda WHERE nombre = @nombre AND precio = @precio AND idPrenda != @idPrenda)
		BEGIN
			IF(@precio > 0)
			BEGIN
				UPDATE Producto.prenda SET nombre = @nombre, precio = @precio WHERE idPrenda = @idPrenda
				PRINT 'La prenda se ha actualizado correctamente correctamente'
			END
			ELSE
			BEGIN
				PRINT 'El precio debe ser mayor que 0'
				ROLLBACK TRAN
			END
		END
		ELSE
		BEGIN
			PRINT 'La prenda ya existe'
			ROLLBACK TRAN
		END
	END
	ELSE
	BEGIN
		PRINT 'No existe registro a modificar'
	END
GO
--Tabla Producto.estilo
CREATE PROC Producto.modificarEstilo
@codigo CHAR(5),@idPrenda INT, @idEstilo int
AS
	IF EXISTS(SELECT * FROM Producto.estilo WHERE idEstilo = @idEstilo)
	BEGIN
		IF NOT EXISTS(SELECT * FROM Producto.estilo WHERE codigo = @codigo AND idEstilo != @idEstilo)
		BEGIN
			IF(@codigo LIKE '%[A-Z][A-Z][0-9][0-9][0-9]%')
			BEGIN
				UPDATE Producto.estilo SET codigo = @codigo, idPrenda = @idPrenda WHERE idEstilo = @idEstilo
				PRINT 'Estilo ingresado correctamente'
			END
		END
		ELSE
		BEGIN
			PRINT 'El estilo ya existe'
			ROLLBACK TRAN
		END
	END
GO
-- Tabla Producto.tipoTalla
CREATE PROC Producto.modificarTipoTalla
@nombre VARCHAR(40),@abreviacion char(4), @idTipoTalla int
AS
	IF EXISTS(SELECT * FROM Producto.tipoTalla WHERE idTipoTalla = @idTipoTalla)
	BEGIN
		IF NOT EXISTS(SELECT * FROM Producto.tipoTalla WHERE nombre = @nombre AND abreviacion = @abreviacion AND idTipoTalla != @idTipoTalla)
		BEGIN
			IF(@abreviacion IN ('2XS','XS','S','M','L','XL','2XL','3XL','4XL'))
			BEGIN
				UPDATE Producto.tipoTalla SET nombre = @nombre, abreviacion = @abreviacion WHERE idTipoTalla = @idTipoTalla
				PRINT 'Tipo de talla se ha modificado correctamente'
			END
			ELSE
			BEGIN
				PRINT 'Ingrese una talla valida'
				ROLLBACK TRAN
			END
		END
		ELSE
		BEGIN
			PRINT 'El tipo de talla ya existe'
			ROLLBACK TRAN
		END
	END
	ELSE
	BEGIN
		PRINT 'No existe el registro a modificar'
	END
GO
--Tabla Producto.tallaUbicacion
CREATE PROC Producto.modificarUbicacion
@ubicacion VARCHAR(50), @idUbicacion int
AS
	IF EXISTS (SELECT * FROM Producto.tallaUbicacion WHERE idUbicacion = @idUbicacion)
	BEGIN
		IF NOT EXISTS(SELECT * FROM Producto.tallaUbicacion WHERE ubicacion = @ubicacion AND idUbicacion != @idUbicacion)
		BEGIN
			UPDATE Producto.tallaUbicacion SET ubicacion = @ubicacion WHERE idUbicacion = @idUbicacion
			PRINT 'La ubicacion de la talla se ha modificado correctamente'
		END
		ELSE
		BEGIN
			PRINT 'La ubicacion de la talla ya existe'
			ROLLBACK TRAN
		END
	END
	ELSE
	BEGIN
		PRINT 'No existe el registro ha modificar'
	END
GO
--Tabla Producto.talla
CREATE PROC Producto.modificarTalla
@cantidadTela DECIMAL(18,2),@idTipoTalla INT,@idPrenda INT,@idEstilo INT, @idTalla int
AS
	IF EXISTS(SELECT * FROM Producto.talla WHERE idTalla = @idTalla)
	BEGIN
		IF NOT EXISTS(SELECT * FROM Producto.talla WHERE cantidadTela = @cantidadTela AND idTipoTalla = @idTipoTalla AND idPrenda = @idPrenda AND idEstilo = @idEstilo AND idTalla != @idTalla)
		BEGIN
			IF(@cantidadTela > 0)
			BEGIN
				UPDATE Producto.talla SET cantidadTela = @cantidadTela, idTipoTalla = @idTipoTalla, idPrenda = @idPrenda, idEstilo = @idEstilo WHERE idTalla = @idTalla
				PRINT 'Talla se ha modificado exitosamente'
			END
			ELSE
			BEGIN
				PRINT 'La cantidad de tela no puede ser menor que 0'
				ROLLBACK TRAN
			END
		END
		ELSE
		BEGIN
			PRINT 'La talla ya existe'
			ROLLBACK TRAN
		END
	END
GO
--Tabla Producto.medida
CREATE PROC Producto.modificarMedida
@dimension DECIMAL(18,2),@idTalla INT,@idUbicacion INT, @idMedida int
AS
	IF EXISTS(SELECT * FROM Producto.medida WHERE idMedida = @idMedida)
	BEGIN
		IF NOT EXISTS(SELECT * FROM Producto.medida WHERE dimension = @dimension AND idTalla = @idTalla AND idUbicacion = @idUbicacion AND idMedida != @idMedida)
		BEGIN
			IF(@dimension > 0)
			BEGIN
				UPDATE Producto.medida SET dimension = @dimension, idTalla = @idTalla, idUbicacion = @idUbicacion WHERE idMedida = @idMedida
				PRINT 'La medida actualizada correctamente'
			END
			ELSE
			BEGIN
				PRINT 'La dimension no puede ser menor que 0'
				ROLLBACK TRAN
			END
		END
		ELSE
		BEGIN
			PRINT 'La medida ya existe'
			ROLLBACK TRAN
		END
	END
	ELSE
	BEGIN
		PRINT 'No existe el registro'
	END
GO
--Tabla dbo.color
CREATE PROC modificarColor
@nombre VARCHAR(50), @idColor int
AS
	IF EXISTS(SELECT * FROM dbo.color WHERE idColor = @idColor)
	BEGIN
		IF NOT EXISTS(SELECT * FROM dbo.color WHERE nombre = @nombre AND idColor != @idColor)
		BEGIN
			UPDATE dbo.color SET nombre = @nombre WHERE idColor = @idColor
			PRINT 'Color se ha actualizado correctamente'
		END
		ELSE
		BEGIN
			PRINT 'El color ya existe'
			ROLLBACK TRAN
		END
	END
	ELSE
	BEGIN
		print 'El color que se desea modificar no existe'
	END
GO
--Tabla Produccion.ordenVenta
CREATE PROCEDURE Produccion.modificarOrdenVenta
@idFactura INT,@idEstilo INT,@idFlujo INT,
@idColor INT,@idEstado INT, @idOrdenVenta int
AS
	IF EXISTS(SELECT * FROM Produccion.ordenVenta WHERE idOrdenVenta = @idOrdenVenta)
	BEGIN
		IF NOT EXISTS(SELECT * FROM Produccion.ordenVenta WHERE idFactura = @idFactura  AND idEstilo = @idEstilo AND idFlujo = @idFlujo AND idColor = @idColor AND idEstado = @idEstado AND idOrdenVenta != @idOrdenVenta)
		BEGIN
			UPDATE Produccion.ordenVenta SET idFactura = @idFactura, idEstilo = @idEstilo, idFlujo = @idFlujo, idColor = @idColor, idEstado = @idEstado WHERE idOrdenVenta = @idOrdenVenta
			PRINT 'Orden Modificada Correctamente'
		END
		ELSE
		BEGIN
			PRINT 'No se pudo ingresar la Orden revise los datos' 
            ROLLBACK TRAN
        END
	END
	ELSE
	BEGIN
		PRINT 'No existe la orden de venta'
        ROLLBACK TRAN
	END
GO
--Tabla Produccion.ordenDeVentaTalla
CREATE PROC Produccion.modificarOrdenVentaTalla
@cantidad INT,@cantidadTela DECIMAL(18,2),@idTalla INT,@idModulo INT,@idOrdenVenta INT, @idOrdenVentaTalla INT
AS
	IF EXISTS(SELECT * FROM Produccion.ordenDeVentaTalla WHERE idOrdenVentaTalla = @idOrdenVentaTalla)
	BEGIN
		DECLARE @cantidadExtra INT = 0
		IF(@cantidad > 0 AND @cantidad < 21)
		BEGIN
			SET @cantidadExtra = 1
		END
		ELSE IF(@cantidad > 20 AND @cantidad < 41)
		BEGIN
			SET @cantidadExtra = 2
		END
		ELSE IF(@cantidad > 40 AND @cantidad < 61)
		BEGIN
			SET @cantidadExtra = 3
		END
		ELSE IF(@cantidad > 60 AND @cantidad < 81)
		BEGIN
			SET @cantidadExtra = 4
		END
		ELSE
		BEGIN
			SET @cantidadExtra = 5
		END
		IF(@cantidadExtra > 0)
		BEGIN
			UPDATE Produccion.ordenDeVentaTalla SET cantidad = @cantidad, cantidadExtra = @cantidadExtra, cantidadTela = @cantidadTela, idTalla = @idTalla, idModulo = @idModulo, idOrdenVenta = @idOrdenVenta WHERE idOrdenVentaTalla = @idOrdenVentaTalla
			PRINT 'La Orden de Venta de Tallas fue modificada correctamente'
		END
		Else
		BEGIN
			PRINT 'La orden de venta no puede contar con una cantidad menor o igual a 0'
		END
	END
	ELSE
	BEGIN
		PRINT 'La orden de venta no existe'
	END
GO
--Tabla Produccion.seguimientoOrden
CREATE PROC Produccion.modificarSeguimientoOrden
@idEstado INT,@idOrdenVenta INT,@idProceso INT, @idSeguimiento int
AS
	IF EXISTS(SELECT * FROM Produccion.seguimientoOrden WHERE idSeguimiento = @idSeguimiento)
	BEGIN
		UPDATE Produccion.seguimientoOrden SET idEstado = @idEstado, idOrdenVenta = @idOrdenVenta, idProceso = @idProceso WHERE idSeguimiento = @idSeguimiento
		PRINT 'Seguimiento de la Orden se ha actualizado correctamente'
	END
	ELSE
	BEGIN
		PRINT 'No se encuentrar ningun registro'
	END
GO
--Tabla tipoUnidadMedidas
CREATE PROC Produccion.modificarTipoUnidadMedidas
@nombre VARCHAR(60), @idTipoUnidad CHAR(6)
AS
	IF EXISTS(SELECT * FROM Bodega.tipoUnidadMedidas WHERE idTipoUnidad = @idTipoUnidad)
	BEGIN
		IF (@idTipoUnidad IN('YDS','GAL','LTR','UDS'))
		BEGIN
			UPDATE Bodega.tipoUnidadMedidas SET  nombre = @nombre WHERE idTipoUnidad = @idTipoUnidad
			PRINT 'Tipo de Materia Prima se ha modificado exitosamente'
		END
		ELSE
		BEGIN
			PRINT 'La unidad de medida no es válida'
			ROLLBACK TRAN
		END
	END
	ELSE
	BEGIN
		PRINT 'Esta unidad de medida no existe'
		ROLLBACK TRAN
	END
GO
--Tabla Bodega.tipoMateriaPrima
CREATE PROC Bodega.modificarTipoMateriaPrima @nombre VARCHAR(60),@idMedicion CHAR(6), @idTipoMateriaPrima int -- Tipo Materia Prima
AS
	IF EXISTS(SELECT * FROM Bodega.tipoMateriaPrima WHERE idTipoMateriaPrima = @idTipoMateriaPrima)
	BEGIN
		IF (@idMedicion IN('YDS','GAL','LTR','UDS'))
		BEGIN
			UPDATE Bodega.tipoMateriaPrima SET nombre = @nombre, idMedicion = @idMedicion WHERE idTipoMateriaPrima = @idTipoMateriaPrima
			PRINT 'Tipo de Materia Prima modificada correctamente'
		END
		ELSE
		BEGIN
			PRINT 'La unidad de medida no es válida'
			ROLLBACK TRAN
		END
	END
	ELSE
	BEGIN
		print 'El tipo de materia a modificar no existe'
		ROLLBACK TRAN
	END
GO
--Tabla Bodega.estante
CREATE PROCEDURE Bodega.modificarEstante @nuevo_estante char(1), @estante char(1) -- Estante
AS
	IF NOT EXISTS(SELECT * FROM Bodega.estante WHERE idEstante = @nuevo_estante and idEstante != @estante)
	BEGIN
		IF (@nuevo_estante LIKE '%[A-H]%' AND @estante LIKE '%[A-H]%')
		BEGIN
			UPDATE Bodega.estante SET idEstante = @nuevo_estante WHERE idEstante = @estante
			PRINT 'Estante modificado correctamente'
		END
		ELSE
		BEGIN
			PRINT 'La letra del estante debe estar entre A-H'
			ROLLBACK TRAN
		END
	END
	ELSE
	BEGIN
		PRINT 'El estante ya existe'
		ROLLBACK TRAN
	END
GO
--Tabla Bodega.Nivel
CREATE PROC Bodega.modificarNivel @nivel INT, @idNivel INT -- Tabla Nivel
AS
	IF EXISTS(SELECT * FROM Bodega.nivel WHERE idNivel = @idNivel)
	BEGIN
		IF NOT EXISTS(SELECT * FROM Bodega.nivel WHERE nivel = @nivel AND idNivel != @idNivel)
		BEGIN
            IF(@nivel > 0 AND @nivel < 9)
            BEGIN
                UPDATE Bodega.nivel SET nivel = @nivel WHERE idNivel = @idNivel
			    PRINT 'Nivel modificado correctamente'
            END
            ELSE
            BEGIN
                PRINT 'El nivel debe estar entre 1-8'
                ROLLBACK TRAN
            END
		END
		ELSE
		BEGIN
			PRINT 'El nivel ya existe'
		END
	END
	ELSE
	BEGIN
		print 'El nivel buscado no existe'
	END
GO
--Tabla Bodega.Columna
CREATE PROCEDURE Bodega.modificarColumna @columna int, @idColumna int -- Modificar columnas
AS
	IF NOT EXISTS(SELECT * FROM Bodega.columna WHERE columna = @columna and idColumna != @idColumna)
	BEGIN
		IF(@columna > 0 AND @columna < 10)
		BEGIN
			UPDATE Bodega.columna SET columna = @columna WHERE idColumna = @idColumna
			PRINT 'La columna se ha modificado exitosamente'
		END
		ELSE
		BEGIN
			PRINT 'El valor de la columna debe estar entre 1-9'
			ROLLBACK TRAN
		END
	END
	ELSE
	BEGIN
		PRINT 'Esta columna ya existe'
	END
GO
--Tabla Bodega.Compartimiento
CREATE PROCEDURE Bodega.modificarCompartimiento --Compartimiento
@estado TINYINT,@idEstante CHAR(1),@idNivel INT,@idColumna INT, @idCompartimiento CHAR(3)
AS
	IF EXISTS(SELECT * FROM Bodega.Compartimiento WHERE idCompartimiento = @idCompartimiento)
	BEGIN
		IF(@estado > -1)
		BEGIN
			IF (@idEstante LIKE '%[A-H]%')
			BEGIN
				IF EXISTS(SELECT * FROM Bodega.columna WHERE idColumna = @idColumna)
				BEGIN
					IF EXISTS(SELECT * FROM Bodega.estante WHERE idEstante = @idEstante)
					BEGIN
						UPDATE Bodega.Compartimiento SET estado = @estado, idEstante = @idEstante, idNivel = @idNivel, idColumna = @idColumna WHERE idCompartimiento = @idCompartimiento
						PRINT 'Compartimiento modificado correctamente'
					END
					ELSE
					BEGIN
						PRINT 'No existe el estante solicitado'
					END	
				END
				ELSE
				BEGIN
					PRINT 'No existe la columna solicitada'
				END	
			END
			ELSE
			BEGIN
				PRINT 'el Estante debe ser una letra entre A-H'
				ROLLBACK TRAN
			END
		END
		ELSE
		BEGIN
			PRINT 'el estado no puede ser negativo'
			ROLLBACK TRAN
		END
	END
	ELSE
	BEGIN
		PRINT 'el comportamiento ha modificar no existe'
	END
GO
--Tabla Compra.Proveedor
CREATE PROC Compra.modificarProveedor -- Tabla proveedores
@nombre VARCHAR(100),@direccion VARCHAR(200),@telefono CHAR(9),@correo VARCHAR(50), @idProveedor int
AS
	IF EXISTS(SELECT * FROM Compra.Proveedor WHERE idProveedor = @idProveedor)
	BEGIN
		IF NOT EXISTS (SELECT * FROM Compra.Proveedor WHERE nombre = @nombre AND direccion = @direccion AND telefono = @telefono AND correo = @correo AND idProveedor != @idProveedor)
		BEGIN
			UPDATE Compra.Proveedor SET nombre = @nombre, direccion = @direccion, telefono = @telefono, correo = @correo WHERE idProveedor = @idProveedor
			PRINT 'Proveedor se ha modificado Correctamente'
		END
		ELSE
		BEGIN
			PRINT 'El proveedor ya existe'
			ROLLBACK TRAN
		END
	END
	ELSE
	BEGIN
		PRINT 'No existe el proveedor a modificar'
	END
GO
--Tabla Bodega.MateriaPrima
CREATE PROCEDURE Bodega.modificarMateriaPrima -- Tabla MateriaPrima
@descripcion varchar(200), @existencia decimal(18,2), @stockMaximo decimal(18,2), @idTipoMateriaPrima INT, @idCompartimiento INT,@idColor INT, @idProveedor INT, @idMateriaPrima INT
AS
	IF EXISTS(SELECT * FROM Bodega.MateriaPrima WHERE idMateriaPrima = @idMateriaPrima)
	BEGIN
		IF NOT EXISTS(SELECT * FROM Bodega.MateriaPrima WHERE descripcion = @descripcion AND idTipoMateriaPrima = @idTipoMateriaPrima AND idCompartimiento = @idCompartimiento AND idMateriaPrima != @idMateriaPrima)
		BEGIN
			IF(@existencia > 0)
			BEGIN
				IF(@stockMaximo > @existencia AND @stockMaximo > 0)
				BEGIN
					IF (@idCompartimiento LIKE '%[A-H][1-8][1-9]%')
					BEGIN
						UPDATE Bodega.MateriaPrima SET descripcion = @descripcion, existencia = @existencia, stockMaximo = @stockMaximo, idTipoMateriaPrima = @idTipoMateriaPrima, idCompartimiento = @idCompartimiento, idColor = @idColor, idProveedor = @idProveedor WHERE idMateriaPrima = @idMateriaPrima
						PRINT 'Materia Prima modificada correctamente'
					END
					ELSE
					BEGIN
						PRINT 'Verifique el codigo del compartimiento'
						ROLLBACK TRAN
					END
				END
				ELSE
				BEGIN
					PRINT 'Porfavor verifique los valores del stockMaximo'
					ROLLBACK TRAN
				END
			END
			ELSE
			BEGIN
				PRINT 'La existencia no puede ser negativa'
				ROLLBACK TRAN
			END
		END
		ELSE
		BEGIN
			PRINT 'Este material ya existe'
			ROLLBACK TRAN
		END
	END
	ELSE
	BEGIN
		print 'La materia prima que bsuca no existe'
	END
GO
--Tabla Compra.estadoCompras
CREATE PROC Compra.modificarEstadoCompras -- Tabla del estado de compra
@nombre VARCHAR(25), @idEstadoCompras int
AS
	IF EXISTS (SELECT * FROM Compra.estadoCompras WHERE idEstadoCompras = @idEstadoCompras)
	BEGIN 
		IF NOT EXISTS(SELECT * FROM Compra.estadoCompras WHERE nombre = @nombre AND idEstadoCompras != @idEstadoCompras)
		BEGIN
			UPDATE Compra.estadoCompras SET nombre = @nombre WHERE idEstadoCompras != @idEstadoCompras
			PRINT 'Estado de compra se ha actualizado de forma correcta'
		END
		ELSE
		BEGIN
			PRINT 'El estado de Compras ya existe'
			ROLLBACK TRAN
		END
	END
	ELSE
	BEGIN
		PRINT 'El estado de compra no existe'
	END
GO
--Tabla Compra.compras
CREATE PROCEDURE Compra.modificarCompra @cantidad DECIMAL(18,2),@idEstado INT,@idMateriaPrima INT, @idCompras int -- Tabla compra
AS
	IF exists (SELECT * FROM Compra.compras WHERE idCompras = @idCompras)
	BEGIN
		IF NOT EXISTS(SELECT * FROM Compra.compras WHERE cantidad = @cantidad AND idEstado = @idEstado AND idMateriaPrima = @idMateriaPrima AND idCompras != @idCompras)
		BEGIN
			IF (@cantidad > 0)
			BEGIN
				UPDATE Compra.compras SET cantidad = @cantidad, idEstado = @idEstado, idMateriaPrima = @idMateriaPrima WHERE idCompras = @idCompras
				PRINT 'Compra modificada con éxito'
			END
			ELSE
			BEGIN
				PRINT 'La cantidad de la compra debe de ser mayor que 0'
			END
		END
		ELSE
		BEGIN
			PRINT 'La compra ya existe'
			ROLLBACK TRAN
		END
	END
	ELSE
	BEGIN
		print 'La compra ha modificar no existe'
	END	
GO
--PROCEDURE #2
CREATE PROCEDURE Produccion.verificarTela @idColor INT, @cantidadTela DECIMAL(18,2)
AS
	DECLARE @tela DECIMAL(18,2),@respue BIT
	
	SELECT @tela =  existencia FROM Bodega.MateriaPrima WHERE idColor = @idColor
	
	IF(@cantidadTela < @tela)
	BEGIN
		SET @respue = 1
		return @respue
	END
	ELSE
	BEGIN
		SET @respue = 0
		return @respue
	END
GO

/*Por otro lado dado que el procedimiento anterior solamente se encargará de verificar si una Sales Order
tiene disponibilidad de ser puesta a producción, la empresa necesita que se automatice el proceso de
asignación a los módulos de producción, por lo que, se pide que cree un procedimiento almacenado
que tenga la capacidad de realizar este proceso de forma correcta TENIENDO EN CUENTA TODAS
LAS CONSIDERACIONES QUE SE HAN ESPECIFICADO ANTERIORMENTE EN ESTE PROCESO.*/

--PROCEDURE #3
create procedure Produccion.asignarModuloOrdenVenta @idOrdenVenta int, @idTalla int, @cantidad int
as
	-- cantidad de talla extra
	declare @extra_talla int, @completo varchar(25) = 'Finalizado'
	exec @extra_talla = Produccion.obtenerPiezasExtras @piezas = @cantidad

	-- Cantidad de tela especifica
	declare @cantidad_tela decimal(18, 2)
	
	select @cantidad_tela = cantidadTela 
	from Producto.talla 
	where idTalla = @idTalla
	
	-- Calculamos la tela a usar
	declare  @cantidadTela decimal(18, 2)
	set @cantidadTela = ((@extra_talla + @cantidad) * @cantidad_tela)

	declare @pendiente bit = 0

	select @pendiente = ( case when Produccion.estadoOrden.nombre = 'Pendiente' then 1 else 0 end) from Produccion.ordenVenta inner join Produccion.estadoOrden on Produccion.estadoOrden.idEstadoOrden = Produccion.ordenVenta.idEstado where Produccion.ordenVenta.idOrdenVenta = @idOrdenVenta

	-- Obtenemos todos los modulos que soporten la cantidad de tela
	declare @modelo int = -1

	if (@pendiente = 1)
	begin
		-- El primer modelo
		select top 1 @modelo = modelos.modelo
		from
		(
			select top 1 Produccion.ordenDeVentaTalla.idModulo as modelo, count(*) as cantidad_ordern 
			from Produccion.modulo 
			full join Produccion.ordenDeVentaTalla 
			on Produccion.ordenDeVentaTalla.idModulo = Produccion.modulo.idModulo 
			full join Produccion.ordenVenta 
			on Produccion.ordenVenta.idOrdenVenta = Produccion.ordenDeVentaTalla.idOrdenVenta 
			inner join Produccion.estadoOrden
			ON Produccion.estadoOrden.idEstadoOrden = Produccion.ordenVenta.idEstado
			where Produccion.modulo.cantidadProduccion >= @cantidadTela
			and Produccion.estadoOrden.nombre != @completo -- Mientras no este terminado
			group by Produccion.ordenDeVentaTalla.idModulo
			order by cantidad_ordern asc
		) as modelos

		if	(isnull(@modelo, -1) > 0)
		begin
			-- Asignamos el modulo
			insert into Produccion.ordenDeVentaTalla (cantidad, cantidadExtra, cantidadTela, idTalla, idModulo, idOrdenVenta) values (@cantidad, @extra_talla, @idTalla, @cantidadTela, @modelo ,@idOrdenVenta)
		end
		else
		begin
			update Produccion.ordenVenta set idEstado = (SELECT TOP 1 idEstadoOrden FROM Produccion.estadoOrden WHERE nombre = 'Pendiente') WHERE idOrdenVenta = @idOrdenVenta
		
			select top 1 @modelo = modelos.modelo
			from
			(
				select top 1 ordenDeVentaTalla.idModulo as modelo, count(*) as cantidad_ordern 
				from Produccion.modulo 
				full join Produccion.ordenDeVentaTalla 
				on Produccion.ordenDeVentaTalla.idModulo = Produccion.modulo.idModulo 
				full join Produccion.ordenVenta 
				on Produccion.ordenVenta.idOrdenVenta = Produccion.ordenDeVentaTalla.idOrdenVenta 
				inner join Produccion.estadoOrden
				ON Produccion.estadoOrden.idEstadoOrden = Produccion.ordenVenta.idEstado
				and Produccion.estadoOrden.nombre != @completo -- Mientras no este terminado
				group by Produccion.ordenDeVentaTalla.idModulo
				order by cantidad_ordern asc
			) as modelos
		
			insert into Produccion.ordenDeVentaTalla (cantidad, cantidadExtra, cantidadTela, idTalla, idModulo, idOrdenVenta) values (@cantidad, @extra_talla, @idTalla, @cantidadTela, @modelo ,@idOrdenVenta)
			print 'La orden ha quedado como pendiente por la falta de un sector que labore con el pedido'
		end
	end
	else
	begin
		select top 1 @modelo = modelos.modelo
		from
		(
			select top 1 ordenDeVentaTalla.idModulo as modelo, count(*) as cantidad_ordern 
			from Produccion.modulo 
			full join Produccion.ordenDeVentaTalla 
			on Produccion.ordenDeVentaTalla.idModulo = Produccion.modulo.idModulo 
			full join Produccion.ordenVenta 
			on Produccion.ordenVenta.idOrdenVenta = Produccion.ordenDeVentaTalla.idOrdenVenta 
			inner join Produccion.estadoOrden
			ON Produccion.estadoOrden.idEstadoOrden = Produccion.ordenVenta.idEstado
			and Produccion.estadoOrden.nombre != @completo -- Mientras no este terminado
			group by Produccion.ordenDeVentaTalla.idModulo
			order by cantidad_ordern asc
		) as modelos
		
		insert into Produccion.ordenDeVentaTalla (cantidad, cantidadExtra, cantidadTela, idTalla, idModulo, idOrdenVenta) values (@cantidad, @extra_talla, @idTalla, @cantidadTela, @modelo ,@idOrdenVenta)
		print 'La orden ha quedado como pendiente por la falta de un sector que labore con el pedido'
	end

	
go

/*
	Los procesos anteriores se pueden realizar de forma automática los dos (Es decir, un proceso que se
	encargue de verificar las Sales Order con disponibilidad de tela y asignar aquellas que cumplan,
	directamente a un módulo para su producción dentro de un solo proceso) o, pueden ser realizadas de
	forma separada como se especifica.
*/
--PROCEDURE #4
create type db_tallas AS TABLE(id_talla int, cantidad int);  
GO

create procedure Produccion.proTallaModuloAutomatico @idOrdenVenta int, @idModulo int, @tallas db_tallas readonly
as
	-- En caso que haya suficiente tela para lo que queremos hacer
	declare @suficienteTela bit = 0

	-- Obtenemos la cantidad total de las telas
	declare @cantidad_total decimal(18, 2) = 0, @count int = 0

	select @count = (@count + 1), @cantidad_total = (@cantidad_total + ((tp_talla.cantidad + Produccion.getPiezasExtras(tp_talla.cantidad)) * tbl_talla.cantidadTela)) 
	from Producto.talla as tbl_talla ,@tallas as tp_talla 
	where tbl_talla.idTalla = tp_talla.id_talla

	declare @idColor INT

	select top 1 @idColor = idColor
	from Produccion.ordenVenta
	where idOrdenVenta = @idOrdenVenta

	exec @suficienteTela = Produccion.verificarTela @idColor = @idColor, @cantidadTela = @cantidad_total

	-- En caso que haya suficiente tela
	if @suficienteTela = 1
	begin
		declare @i int = 1
		while @i <= @count
		begin
			-- Obtenemos la informacion sobre las tallas
			declare @idTalla int = 0, @cantidad int = 0
			select @cantidad = (case when row_number() over(order by tp_tallas.id_talla) = @i then tp_tallas.cantidad else @cantidad end), @idTalla = (case when row_number() over(order by tp_tallas.id_talla) = @i then tp_tallas.id_talla else @idTalla end) from @tallas as tp_tallas
			-- Aumentamos el indice
			set @i = @i + 1
			-- Ejecutamos la asignacion de modelos
			exec Produccion.asignarModuloOrdenVenta @idOrdenVenta = @idOrdenVenta, @idTalla = @idTalla, @cantidad = @cantidad
		end
		
	end
	else
	begin
		RAISERROR(50020,22,1)
	end
go
/*De la misma forma, se solicita que se cree un procedimiento almacenado que se encargue de generar
un reporte de facturación para cada una de las Facturas generadas especificando todos los ítems que
se tienen dentro de ella, el reporte debe ser generado con la siguiente estructura propuesta: */

--Factura.jpg
create type db_factura AS TABLE(nombre varchar(100), cantidad int, cantidadExtra int, precioUnitario decimal(18, 2), descripcion varchar(255), precioTotal decimal(18, 2));  
GO

create procedure Produccion.crearReporte @idFactura int, @JSON VARCHAR(MAX) OUTPUT
as

	IF EXISTS(SELECT * FROM venta.factura WHERE venta.factura.idFactura = @idFactura)
	BEGIN
		IF EXISTS (select * from Venta.factura inner join Produccion.ordenVenta on Venta.factura.idFactura = Produccion.ordenVenta.idFactura inner join Produccion.ordenDeVentaTalla on Produccion.ordenDeVentaTalla.idOrdenVenta = Produccion.ordenVenta.idOrdenVenta where Venta.factura.idFactura = @idFactura)
		BEGIN
			-- Variables de la factura
			declare @id_factura int, @direccion varchar(250), @cliente varchar(150), @fecha_actual date = getdate()
			select @id_factura = @idFactura

			-- Obtenemos la informacion de la factura
			select top 1 @direccion = Venta.factura.direccion, @id_factura = Venta.factura.idFactura, @cliente = Venta.clientes.nombre
			from Venta.factura
			inner join Venta.clientes
			on Venta.clientes.idCliente = Venta.factura.idCliente
			where Venta.factura.idFactura = @idFactura

			-- Informacion del monto total
			declare @tbl_factura db_factura

			-- Obtenemos la informacion de las prenda
			insert into @tbl_factura
			select Producto.prenda.nombre, Produccion.ordenDeVentaTalla.cantidad, Produccion.ordenDeVentaTalla.cantidadExtra, Producto.prenda.precio, 
			STUFF(  
				(  
					SELECT concat(', medida', Producto.medida.dimension, ' en la ubicacion ', Producto.tallaUbicacion.ubicacion)
					FROM Producto.medida
					inner join Producto.tallaUbicacion
					on Producto.tallaUbicacion.idUbicacion = Producto.medida.idUbicacion
					WHERE Producto.medida.idTalla = Producto.talla.idTalla 
					FOR XML PATH ('')
				),1,1,''), 
			Produccion.ordenDeVentaTalla.cantidad*Producto.prenda.precio
			from venta.factura
			inner join Produccion.ordenVenta
			on Venta.factura.idFactura = Produccion.ordenVenta.idFactura
			inner join Produccion.ordenDeVentaTalla
			on Produccion.ordenDeVentaTalla.idOrdenVenta = Produccion.ordenVenta.idOrdenVenta
			inner join Producto.talla
			on Producto.talla.idTalla = Produccion.ordenDeVentaTalla.idTalla
			inner join Producto.prenda
			on Producto.prenda.idPrenda = Producto.talla.idPrenda
			where venta.factura.idFactura = @idFactura
			--group by Producto.prenda.nombre, Produccion.ordenDeVentaTalla.cantidad, Produccion.ordenDeVentaTalla.cantidadExtra, Producto.prenda.precio

			-- Calcular el total
			declare @total decimal(18, 2) = 0
			select @total = (@total + tbl.precioTotal) from @tbl_factura as tbl
			declare @iva decimal(18, 2) = @total * 0.13
			declare @total_iva decimal(18, 2) = @total + @iva

			declare @factura varchar(max)

			select @JSON = '{"id":' + cast(@id_factura as varchar(max)) + ',' +
							   '"direccion":"' + @direccion + '",' +
							   '"cliente":"' + @cliente + '",' +
							   '"fecha":"' + cast(@fecha_actual as varchar(max)) + '",' +
							   '"items": [' 
							   + STUFF(
									(
										select 
											',{' + 
											'"nombre":"' + nombre + '",' +
											'"cantidad":"' + cast(cantidad as varchar(max)) + ',' +
											'"extra":' + cast(cantidadExtra as varchar(max)) + ',' +
											'"precio":' + cast(precioUnitario as varchar(max)) + ',' +
											'"descripcion":"' + descripcion + '",' +
											'"total":' + cast(precioTotal as varchar(max)) +
											'}'
										from @tbl_factura t1
										for xml path(''), type
									).value('.', 'varchar(max)'), 1, 1, ''
								) + '],' + 
								'"total":' + cast(@total as varchar(max)) + ',' +
								'"ival":' + cast(@iva as varchar(max)) + ',' +
								'"total_completo":' + cast(@total_iva as varchar(max)) +
								'}'
		END
		ELSE
		BEGIN
			select @JSON =  cast('{ "Error":"La factura no posee pedidos" }' as varchar)
		END
	END
	ELSE
	BEGIN
		select @JSON =  cast('{ "Error":"El registro no existe" }' as varchar)
	END
go

--Usuarios de la BDD //////////////////////////////////////////////////////////////////////////////////////
--1. Usuarios del Esquema Compras:
--1.1 Usuario Solamente con permisos de selección de datos.
DROP LOGIN ConsultorCompras
DROP USER MatildaFuentes
CREATE LOGIN ConsultorCompras
WITH PASSWORD = '12345'
CREATE USER MatildaFuentes FOR LOGIN ConsultorCompras
WITH DEFAULT_SCHEMA = Compra
GRANT SELECT
ON SCHEMA :: Compra
TO MatildaFuentes
GO
--1.2 Usuario Solamente con permisos de ejecución de procedimientos Almacenados de datos
--(Para la parte de Inserción de datos y actualización)
DROP LOGIN GestorCompras
DROP USER LeonardoEsquivel
CREATE LOGIN GestorCompras
WITH PASSWORD = '12345'
CREATE USER LeonardoEsquivel FOR LOGIN GestorCompras
WITH DEFAULT_SCHEMA = Compra
GRANT EXECUTE
ON SCHEMA :: Compra
TO LeonardoEsquivel
GO

--1.3 Usuario Administrador de Esquema, el cual podrá crear objetos como vistas,
--procedimientos, tablas etc dentro de este esquema.
DROP LOGIN AdministradorCompras
DROP USER ElenilsonGuevara
CREATE LOGIN AdministradorCompras
WITH PASSWORD = '12345'
CREATE USER ElenilsonGuevara FOR LOGIN AdministradorCompras
WITH DEFAULT_SCHEMA = Compra
GRANT CREATE VIEW,CREATE TABLE,CREATE PROC
TO ElenilsonGuevara
GO
--2. Usuarios del Esquema Produccion:
--2.1 Usuario Solamente con permisos de selección de datos.
DROP LOGIN ConsultorProduccion
DROP USER AlvaroTorres
CREATE LOGIN ConsultorProduccion
WITH PASSWORD = '12345'
CREATE USER AlvaroTorres FOR LOGIN ConsultorProduccion
WITH DEFAULT_SCHEMA = Produccion
GRANT SELECT
ON SCHEMA :: Produccion
TO AlvaroTorres
GO
--2.2 Usuario Solamente con permisos de ejecución de procedimientos Almacenados de datos
--(Para la parte de Inserción de datos y actualización)
DROP LOGIN GestorProduccion
DROP USER FranklinVelasquez
CREATE LOGIN GestorProduccion
WITH PASSWORD = '12345'
CREATE USER FranklinVelasquez FOR LOGIN GestorProduccion
WITH DEFAULT_SCHEMA = Produccion
GRANT EXECUTE
ON SCHEMA :: Produccion
TO FranklinVelasquez
GO
--2.3 Usuario Administrador de Esquema, el cual podrá crear objetos como vistas,
--procedimientos, tablas etc dentro de este esquema.
DROP LOGIN AdministradorProduccion
DROP LOGIN FernandaValle
CREATE LOGIN AdministradorProduccion
WITH PASSWORD = '12345'
CREATE USER FernandaValle FOR LOGIN AdministradorProduccion
WITH DEFAULT_SCHEMA = Produccion
GRANT CREATE VIEW,CREATE TABLE,CREATE PROC
TO FernandaValle
GO
--3. Usuarios del Esquema Bodega:
--3.1 Usuario Solamente con permisos de selección de datos.
DROP LOGIN ConsultorBodega
DROP USER FelixCanales
CREATE LOGIN ConsultorBodega
WITH PASSWORD = '12345'
CREATE USER FelixCanales FOR LOGIN ConsultorBodega
WITH DEFAULT_SCHEMA = Bodega
GRANT SELECT
ON SCHEMA :: Bodega
TO FelixCanales
GO
--3.2 Usuario Solamente con permisos de ejecución de procedimientos Almacenados de datos
--(Para la parte de Inserción de datos y actualización)
DROP LOGIN GestorBodega
DROP USER KarlaChavez
CREATE LOGIN GestorBodega
WITH PASSWORD = '12345'
CREATE USER KarlaChavez FOR LOGIN GestorBodega
WITH DEFAULT_SCHEMA = Bodega
GRANT EXECUTE
ON SCHEMA :: Bodega
TO KarlaChavez
GO
--2.3 Usuario Administrador de Esquema, el cual podrá crear objetos como vistas,
--procedimientos, tablas etc dentro de este esquema.
DROP LOGIN AdministradorBodega
DROP USER DiegoDiaz
CREATE LOGIN AdministradorBodega
WITH PASSWORD = '12345'
CREATE USER DiegoDiaz FOR LOGIN AdministradorBodega
WITH DEFAULT_SCHEMA = Bodega
GRANT CREATE VIEW,CREATE TABLE,CREATE PROC
TO DiegoDiaz
GO
--4. Usuario Administrador que tendrá control total sobre TODA LA BASE DE DATOS Y TODOS
--SUS OBJETOS.
DROP LOGIN Administrador
DROP USER BrandonLee
CREATE LOGIN Administrador
WITH PASSWORD = '54321'
CREATE USER BrandonLee FOR LOGIN Administrador
GRANT ALTER,EXECUTE,SELECT,INSERT,UPDATE,DELETE,CONTROL,REFERENCES,VIEW DEFINITION
TO BrandonLee WITH GRANT OPTION

--Respaldo de la BDD /////////////////////////////////////////////////////////////////////////////////////

--INSERT de las tablas
EXEC Produccion.agregarDepartamento 'Planificacion', 'En encarga de verificar cada una de las órdenes de trabajo que han ingresado a la empresa, y como su nombre lo dice, planificar todo el proceso productivo de la empresa, esto incluye, verificar el trabajo en proceso en toda la planta, con el objetivo de no asignar más cargas de trabajo de la que se puede tener'
EXEC Produccion.agregarDepartamento 'CAD','Este departamento se encarga principalmente de generar los diferentes patrones de marcadores para cada talla y estilo que se produce dentro de la planta, así como de imprimirlos y hacerlos llegar al departamento de corte para el inicio del ciclo productivo.'
EXEC Produccion.agregarDepartamento 'Corte','Este departamento se encarga directamente de recibir los marcadores impresos generados por CAD para procesarlos, cortar la tela y enviar los paquetes de piezas listas para que sean costuradas.'
EXEC Produccion.agregarDepartamento 'Costura','Se encargan directamente del costurado de las piezas, cabe mencionar que algunas piezas pueden ser costuradas antes o después de algún proceso como el sublimado o el estampado.'
EXEC Produccion.agregarDepartamento 'Bodega','Se encargan de la recepción y el almacenaje de la materia prima utilizada en la producción de las prendas, estos pueden considerarse en dos grandes categorías, Fabric (Tela), y Supplies (Hilos, Cordones, Tintas, etc.)'
EXEC Produccion.agregarDepartamento 'Sublimado','Area de Printing en Tela, este proceso se lleva a cabo en ciertas prendas y estilos seleccionados'
EXEC Produccion.agregarDepartamento 'Serigrafia', 'Área de Estampado en Tela, este proceso se lleva a cabo en ciertas prendas y estilos seleccionado'
EXEC Produccion.agregarDepartamento 'Empaque','Se encarga directamente de la recepción total de las prendas para el embalaje y preparación para el envío, a los clientes, en este paso, se hace la rotulación de los paquetes de acuerdo a la compañía logística que se encargará del transporte de los mismos'
EXEC Produccion.agregarDepartamento 'Control de Calidad','De forma segmentada y casi por cada uno de los procesos, se hace un control de calidad para que la orden pueda ser llevada al siguiente paso del proceso productivo.'
EXEC Produccion.agregarDepartamento 'Recursos Humanos','Se encarga del manejo de la información relativa a los empleados, tiempos de entrada y salida, datos generales, etc'
EXEC Produccion.agregarDepartamento 'Contabilidad','Datos relativos al pago y la autorización de cada una de las transacciones y pagos de salarios, etc'
EXEC Produccion.agregarDepartamento 'Compras','Se encarga de generar y realizar las compras de los insumos para todo el proceso productivo y también de los procesos administrativos en general.'

EXEC Produccion.agregarProcesos 'Order Ready',10,1
EXEC Produccion.agregarProcesos 'Printing Marker',5,2
EXEC Produccion.agregarProcesos 'Marker Ready',15,2
EXEC Produccion.agregarProcesos 'Cutting',5,3 
EXEC Produccion.agregarProcesos 'Sewing line',10,4
EXEC Produccion.agregarProcesos 'Out of Sewing Line',15,4
EXEC Produccion.agregarProcesos 'Ironing',15,4
EXEC Produccion.agregarProcesos 'Screen Printing',15,7
EXEC Produccion.agregarProcesos 'Sublimation',15,7
EXEC Produccion.agregarProcesos 'Quality Assurance',15,9
EXEC Produccion.agregarProcesos 'Ready for Packing',10,9
EXEC Produccion.agregarProcesos 'Packing Ready',10,8
EXEC Produccion.agregarProcesos 'Ready for Shipment',10,8
EXEC Produccion.agregarProcesos 'Shipped',10,8

EXEC Venta.agregarTipoCliente 'Empresa'
EXEC Venta.agregarTipoCliente 'Persona'

EXEC Venta.agregarClientePersona 'Juan Lionel','12345678-9','1234-123456-123-2','Calle las brisas, Av. Chinameca Condominio #4','7321-0998','juanitoLeon@hotmail.com',2
EXEC Venta.agregarClienteEmpresa 'SIMAN Metrocentro','Sucursal de Metrocento, San Salvador','2542-4421','siman.metrocentro@gmail.com',1
EXEC Venta.agregarClienteEmpresa 'ST Jack´s Soyapango','Sucursal Unicentro Soyapango','2353-0983','stjacksoyapango@gmail.com',1
EXEC Venta.agregarClienteEmpresa 'Picaras Boutique','Sucursal Metrocentro, Cerca de Adidas','2260-3444','picarasboutique@gmail.com',1
EXEC Venta.agregarClientePersona 'Leonardo Edenilson Valle','87654321-9','4321-654231-983-5','Boulevar Constitución, atras de Papa Jonh`s','7293-9432','leoValleBoutique@gmail.com',2
EXEC Venta.agregarClientePersona 'Fernando Roberto Lemus Lemus','01928374-5','3241-028743-876-3','Calle a Apulo, Edificio #45,parcela #40','6023-3212','fernanflores@gmail.com',2
EXEC Venta.agregarClienteEmpresa 'Jacarandas','Metrocentro Doceava Etapa, a la par St Jack´s','2200-0332','jacarandasmetro@gmail.com',1
EXEC Venta.agregarClienteEmpresa 'Carlos Boutique','Plaza Mundo San Salvador, local #53','2999-4322','carlosstyle@gmail.com',1
EXEC Venta.agregarClienteEmpresa 'San Sebastian','Calle a San sebastian, condominio #55, Edificio Rojo','2303-4445','sebastianboutique@gmail.com',1
EXEC Venta.agregarClienteEmpresa 'Aqua eco','44 calle 2 Zona 12,Guatemala','2248-6000','AquaEcho@gmail.com',1
EXEC Venta.agregarClienteEmpresa 'Style Life','Centro comercial la cascada etapa #1,Local #12','2432-3333','stylelifecascada@gmail.com',1
EXEC Venta.agregarClientePersona 'Erick Alberto Esquivel Cañas','65784390-2','0192-657402-543-8','Calle la utilisima, Departamento de la Paz, en redondel la gloria edificio #1','2222-2223','xErickaec@gmail.com',2
EXEC Venta.agregarClienteEmpresa 'Vida Estilizada','Metrosur San Salvador, segunda planta local #99','2893-4444','vidaestilizada@gmail.com',1
EXEC Venta.agregarClienteEmpresa 'Dora´s','Galerias San Salvador, 3º nivel, local #12','2390-3333','dorasStyle@gmail.com',1
EXEC Venta.agregarClienteEmpresa 'Garage','Galerias San Salvador,Cerca del cine local #41','2533-3339','garageESA@gmail.com',1
EXEC Venta.agregarClientePersona 'Ezequiel Pocho Lavezzi Hernández','65780129-8','8888-444222-443-2','Calle el estante, Cabañas, comercial maria purisima,local #47','6555-3333','ezequielpocho@gmail.com',2
EXEC Venta.agregarClienteEmpresa 'Prisma Moda Plaza mundo','Sucursal Plaza Mundo, Etapa 2, local #43','2333-4444','prismamodaPM@gmail.com',1
EXEC Venta.agregarClienteEmpresa 'Branson Metrocentro','Sucursal Metrocentro San Salvador, 2 Etapa, por fuente con Starbucks','2333-4779','bransonmetrocentro@gmail.com',1
EXEC Venta.agregarClienteEmpresa 'Calvin Klein Metrocentro','Sucursal Metrocentro San Salvador, 1 Etapa, por parqueo principal de Metrocentro','2441-4461','calvinKleinmetroSS@gmail.com',1
EXEC Venta.agregarClientePersona 'Jimena Abigail Sanchez Guardado','65748309-2','1432-444090-341-5','Calle a Paseo general Escalón, Edificio Verde Local #1','7442-1223','jimenaAbigail@gmail.com',2
EXEC Venta.agregarClienteEmpresa 'Carolina´s','Metrocentro San Salvador,1º Nivel, Local #43','2309-3333','carolinas_bouti@gmail.com',1
EXEC Venta.agregarClienteEmpresa 'Tatiana´s','Galerias San Salvador, 2º Etapa, nivel #2, local #55','7203-4452','tatiandesign@gmail.com',1
EXEC Venta.agregarClienteEmpresa 'Colegio Don Bosco','Soyapango San Salvador, Calle a plan del pino','2000-1123','colegiodonbosco@gmail.com',1
EXEC Venta.agregarClienteEmpresa 'Scotiabank','Metrocentro San Salvador, Enfrente de Restaurante los Cebollines','2633-0110','scotiabankss@gmail.com',1
EXEC Venta.agregarClientePersona 'Kevin Alexander De Bruyne Reyes','23341928-3','5432-345019-245-5','Soyapango San Salvador calle la esperanza, edificio #4, parcela #1','6012-5145','KevinBruyne@gmail.com',2
EXEC Venta.agregarClienteEmpresa 'Agua Cristal','San Miguel, El Salvador, Calle la Conquista Edificio Azul','2201-2910','cristalelagua@gmail.com',1
EXEC Venta.agregarClienteEmpresa 'SIMAN Plaza Mundo','Sucursal de Plaza Muno, San Salvador','2549-4421','siman.plazamundo@gmail.com',1
EXEC Venta.agregarClienteEmpresa 'ST Jack´s Metrocentro','Sucursal Metrocentro San Salvador','2883-0983','stjacksometrocentro@gmail.com',1
EXEC Venta.agregarClienteEmpresa 'Local Boutique','Sucursal Metrocentro, Cerca de ADOC y MD','2940-3414','localboutique@gmail.com',1
EXEC Venta.agregarClientePersona 'Vanessa Alexandra Carranza','87654797-1','0182-654231-983-5','Boulevar Constitución, atras de Pollo Real','7423-9432','carranzastyle@gmail.com',2
EXEC Venta.agregarClientePersona 'Diana Alondra Canales','01928373-0','3241-651029-876-3','Calle a Apulo, Edificio #42,parcela #2','6003-3212','alondracanales@gmail.com',2
EXEC Venta.agregarClienteEmpresa 'Las Gemas','Metrocentro Cuarta etapa, a la par de Jacarandas','2212-0342','lasgemasmetro@gmail.com',1
EXEC Venta.agregarClienteEmpresa 'Antonella Boutique','Metrocentro San Salvador, local #23','2999-0312','antonellasalon@gmail.com',1
EXEC Venta.agregarClienteEmpresa 'Sant France','Paseo General Escalón, condominio #15, Edificio Azul','2113-4985','santfrance@gmail.com',1
EXEC Venta.agregarClienteEmpresa 'DollarCity Unicentro Soyapango','Unicentro Soyapango San Salvador, local #40','2093-1000','dollacitysoya@gmail.com',1
EXEC Venta.agregarClienteEmpresa 'Gorgeous','Centro comercial la cascada etapa #6,Local #68','2098-3331','Gorgeouscascada@gmail.com',1
EXEC Venta.agregarClientePersona 'Diego Gilberto López Lemus','01294390-2','1254-019402-543-8','Calle la hacienda, Departamento de San Miguel, en redondel la esperanza edificio #4','2999-6210','diegopresa@gmail.com',2
EXEC Venta.agregarClienteEmpresa 'Star Style','MetroNorte San Salvador, tercera planta local #68','2084-3415','Starstyle@gmail.com',1
EXEC Venta.agregarClienteEmpresa 'Carabana´s','Galerias San Salvador, 1º nivel, local #10','2093-7313','carabanaSS@gmail.com',1
EXEC Venta.agregarClienteEmpresa 'Mega Variety','Plaza Mundo San Salvador, 2º etapa,local #22','2028-4218','mevarietyPM@gmail.com',1
EXEC Venta.agregarClientePersona 'Filipe Ousmane Hernández Capilla','01829300-8','5017-444222-107-2','Calle la sucia, La unión, comercial maria santisima,local 2','7102-6666','ousmandembele@gmail.com',2
EXEC Venta.agregarClienteEmpresa 'Prisma Moda Galerias','Sucursal Galerias, Etapa 1, local #9','2546-0002','prismamodaGAL@gmail.com',1
EXEC Venta.agregarClienteEmpresa 'Branson La cascada','Sucursal La Cascada San Salvador, 1 Etapa,por la pizza Hut, local #4','2019-2019','bransoncascada@gmail.com',1
EXEC Venta.agregarClienteEmpresa 'Calvin Klein Galerias','Sucursal Galerias San Salvador, 3 Nivel, por salida de parqueo principal','2545-2543','calvinKleingalerias@gmail.com',1
EXEC Venta.agregarClientePersona 'Tomas Alexander Madrid Versa','36451026-2','1432-000192-415-5','Calle a Paseo general Escalón, por plaza Agua pura, Edificio #2, local #41','6442-1302','versamadriddecima@gmail.com',2
EXEC Venta.agregarClienteEmpresa 'Central´s','Metrocentro San Salvador,2º Nivel, Local #66','2098-4133','centralsdress@gmail.com',1
EXEC Venta.agregarClienteEmpresa 'Dresess Karla','Galerias San Salvador, 1º Etapa, nivel #1, frente a Samsung','7102-4210','dresseskarl@gmail.com',1
EXEC Venta.agregarClienteEmpresa 'Elegance boutique','Soyapango San Salvador, Calle a Plaza mundo, a la par del Pollo Campero','2534-7356','eleganceboutiquess@gmail.com',1
EXEC Venta.agregarClienteEmpresa 'Puma Metrocentro','Metrocentro San Salvador, A la par de Restaurante los Cebollines','2309-1221','pumasmetro@gmail.com',1
EXEC Venta.agregarClienteEmpresa 'Elegance T-Shirt','Galerias San salvador, local #22 nivel #4, a la par de Calvin Klein','2120-3313','elegandeshirt@gmail.com',1

EXEC Produccion.agregarMetodologia 'Normal'
EXEC Produccion.agregarMetodologia 'Fasttrack'

EXEC Produccion.agregarModulo 'Módulo 1', 400,1
EXEC Produccion.agregarModulo 'Módulo 2', 300,1
EXEC Produccion.agregarModulo 'Módulo 3', 300,1
EXEC Produccion.agregarModulo 'Módulo 4', 300,1
EXEC Produccion.agregarModulo 'Módulo 5', 200,1
EXEC Produccion.agregarModulo 'Módulo 6', 250,1
EXEC Produccion.agregarModulo 'Módulo 7', 200,1
EXEC Produccion.agregarModulo 'Módulo 8', 150,1
EXEC Produccion.agregarModulo 'Módulo 9', 300,1
EXEC Produccion.agregarModulo 'Módulo 10', 300,1
EXEC Produccion.agregarModulo 'FastTrack',125,2

EXEC Venta.agregarFactura '2018-06-15','2018-05-27','2018-05-31','2018-06-01','Calle las brisas, Av. Chinameca Condominio #4',1
EXEC Venta.agregarFactura '2018-09-21','2018-08-27','2018-09-06','2018-09-07','Sucursal de Metrocento, San Salvador',2
EXEC Venta.agregarFactura '2018-08-22','2018-05-27','2018-08-07','2018-08-08','Sucursal Unicentro Soyapango',3
EXEC Venta.agregarFactura '2018-07-17','2018-07-27','2018-07-02','2018-07-03','Sucursal Metrocentro, Cerca de Adidas',4
EXEC Venta.agregarFactura '2018-01-19','2017-12-25','2018-01-04','2018-01-05','Boulevar Constitución, atras de Papa Jonh`s',5
EXEC Venta.agregarFactura '2018-01-16','2017-12-21','2018-01-01','2018-01-02','Calle a Apulo, Edificio #45,parcela #40',6
EXEC Venta.agregarFactura '2018-02-25','2018-01-27','2018-02-10','2018-02-11','Metrocentro Doceava Etapa, a la par St Jack´s',7
EXEC Venta.agregarFactura '2018-10-24','2018-09-27','2018-10-09','2018-10-10','Plaza Mundo San Salvador, local #53',8
EXEC Venta.agregarFactura '2018-09-29','2018-08-27','2018-09-14','2018-09-15','Calle a San sebastian, condominio #55, Edificio Rojo',9
EXEC Venta.agregarFactura '2018-05-26','2018-04-27','2018-05-11','2018-05-12','44 calle 2 Zona 12,Guatemala',10
EXEC Venta.agregarFactura '2018-04-21','2018-03-27','2018-04-06','2018-04-07','Centro comercial la cascada etapa #1,Local #12',11
EXEC Venta.agregarFactura '2018-03-20','2018-02-27','2018-03-05','2018-03-06','Calle la utilisima, Departamento de la Paz, en redondel la gloria edificio #1',12
EXEC Venta.agregarFactura '2018-06-28','2018-05-27','2018-06-13','2018-06-14','Metrosur San Salvador, segunda planta local #99',13
EXEC Venta.agregarFactura '2018-05-30','2018-04-27','2018-05-15','2018-05-16','Galerias San Salvador, 3º nivel, local #12',14
EXEC Venta.agregarFactura '2018-03-29','2018-02-27','2018-03-14','2018-03-15','Galerias San Salvador,Cerca del cine local #41',15
EXEC Venta.agregarFactura '2018-09-16','2018-08-27','2018-09-01','2018-09-02','Calle el estante, Cabañas, comercial maria purisima,local #47',16
EXEC Venta.agregarFactura '2018-03-26','2018-02-27','2018-03-11','2018-03-12','Sucursal Plaza Mundo, Etapa 2, local #43',17
EXEC Venta.agregarFactura '2018-08-31','2018-07-27','2018-08-16','2018-08-17','Sucursal Metrocentro San Salvador, 2 Etapa, por fuente con Starbucks',18
EXEC Venta.agregarFactura '2018-08-20','2018-07-27','2018-08-05','2018-08-06','Sucursal Metrocentro San Salvador, 1 Etapa, por parqueo principal de Metrocentro',19
EXEC Venta.agregarFactura '2018-05-15','2018-04-27','2018-04-30','2018-05-01','Calle a Paseo general Escalón, Edificio Verde Local #1',20
EXEC Venta.agregarFactura '2018-04-02','2018-03-27','2018-03-18','2018-03-19','Metrocentro San Salvador,1º Nivel, Local #43',21
EXEC Venta.agregarFactura '2018-04-22','2018-03-27','2018-04-07','2018-04-08','Galerias San Salvador, 2º Etapa, nivel #2, local #55',22
EXEC Venta.agregarFactura '2018-03-27','2018-02-27','2018-03-12','2018-03-13','Soyapango San Salvador, Calle a plan del pino',23
EXEC Venta.agregarFactura '2018-02-28','2018-01-27','2018-02-13','2018-02-14','Metrocentro San Salvador, Enfrente de Restaurante los Cebollines',24
EXEC Venta.agregarFactura '2018-01-20','2017-12-20','2018-01-05','2018-01-06','Soyapango San Salvador calle la esperanza, edificio #4, parcela #1',25
EXEC Venta.agregarFactura '2018-04-15','2018-03-21','2018-03-31','2018-04-01','San Miguel, El Salvador, Calle la Conquista Edificio Azul',26
EXEC Venta.agregarFactura '2018-08-21','2018-07-23','2018-08-06','2018-08-07','Sucursal de Plaza Mundo, San Salvador',27
EXEC Venta.agregarFactura '2018-07-22','2018-06-26','2018-07-07','2018-07-08','Sucursal Metrocentro San Salvador',28
EXEC Venta.agregarFactura '2018-06-17','2018-05-29','2018-06-02','2018-06-03','Sucursal Metrocentro, Cerca de ADOC y MD',29
EXEC Venta.agregarFactura '2018-02-19','2018-01-25','2018-02-04','2018-02-05','Boulevar Constitución, atras de Pollo Real',30
EXEC Venta.agregarFactura '2018-02-16','2018-01-21','2018-02-01','2018-02-02','Calle a Apulo, Edificio #42,parcela #2',31
EXEC Venta.agregarFactura '2018-03-25','2018-02-27','2018-03-10','2018-03-11','Metrocentro Cuarta etapa, a la par de Jacarandas',32
EXEC Venta.agregarFactura '2018-09-24','2018-08-29','2018-09-09','2018-09-10','Metrocentro San Salvador, local #23',33
EXEC Venta.agregarFactura '2018-08-29','2018-07-20','2018-08-14','2018-08-15','Paseo General Escalón, condominio #15, Edificio Azul',34
EXEC Venta.agregarFactura '2018-04-26','2018-03-23','2018-04-11','2018-04-12','Unicentro Soyapango San Salvador, local #40',35
EXEC Venta.agregarFactura '2018-03-21','2018-02-25','2018-03-06','2018-03-07','Centro comercial la cascada etapa #6,Local #68',36
EXEC Venta.agregarFactura '2018-02-20','2018-01-27','2018-02-05','2018-02-06','Calle la hacienda, Departamento de San Miguel, en redondel la esperanza edificio #4',37
EXEC Venta.agregarFactura '2018-05-28','2018-04-26','2018-05-13','2018-05-14','MetroNorte San Salvador, tercera planta local #68',38
EXEC Venta.agregarFactura '2018-04-30','2018-03-21','2018-04-15','2018-04-16','Galerias San Salvador, 1º nivel, local #10',39
EXEC Venta.agregarFactura '2018-02-29','2018-01-22','2018-02-14','2018-02-15','Plaza Mundo San Salvador, 2º etapa,local #22',40
EXEC Venta.agregarFactura '2018-08-16','2018-07-20','2018-08-01','2018-08-02','Calle la sucia, La unión, comercial maria santisima,local 2',41
EXEC Venta.agregarFactura '2018-02-26','2018-01-27','2018-02-11','2018-02-12','Sucursal Galerias, Etapa 1, local #9',42
EXEC Venta.agregarFactura '2018-07-31','2018-06-27','2018-07-16','2018-07-17','Sucursal La Cascada San Salvador, 1 Etapa,por la pizza Hut, local #4',43
EXEC Venta.agregarFactura '2018-07-20','2018-06-27','2018-07-05','2018-07-06','Sucursal Galerias San Salvador, 3 Nivel, por salida de parqueo principal',44
EXEC Venta.agregarFactura '2018-04-15','2018-03-27','2018-03-31','2018-04-01','Calle a Paseo general Escalón, por plaza Agua pura, Edificio #2, local #41',45
EXEC Venta.agregarFactura '2018-03-02','2018-02-27','2018-02-16','2018-02-17','Metrocentro San Salvador,2º Nivel, Local #66',46
EXEC Venta.agregarFactura '2018-03-22','2018-02-27','2018-03-07','2018-03-08','Galerias San Salvador, 1º Etapa, nivel #1, frente a Samsung',47
EXEC Venta.agregarFactura '2018-02-27','2018-01-27','2018-02-12','2018-02-13','Soyapango San Salvador, Calle a Plaza mundo, a la par del Pollo Campero',48
EXEC Venta.agregarFactura '2018-01-28','2017-12-27','2018-01-13','2018-01-14','Metrocentro San Salvador, A la par de Restaurante los Cebollines',49
EXEC Venta.agregarFactura '2018-02-20','2018-01-20','2018-02-05','2018-02-06','Galerias San salvador, local #22 nivel #4, a la par de Calvin Klein',50

EXEC Produccion.agregarTipoVariante 'BLANKS'
EXEC Produccion.agregarTipoVariante 'SCREEN PRINTING'
EXEC Produccion.agregarTipoVariante 'SUBLIMATION'

EXEC Produccion.agregarDetalles 'Pecho Completo',0.75,8 
EXEC Produccion.agregarDetalles 'Pecho Derecho',0.55,8
EXEC Produccion.agregarDetalles 'Manga Derecha',0.55,8
EXEC Produccion.agregarDetalles 'Manga Izquierda',0.55,8
EXEC Produccion.agregarDetalles 'Espalda',0.75,8
EXEC Produccion.agregarDetalles 'Sublimado',2.25,9
--revisar
EXEC Produccion.agregarVarianteDetalle 2,1
EXEC Produccion.agregarVarianteDetalle 2,2
EXEC Produccion.agregarVarianteDetalle 2,3
EXEC Produccion.agregarVarianteDetalle 2,4
EXEC Produccion.agregarVarianteDetalle 2,5
EXEC Produccion.agregarVarianteDetalle 3,6

EXEC Produccion.agregarFlujoTrabajo 1
EXEC Produccion.agregarFlujoTrabajo 2
EXEC Produccion.agregarFlujoTrabajo 3

EXEC Produccion.agregarFlujoProceso 1,1

EXEC Produccion.agregarEstadoSeguimiento 'En proceso'
EXEC Produccion.agregarEstadoSeguimiento 'Finalizado'
EXEC Produccion.agregarEstadoSeguimiento 'Pendiente'

EXEC Produccion.agregarEstadoOrden 'En proceso'
EXEC Produccion.agregarEstadoOrden 'Finalizado'
EXEC Produccion.agregarEstadoOrden 'Pendiente'

EXEC Producto.agregarPrenda 'Camisa',5.75
EXEC Producto.agregarPrenda 'Pantalon',8.75
EXEC Producto.agregarPrenda 'Suéter',11.75
EXEC Producto.agregarPrenda 'Sudadera',11.75
EXEC Producto.agregarPrenda 'Corbata',3.75
EXEC Producto.agregarPrenda 'Camisa sin Manga',5.25
EXEC Producto.agregarPrenda 'Camisa de Vestir Manga Larga',10.00
EXEC Producto.agregarPrenda 'Pantalones Cortos',8.50

EXEC Producto.agregarEstilo 'HJ320',1
EXEC Producto.agregarEstilo 'AD560',1
EXEC Producto.agregarEstilo 'FG200',1
EXEC Producto.agregarEstilo 'CL120',1
EXEC Producto.agregarEstilo 'KL620',1
EXEC Producto.agregarEstilo 'PO200',1
EXEC Producto.agregarEstilo 'JK690',1
EXEC Producto.agregarEstilo 'MN470',1
EXEC Producto.agregarEstilo 'HY650',1
EXEC Producto.agregarEstilo 'DE589',2
EXEC Producto.agregarEstilo 'ZA894',2
EXEC Producto.agregarEstilo 'BG659',2
EXEC Producto.agregarEstilo 'UI895',2
EXEC Producto.agregarEstilo 'NH123',2
EXEC Producto.agregarEstilo 'MJ698',2
EXEC Producto.agregarEstilo 'BG548',2
EXEC Producto.agregarEstilo 'NH698',2
EXEC Producto.agregarEstilo 'GH548',2
EXEC Producto.agregarEstilo 'JK659',2
EXEC Producto.agregarEstilo 'VP548',3
EXEC Producto.agregarEstilo 'AE781',3
EXEC Producto.agregarEstilo 'SW453',3
EXEC Producto.agregarEstilo 'DP890',3
EXEC Producto.agregarEstilo 'WN751',3
EXEC Producto.agregarEstilo 'IK587',3
EXEC Producto.agregarEstilo 'TY548',3
EXEC Producto.agregarEstilo 'ER321',3
EXEC Producto.agregarEstilo 'HY985',3
EXEC Producto.agregarEstilo 'CF489',3
EXEC Producto.agregarEstilo 'QP501',4
EXEC Producto.agregarEstilo 'PB283',4
EXEC Producto.agregarEstilo 'CU348',4
EXEC Producto.agregarEstilo 'QL569',4
EXEC Producto.agregarEstilo 'PB582',4
EXEC Producto.agregarEstilo 'AL573',4
EXEC Producto.agregarEstilo 'MU891',4
EXEC Producto.agregarEstilo 'KV528',4
EXEC Producto.agregarEstilo 'RG243',4
EXEC Producto.agregarEstilo 'LP189',4
EXEC Producto.agregarEstilo 'MI854',5
EXEC Producto.agregarEstilo 'NJ128',5
EXEC Producto.agregarEstilo 'OP589',5
EXEC Producto.agregarEstilo 'GT548',5
EXEC Producto.agregarEstilo 'OV259',5
EXEC Producto.agregarEstilo 'ER028',5
EXEC Producto.agregarEstilo 'BHT58',5
EXEC Producto.agregarEstilo 'NQ145',5
EXEC Producto.agregarEstilo 'UD574',5
EXEC Producto.agregarEstilo 'QD147',5

EXEC Producto.agregarTipoTalla 'small','S'
exec Producto.agregarTipoTalla @nombre = 'Medium', @abreviacion = 'M'
exec Producto.agregarTipoTalla @nombre = 'Large', @abreviacion = 'L'
exec Producto.agregarTipoTalla @nombre = 'Extra large', @abreviacion = 'XL'
exec Producto.agregarTipoTalla @nombre = 'Extra extra small', @abreviacion = '2XS'
exec Producto.agregarTipoTalla @nombre = 'Extra small', @abreviacion = 'XS'
exec Producto.agregarTipoTalla @nombre = 'Extra extra large', @abreviacion = '2XL'
exec Producto.agregarTipoTalla @nombre = 'Extra extra large', @abreviacion = '3XL'
exec Producto.agregarTipoTalla @nombre = 'Extra extra large', @abreviacion = '4XL'

exec Producto.agregarUbicacion @ubicacion = 'Pecho'
exec Producto.agregarUbicacion @ubicacion = 'Cintura'
exec Producto.agregarUbicacion @ubicacion = 'Trasero'
exec Producto.agregarUbicacion @ubicacion = 'Tiro'
exec Producto.agregarUbicacion @ubicacion = 'Manga'
exec Producto.agregarUbicacion @ubicacion = 'Costura interior'
exec Producto.agregarUbicacion @ubicacion = 'Largo pantalon'
exec Producto.agregarUbicacion @ubicacion = 'Ancho espalda'
exec Producto.agregarUbicacion @ubicacion = 'Talle espalda'
exec Producto.agregarUbicacion @ubicacion = 'Cuello'
exec Producto.agregarUbicacion @ubicacion = 'Entrepierna'
exec Producto.agregarUbicacion @ubicacion = 'Manga corta'
exec Producto.agregarUbicacion @ubicacion = 'Largo rodilla'
exec Producto.agregarUbicacion @ubicacion = 'Contorno rodilla'
exec Producto.agregarUbicacion @ubicacion = 'Cadera'
exec Producto.agregarUbicacion @ubicacion = 'Largo camisa'
exec Producto.agregarUbicacion @ubicacion = 'Manga larga'

EXEC Producto.agregarTalla 1.00,1,1,1 --Aqui debe coincidir con los registro del PDF
exec Producto.agregarTalla @cantidadTela = 1.25, @idTipoTalla = 2,@idPrenda = 1, @idEstilo = 1
exec Producto.agregarTalla @cantidadTela = 1.50, @idTipoTalla = 3,@idPrenda = 1, @idEstilo = 1
exec Producto.agregarTalla @cantidadTela = 1.75, @idTipoTalla = 4,@idPrenda = 1, @idEstilo = 1

exec Producto.agregarTalla @cantidadTela = 1.50, @idTipoTalla = 2,@idPrenda = 2, @idEstilo = 2
exec Producto.agregarTalla @cantidadTela = 1.70, @idTipoTalla = 2,@idPrenda = 2, @idEstilo = 2
exec Producto.agregarTalla @cantidadTela = 1.90, @idTipoTalla = 3,@idPrenda = 2, @idEstilo = 2
exec Producto.agregarTalla @cantidadTela = 2.10, @idTipoTalla = 4,@idPrenda = 2, @idEstilo = 2

exec Producto.agregarTalla @cantidadTela = 1.75, @idTipoTalla = 2,@idPrenda = 3, @idEstilo = 3
exec Producto.agregarTalla @cantidadTela = 1.95, @idTipoTalla = 2,@idPrenda = 3, @idEstilo = 3
exec Producto.agregarTalla @cantidadTela = 2.15, @idTipoTalla = 3,@idPrenda = 3, @idEstilo = 3
exec Producto.agregarTalla @cantidadTela = 2.35, @idTipoTalla = 4,@idPrenda = 3, @idEstilo = 3

exec Producto.agregarTalla @cantidadTela = 1.75, @idTipoTalla = 2,@idPrenda = 4, @idEstilo = 4
exec Producto.agregarTalla @cantidadTela = 1.95, @idTipoTalla = 2,@idPrenda = 4, @idEstilo = 4
exec Producto.agregarTalla @cantidadTela = 2.15, @idTipoTalla = 3,@idPrenda = 4, @idEstilo = 4
exec Producto.agregarTalla @cantidadTela = 2.35, @idTipoTalla = 4,@idPrenda = 4, @idEstilo = 4

-- Camisa --
EXEC Producto.agregarMedida 86.5,1,1
exec Producto.agregarMedida @dimension = 36, @idTalla = 1, @idUbicacion = 10
exec Producto.agregarMedida @dimension = 72, @idTalla = 1, @idUbicacion = 16
exec Producto.agregarMedida @dimension = 25, @idTalla = 1, @idUbicacion = 17

-- Pantalon --
EXEC Producto.agregarMedida 30.5,2,1
exec Producto.agregarMedida @dimension = 40, @idTalla = 2, @idUbicacion = 15
exec Producto.agregarMedida @dimension = 80, @idTalla = 2, @idUbicacion = 7
exec Producto.agregarMedida @dimension = 53, @idTalla = 2, @idUbicacion = 12

-- Sueter--
exec Producto.agregarMedida @dimension = 38, @idTalla = 3, @idUbicacion = 17
exec Producto.agregarMedida @dimension = 54, @idTalla = 3, @idUbicacion = 16
exec Producto.agregarMedida @dimension = 48, @idTalla = 3, @idUbicacion = 15

-- Sudadera--
exec Producto.agregarMedida @dimension = 51, @idTalla = 4, @idUbicacion = 17
exec Producto.agregarMedida @dimension = 70, @idTalla = 4, @idUbicacion = 16
exec Producto.agregarMedida @dimension = 60, @idTalla = 4, @idUbicacion = 15

EXEC agregarColor 'Azul'
EXEC agregarColor 'Amarillo'
EXEC agregarColor 'Ámbar'
EXEC agregarColor 'Añil'
EXEC agregarColor 'Beige'
EXEC agregarColor 'Blanco'
EXEC agregarColor 'Café'
EXEC agregarColor 'Celeste'
EXEC agregarColor 'Caqui'
EXEC agregarColor 'Ámbar'
EXEC agregarColor 'Carmesí'
EXEC agregarColor 'Castaño'
EXEC agregarColor 'Cobre'
EXEC agregarColor 'Colores'
EXEC agregarColor 'Fucsia'
EXEC agregarColor 'Gris'
EXEC agregarColor 'Hueso'
EXEC agregarColor 'Magenta'
EXEC agregarColor 'Marrón'
EXEC agregarColor 'Negro'
EXEC agregarColor 'Naranja'
EXEC agregarColor 'Ocre'
EXEC agregarColor 'Morado'
EXEC agregarColor 'Plata'
EXEC agregarColor 'Púrpura'
EXEC agregarColor 'Rojo'
EXEC agregarColor 'Rosa'
EXEC agregarColor 'Salmón'
EXEC agregarColor 'Verde'
EXEC agregarColor 'Verde Lima'
EXEC agregarColor 'Verde Esmeralda'
EXEC agregarColor 'Violeta'
EXEC agregarColor 'Vino'
EXEC agregarColor 'Champán'
EXEC agregarColor 'Blanco Márfil'
EXEC agregarColor 'Azul Claro'
EXEC agregarColor 'Azul Eléctrico'
EXEC agregarColor 'Bermellón'
EXEC agregarColor 'Cereza'
EXEC agregarColor 'Gris Perla'
EXEC agregarColor 'Lila'
EXEC agregarColor 'Rojo Carmín'
EXEC agregarColor 'Turquesa'
EXEC agregarColor 'Oliva'
EXEC agregarColor 'Verde Esmeralda'
EXEC agregarColor 'Pistacho'
EXEC agregarColor 'Verde Musgo'
EXEC agregarColor 'Ciruela'

EXEC Produccion.agregartipoUnidadMedidas 'YDS','Yardas'
EXEC Produccion.agregartipoUnidadMedidas 'GAL','Galones'
EXEC Produccion.agregartipoUnidadMedidas 'LTR','Litros'
EXEC Produccion.agregartipoUnidadMedidas 'UDS','Unidades'

EXEC Bodega.agregarTipoMateriaPrima 'Tela','YDS'
EXEC Bodega.agregarTipoMateriaPrima 'Hilo', 'YDS'
EXEC Bodega.agregarTipoMateriaPrima 'Cordones', 'YDS'
EXEC Bodega.agregarTipoMateriaPrima 'Viñetas', 'UDS'
EXEC Bodega.agregarTipoMateriaPrima 'Tintas', 'LTR'

EXEC Bodega.agregarEstante 'A'
EXEC Bodega.agregarEstante 'B'
EXEC Bodega.agregarEstante 'C'
EXEC Bodega.agregarEstante 'D'
EXEC Bodega.agregarEstante 'E'
EXEC Bodega.agregarEstante 'F'
EXEC Bodega.agregarEstante 'G'
EXEC Bodega.agregarEstante 'H'

EXEC Bodega.agregarNivel 1
EXEC Bodega.agregarNivel 2
EXEC Bodega.agregarNivel 3
EXEC Bodega.agregarNivel 4
EXEC Bodega.agregarNivel 5
EXEC Bodega.agregarNivel 6
EXEC Bodega.agregarNivel 7
EXEC Bodega.agregarNivel 8

EXEC Bodega.agregarColumna 1
EXEC Bodega.agregarColumna 2
EXEC Bodega.agregarColumna 3
EXEC Bodega.agregarColumna 4
EXEC Bodega.agregarColumna 5
EXEC Bodega.agregarColumna 6
EXEC Bodega.agregarColumna 7
EXEC Bodega.agregarColumna 8
EXEC Bodega.agregarColumna 9

EXEC Bodega.agregarCompartimiento A11,0
EXEC Bodega.agregarCompartimiento A12,0
EXEC Bodega.agregarCompartimiento A13,0
EXEC Bodega.agregarCompartimiento A14,0
EXEC Bodega.agregarCompartimiento A15,0
EXEC Bodega.agregarCompartimiento A16,0
EXEC Bodega.agregarCompartimiento A17,0
EXEC Bodega.agregarCompartimiento A18,0
EXEC Bodega.agregarCompartimiento A19,0
EXEC Bodega.agregarCompartimiento A21,0
EXEC Bodega.agregarCompartimiento A22,0
EXEC Bodega.agregarCompartimiento A23,0
EXEC Bodega.agregarCompartimiento A24,0
EXEC Bodega.agregarCompartimiento A25,0
EXEC Bodega.agregarCompartimiento A26,0
EXEC Bodega.agregarCompartimiento A27,0
EXEC Bodega.agregarCompartimiento A28,0
EXEC Bodega.agregarCompartimiento A29,0
EXEC Bodega.agregarCompartimiento A31,0
EXEC Bodega.agregarCompartimiento A32,0
EXEC Bodega.agregarCompartimiento A33,0
EXEC Bodega.agregarCompartimiento A34,0
EXEC Bodega.agregarCompartimiento A35,0
EXEC Bodega.agregarCompartimiento A36,0
EXEC Bodega.agregarCompartimiento A37,0
EXEC Bodega.agregarCompartimiento A38,0
EXEC Bodega.agregarCompartimiento A39,0
EXEC Bodega.agregarCompartimiento A41,0
EXEC Bodega.agregarCompartimiento A42,0
EXEC Bodega.agregarCompartimiento A43,0
EXEC Bodega.agregarCompartimiento A44,0
EXEC Bodega.agregarCompartimiento A45,0
EXEC Bodega.agregarCompartimiento A46,0
EXEC Bodega.agregarCompartimiento A47,0
EXEC Bodega.agregarCompartimiento A48,0
EXEC Bodega.agregarCompartimiento A49,0
EXEC Bodega.agregarCompartimiento A51,0
EXEC Bodega.agregarCompartimiento A52,0
EXEC Bodega.agregarCompartimiento A53,0
EXEC Bodega.agregarCompartimiento A54,0
EXEC Bodega.agregarCompartimiento A55,0
EXEC Bodega.agregarCompartimiento A56,0
EXEC Bodega.agregarCompartimiento A57,0
EXEC Bodega.agregarCompartimiento A58,0
EXEC Bodega.agregarCompartimiento A59,0
EXEC Bodega.agregarCompartimiento A61,0
EXEC Bodega.agregarCompartimiento A62,0
EXEC Bodega.agregarCompartimiento A63,0
EXEC Bodega.agregarCompartimiento A64,0
EXEC Bodega.agregarCompartimiento A65,0
EXEC Bodega.agregarCompartimiento A66,0
EXEC Bodega.agregarCompartimiento A67,0
EXEC Bodega.agregarCompartimiento A68,0
EXEC Bodega.agregarCompartimiento A69,0
EXEC Bodega.agregarCompartimiento A71,0
EXEC Bodega.agregarCompartimiento A72,0
EXEC Bodega.agregarCompartimiento A73,0
EXEC Bodega.agregarCompartimiento A74,0
EXEC Bodega.agregarCompartimiento A75,0
EXEC Bodega.agregarCompartimiento A76,0
EXEC Bodega.agregarCompartimiento A77,0
EXEC Bodega.agregarCompartimiento A78,0
EXEC Bodega.agregarCompartimiento A79,0
EXEC Bodega.agregarCompartimiento A81,0
EXEC Bodega.agregarCompartimiento A82,0
EXEC Bodega.agregarCompartimiento A83,0
EXEC Bodega.agregarCompartimiento A84,0
EXEC Bodega.agregarCompartimiento A85,0
EXEC Bodega.agregarCompartimiento A86,0
EXEC Bodega.agregarCompartimiento A87,0
EXEC Bodega.agregarCompartimiento A88,0
EXEC Bodega.agregarCompartimiento A89,0
EXEC Bodega.agregarCompartimiento B11,0
EXEC Bodega.agregarCompartimiento B12,0
EXEC Bodega.agregarCompartimiento B13,0
EXEC Bodega.agregarCompartimiento B14,0
EXEC Bodega.agregarCompartimiento B15,0
EXEC Bodega.agregarCompartimiento B16,0
EXEC Bodega.agregarCompartimiento B17,0
EXEC Bodega.agregarCompartimiento B18,0
EXEC Bodega.agregarCompartimiento B19,0
EXEC Bodega.agregarCompartimiento B21,0
EXEC Bodega.agregarCompartimiento B22,0
EXEC Bodega.agregarCompartimiento B23,0
EXEC Bodega.agregarCompartimiento B24,0
EXEC Bodega.agregarCompartimiento B25,0
EXEC Bodega.agregarCompartimiento B26,0
EXEC Bodega.agregarCompartimiento B27,0
EXEC Bodega.agregarCompartimiento B28,0
EXEC Bodega.agregarCompartimiento B29,0
EXEC Bodega.agregarCompartimiento B31,0
EXEC Bodega.agregarCompartimiento B32,0
EXEC Bodega.agregarCompartimiento B33,0
EXEC Bodega.agregarCompartimiento B34,0
EXEC Bodega.agregarCompartimiento B35,0
EXEC Bodega.agregarCompartimiento B36,0
EXEC Bodega.agregarCompartimiento B37,0
EXEC Bodega.agregarCompartimiento B38,0
EXEC Bodega.agregarCompartimiento B39,0
EXEC Bodega.agregarCompartimiento B41,0
EXEC Bodega.agregarCompartimiento B42,0
EXEC Bodega.agregarCompartimiento B43,0
EXEC Bodega.agregarCompartimiento B44,0
EXEC Bodega.agregarCompartimiento B45,0
EXEC Bodega.agregarCompartimiento B46,0
EXEC Bodega.agregarCompartimiento B47,0
EXEC Bodega.agregarCompartimiento B48,0
EXEC Bodega.agregarCompartimiento B49,0
EXEC Bodega.agregarCompartimiento B51,0
EXEC Bodega.agregarCompartimiento B52,0
EXEC Bodega.agregarCompartimiento B53,0
EXEC Bodega.agregarCompartimiento B54,0
EXEC Bodega.agregarCompartimiento B55,0
EXEC Bodega.agregarCompartimiento B56,0
EXEC Bodega.agregarCompartimiento B57,0
EXEC Bodega.agregarCompartimiento B58,0
EXEC Bodega.agregarCompartimiento B59,0
EXEC Bodega.agregarCompartimiento B61,0
EXEC Bodega.agregarCompartimiento B62,0
EXEC Bodega.agregarCompartimiento B63,0
EXEC Bodega.agregarCompartimiento B64,0
EXEC Bodega.agregarCompartimiento B65,0
EXEC Bodega.agregarCompartimiento B66,0
EXEC Bodega.agregarCompartimiento B67,0
EXEC Bodega.agregarCompartimiento B68,0
EXEC Bodega.agregarCompartimiento B69,0
EXEC Bodega.agregarCompartimiento B71,0
EXEC Bodega.agregarCompartimiento B72,0
EXEC Bodega.agregarCompartimiento B73,0
EXEC Bodega.agregarCompartimiento B74,0
EXEC Bodega.agregarCompartimiento B75,0
EXEC Bodega.agregarCompartimiento B76,0
EXEC Bodega.agregarCompartimiento B77,0
EXEC Bodega.agregarCompartimiento B78,0
EXEC Bodega.agregarCompartimiento B79,0
EXEC Bodega.agregarCompartimiento B81,0
EXEC Bodega.agregarCompartimiento B82,0
EXEC Bodega.agregarCompartimiento B83,0
EXEC Bodega.agregarCompartimiento B84,0
EXEC Bodega.agregarCompartimiento B85,0
EXEC Bodega.agregarCompartimiento B86,0
EXEC Bodega.agregarCompartimiento B87,0
EXEC Bodega.agregarCompartimiento B88,0
EXEC Bodega.agregarCompartimiento B89,0
EXEC Bodega.agregarCompartimiento C11,0
EXEC Bodega.agregarCompartimiento C12,0
EXEC Bodega.agregarCompartimiento C13,0
EXEC Bodega.agregarCompartimiento C14,0
EXEC Bodega.agregarCompartimiento C15,0
EXEC Bodega.agregarCompartimiento C16,0
EXEC Bodega.agregarCompartimiento C17,0
EXEC Bodega.agregarCompartimiento C18,0
EXEC Bodega.agregarCompartimiento C19,0
EXEC Bodega.agregarCompartimiento C21,0
EXEC Bodega.agregarCompartimiento C22,0
EXEC Bodega.agregarCompartimiento C23,0
EXEC Bodega.agregarCompartimiento C24,0
EXEC Bodega.agregarCompartimiento C25,0
EXEC Bodega.agregarCompartimiento C26,0
EXEC Bodega.agregarCompartimiento C27,0
EXEC Bodega.agregarCompartimiento C28,0
EXEC Bodega.agregarCompartimiento C29,0
EXEC Bodega.agregarCompartimiento C31,0
EXEC Bodega.agregarCompartimiento C32,0
EXEC Bodega.agregarCompartimiento C33,0
EXEC Bodega.agregarCompartimiento C34,0
EXEC Bodega.agregarCompartimiento C35,0
EXEC Bodega.agregarCompartimiento C36,0
EXEC Bodega.agregarCompartimiento C37,0
EXEC Bodega.agregarCompartimiento C38,0
EXEC Bodega.agregarCompartimiento C39,0
EXEC Bodega.agregarCompartimiento C41,0
EXEC Bodega.agregarCompartimiento C42,0
EXEC Bodega.agregarCompartimiento C43,0
EXEC Bodega.agregarCompartimiento C44,0
EXEC Bodega.agregarCompartimiento C45,0
EXEC Bodega.agregarCompartimiento C46,0
EXEC Bodega.agregarCompartimiento C47,0
EXEC Bodega.agregarCompartimiento C48,0
EXEC Bodega.agregarCompartimiento C49,0
EXEC Bodega.agregarCompartimiento C51,0
EXEC Bodega.agregarCompartimiento C52,0
EXEC Bodega.agregarCompartimiento C53,0
EXEC Bodega.agregarCompartimiento C54,0
EXEC Bodega.agregarCompartimiento C55,0
EXEC Bodega.agregarCompartimiento C56,0
EXEC Bodega.agregarCompartimiento C57,0
EXEC Bodega.agregarCompartimiento C58,0
EXEC Bodega.agregarCompartimiento C59,0
EXEC Bodega.agregarCompartimiento C61,0
EXEC Bodega.agregarCompartimiento C62,0
EXEC Bodega.agregarCompartimiento C63,0
EXEC Bodega.agregarCompartimiento C64,0
EXEC Bodega.agregarCompartimiento C65,0
EXEC Bodega.agregarCompartimiento C66,0
EXEC Bodega.agregarCompartimiento C67,0
EXEC Bodega.agregarCompartimiento C68,0
EXEC Bodega.agregarCompartimiento C69,0
EXEC Bodega.agregarCompartimiento C71,0
EXEC Bodega.agregarCompartimiento C72,0
EXEC Bodega.agregarCompartimiento C73,0
EXEC Bodega.agregarCompartimiento C74,0
EXEC Bodega.agregarCompartimiento C75,0
EXEC Bodega.agregarCompartimiento C76,0
EXEC Bodega.agregarCompartimiento C77,0
EXEC Bodega.agregarCompartimiento C78,0
EXEC Bodega.agregarCompartimiento C79,0
EXEC Bodega.agregarCompartimiento C81,0
EXEC Bodega.agregarCompartimiento C82,0
EXEC Bodega.agregarCompartimiento C83,0
EXEC Bodega.agregarCompartimiento C84,0
EXEC Bodega.agregarCompartimiento C85,0
EXEC Bodega.agregarCompartimiento C86,0
EXEC Bodega.agregarCompartimiento C87,0
EXEC Bodega.agregarCompartimiento C88,0
EXEC Bodega.agregarCompartimiento C89,0
EXEC Bodega.agregarCompartimiento D11,0
EXEC Bodega.agregarCompartimiento D12,0
EXEC Bodega.agregarCompartimiento D13,0
EXEC Bodega.agregarCompartimiento D14,0
EXEC Bodega.agregarCompartimiento D15,0
EXEC Bodega.agregarCompartimiento D16,0
EXEC Bodega.agregarCompartimiento D17,0
EXEC Bodega.agregarCompartimiento D18,0
EXEC Bodega.agregarCompartimiento D19,0
EXEC Bodega.agregarCompartimiento D21,0
EXEC Bodega.agregarCompartimiento D22,0
EXEC Bodega.agregarCompartimiento D23,0
EXEC Bodega.agregarCompartimiento D24,0
EXEC Bodega.agregarCompartimiento D25,0
EXEC Bodega.agregarCompartimiento D26,0
EXEC Bodega.agregarCompartimiento D27,0
EXEC Bodega.agregarCompartimiento D28,0
EXEC Bodega.agregarCompartimiento D29,0
EXEC Bodega.agregarCompartimiento D31,0
EXEC Bodega.agregarCompartimiento D32,0
EXEC Bodega.agregarCompartimiento D33,0
EXEC Bodega.agregarCompartimiento D34,0
EXEC Bodega.agregarCompartimiento D35,0
EXEC Bodega.agregarCompartimiento D36,0
EXEC Bodega.agregarCompartimiento D37,0
EXEC Bodega.agregarCompartimiento D38,0
EXEC Bodega.agregarCompartimiento D39,0
EXEC Bodega.agregarCompartimiento D41,0
EXEC Bodega.agregarCompartimiento D42,0
EXEC Bodega.agregarCompartimiento D43,0
EXEC Bodega.agregarCompartimiento D44,0
EXEC Bodega.agregarCompartimiento D45,0
EXEC Bodega.agregarCompartimiento D46,0
EXEC Bodega.agregarCompartimiento D47,0
EXEC Bodega.agregarCompartimiento D48,0
EXEC Bodega.agregarCompartimiento D49,0
EXEC Bodega.agregarCompartimiento D51,0
EXEC Bodega.agregarCompartimiento D52,0
EXEC Bodega.agregarCompartimiento D53,0
EXEC Bodega.agregarCompartimiento D54,0
EXEC Bodega.agregarCompartimiento D55,0
EXEC Bodega.agregarCompartimiento D56,0
EXEC Bodega.agregarCompartimiento D57,0
EXEC Bodega.agregarCompartimiento D58,0
EXEC Bodega.agregarCompartimiento D59,0
EXEC Bodega.agregarCompartimiento D61,0
EXEC Bodega.agregarCompartimiento D62,0
EXEC Bodega.agregarCompartimiento D63,0
EXEC Bodega.agregarCompartimiento D64,0
EXEC Bodega.agregarCompartimiento D65,0
EXEC Bodega.agregarCompartimiento D66,0
EXEC Bodega.agregarCompartimiento D67,0
EXEC Bodega.agregarCompartimiento D68,0
EXEC Bodega.agregarCompartimiento D69,0
EXEC Bodega.agregarCompartimiento D71,0
EXEC Bodega.agregarCompartimiento D72,0
EXEC Bodega.agregarCompartimiento D73,0
EXEC Bodega.agregarCompartimiento D74,0
EXEC Bodega.agregarCompartimiento D75,0
EXEC Bodega.agregarCompartimiento D76,1
EXEC Bodega.agregarCompartimiento D77,0
EXEC Bodega.agregarCompartimiento D78,0
EXEC Bodega.agregarCompartimiento D79,0
EXEC Bodega.agregarCompartimiento D81,0
EXEC Bodega.agregarCompartimiento D82,0
EXEC Bodega.agregarCompartimiento D83,0
EXEC Bodega.agregarCompartimiento D84,0
EXEC Bodega.agregarCompartimiento D85,0
EXEC Bodega.agregarCompartimiento D86,0
EXEC Bodega.agregarCompartimiento D87,0
EXEC Bodega.agregarCompartimiento D88,0
EXEC Bodega.agregarCompartimiento D89,0
EXEC Bodega.agregarCompartimiento E11,0
EXEC Bodega.agregarCompartimiento E12,0
EXEC Bodega.agregarCompartimiento E13,0
EXEC Bodega.agregarCompartimiento E14,0
EXEC Bodega.agregarCompartimiento E15,0
EXEC Bodega.agregarCompartimiento E16,0
EXEC Bodega.agregarCompartimiento E17,0
EXEC Bodega.agregarCompartimiento E18,0
EXEC Bodega.agregarCompartimiento E19,0
EXEC Bodega.agregarCompartimiento E21,0
EXEC Bodega.agregarCompartimiento E22,0
EXEC Bodega.agregarCompartimiento E23,0
EXEC Bodega.agregarCompartimiento E24,0
EXEC Bodega.agregarCompartimiento E25,0
EXEC Bodega.agregarCompartimiento E26,0
EXEC Bodega.agregarCompartimiento E27,0
EXEC Bodega.agregarCompartimiento E28,0
EXEC Bodega.agregarCompartimiento E29,0
EXEC Bodega.agregarCompartimiento E31,0
EXEC Bodega.agregarCompartimiento E32,0
EXEC Bodega.agregarCompartimiento E33,0
EXEC Bodega.agregarCompartimiento E34,0
EXEC Bodega.agregarCompartimiento E35,0
EXEC Bodega.agregarCompartimiento E36,0
EXEC Bodega.agregarCompartimiento E37,0
EXEC Bodega.agregarCompartimiento E38,0
EXEC Bodega.agregarCompartimiento E39,0
EXEC Bodega.agregarCompartimiento E41,0
EXEC Bodega.agregarCompartimiento E42,0
EXEC Bodega.agregarCompartimiento E43,0
EXEC Bodega.agregarCompartimiento E44,0
EXEC Bodega.agregarCompartimiento E45,0
EXEC Bodega.agregarCompartimiento E46,0
EXEC Bodega.agregarCompartimiento E47,0
EXEC Bodega.agregarCompartimiento E48,0
EXEC Bodega.agregarCompartimiento E49,0
EXEC Bodega.agregarCompartimiento E51,0
EXEC Bodega.agregarCompartimiento E52,0
EXEC Bodega.agregarCompartimiento E53,0
EXEC Bodega.agregarCompartimiento E54,0
EXEC Bodega.agregarCompartimiento E55,0
EXEC Bodega.agregarCompartimiento E56,0
EXEC Bodega.agregarCompartimiento E57,0
EXEC Bodega.agregarCompartimiento E58,0
EXEC Bodega.agregarCompartimiento E59,0
EXEC Bodega.agregarCompartimiento E61,0
EXEC Bodega.agregarCompartimiento E62,0
EXEC Bodega.agregarCompartimiento E63,0
EXEC Bodega.agregarCompartimiento E64,0
EXEC Bodega.agregarCompartimiento E65,0
EXEC Bodega.agregarCompartimiento E66,0
EXEC Bodega.agregarCompartimiento E67,0
EXEC Bodega.agregarCompartimiento E68,0
EXEC Bodega.agregarCompartimiento E69,0
EXEC Bodega.agregarCompartimiento E71,0
EXEC Bodega.agregarCompartimiento E72,0
EXEC Bodega.agregarCompartimiento E73,0
EXEC Bodega.agregarCompartimiento E74,0
EXEC Bodega.agregarCompartimiento E75,0
EXEC Bodega.agregarCompartimiento E76,0
EXEC Bodega.agregarCompartimiento E77,0
EXEC Bodega.agregarCompartimiento E78,0
EXEC Bodega.agregarCompartimiento E79,0
EXEC Bodega.agregarCompartimiento E81,0
EXEC Bodega.agregarCompartimiento E82,0
EXEC Bodega.agregarCompartimiento E83,0
EXEC Bodega.agregarCompartimiento E84,0
EXEC Bodega.agregarCompartimiento E85,0
EXEC Bodega.agregarCompartimiento E86,0
EXEC Bodega.agregarCompartimiento E87,0
EXEC Bodega.agregarCompartimiento E88,0
EXEC Bodega.agregarCompartimiento E89,0
EXEC Bodega.agregarCompartimiento F11,0
EXEC Bodega.agregarCompartimiento F12,0
EXEC Bodega.agregarCompartimiento F13,0
EXEC Bodega.agregarCompartimiento F14,0
EXEC Bodega.agregarCompartimiento F15,0
EXEC Bodega.agregarCompartimiento F16,0
EXEC Bodega.agregarCompartimiento F17,0
EXEC Bodega.agregarCompartimiento F18,0
EXEC Bodega.agregarCompartimiento F19,0
EXEC Bodega.agregarCompartimiento F21,0
EXEC Bodega.agregarCompartimiento F22,0
EXEC Bodega.agregarCompartimiento F23,0
EXEC Bodega.agregarCompartimiento F24,0
EXEC Bodega.agregarCompartimiento F25,0
EXEC Bodega.agregarCompartimiento F26,0
EXEC Bodega.agregarCompartimiento F27,0
EXEC Bodega.agregarCompartimiento F28,0
EXEC Bodega.agregarCompartimiento F29,0
EXEC Bodega.agregarCompartimiento F31,0
EXEC Bodega.agregarCompartimiento F32,0
EXEC Bodega.agregarCompartimiento F33,0
EXEC Bodega.agregarCompartimiento F34,0
EXEC Bodega.agregarCompartimiento F35,0
EXEC Bodega.agregarCompartimiento F36,0
EXEC Bodega.agregarCompartimiento F37,0
EXEC Bodega.agregarCompartimiento F38,0
EXEC Bodega.agregarCompartimiento F39,0
EXEC Bodega.agregarCompartimiento F41,0
EXEC Bodega.agregarCompartimiento F42,0
EXEC Bodega.agregarCompartimiento F43,0
EXEC Bodega.agregarCompartimiento F44,0
EXEC Bodega.agregarCompartimiento F45,0
EXEC Bodega.agregarCompartimiento F46,0
EXEC Bodega.agregarCompartimiento F47,0
EXEC Bodega.agregarCompartimiento F48,0
EXEC Bodega.agregarCompartimiento F49,0
EXEC Bodega.agregarCompartimiento F51,0
EXEC Bodega.agregarCompartimiento F52,0
EXEC Bodega.agregarCompartimiento F53,0
EXEC Bodega.agregarCompartimiento F54,0
EXEC Bodega.agregarCompartimiento F55,0
EXEC Bodega.agregarCompartimiento F56,0
EXEC Bodega.agregarCompartimiento F57,0
EXEC Bodega.agregarCompartimiento F58,0
EXEC Bodega.agregarCompartimiento F59,0
EXEC Bodega.agregarCompartimiento F61,0
EXEC Bodega.agregarCompartimiento F62,0
EXEC Bodega.agregarCompartimiento F63,0
EXEC Bodega.agregarCompartimiento F64,0
EXEC Bodega.agregarCompartimiento F65,0
EXEC Bodega.agregarCompartimiento F66,0
EXEC Bodega.agregarCompartimiento F67,0
EXEC Bodega.agregarCompartimiento F68,0
EXEC Bodega.agregarCompartimiento F69,0
EXEC Bodega.agregarCompartimiento F71,0
EXEC Bodega.agregarCompartimiento F72,0
EXEC Bodega.agregarCompartimiento F73,0
EXEC Bodega.agregarCompartimiento F74,0
EXEC Bodega.agregarCompartimiento F75,0
EXEC Bodega.agregarCompartimiento F76,0
EXEC Bodega.agregarCompartimiento F77,0
EXEC Bodega.agregarCompartimiento F78,0
EXEC Bodega.agregarCompartimiento F79,0
EXEC Bodega.agregarCompartimiento F81,0
EXEC Bodega.agregarCompartimiento F82,0
EXEC Bodega.agregarCompartimiento F83,0
EXEC Bodega.agregarCompartimiento F84,0
EXEC Bodega.agregarCompartimiento F85,0
EXEC Bodega.agregarCompartimiento F86,0
EXEC Bodega.agregarCompartimiento F87,0
EXEC Bodega.agregarCompartimiento F88,0
EXEC Bodega.agregarCompartimiento F89,0
EXEC Bodega.agregarCompartimiento G11,0
EXEC Bodega.agregarCompartimiento G12,0
EXEC Bodega.agregarCompartimiento G13,0
EXEC Bodega.agregarCompartimiento G14,0
EXEC Bodega.agregarCompartimiento G15,0
EXEC Bodega.agregarCompartimiento G16,0
EXEC Bodega.agregarCompartimiento G17,0
EXEC Bodega.agregarCompartimiento G18,0
EXEC Bodega.agregarCompartimiento G19,0
EXEC Bodega.agregarCompartimiento G21,0
EXEC Bodega.agregarCompartimiento G22,0
EXEC Bodega.agregarCompartimiento G23,0
EXEC Bodega.agregarCompartimiento G24,0
EXEC Bodega.agregarCompartimiento G25,0
EXEC Bodega.agregarCompartimiento G26,0
EXEC Bodega.agregarCompartimiento G27,0
EXEC Bodega.agregarCompartimiento G28,0
EXEC Bodega.agregarCompartimiento G29,0
EXEC Bodega.agregarCompartimiento G31,0
EXEC Bodega.agregarCompartimiento G32,0
EXEC Bodega.agregarCompartimiento G33,0
EXEC Bodega.agregarCompartimiento G34,0
EXEC Bodega.agregarCompartimiento G35,0
EXEC Bodega.agregarCompartimiento G36,0
EXEC Bodega.agregarCompartimiento G37,0
EXEC Bodega.agregarCompartimiento G38,0
EXEC Bodega.agregarCompartimiento G39,0
EXEC Bodega.agregarCompartimiento G41,0
EXEC Bodega.agregarCompartimiento G42,0
EXEC Bodega.agregarCompartimiento G43,0
EXEC Bodega.agregarCompartimiento G44,0
EXEC Bodega.agregarCompartimiento G45,0
EXEC Bodega.agregarCompartimiento G46,0
EXEC Bodega.agregarCompartimiento G47,0
EXEC Bodega.agregarCompartimiento G48,0
EXEC Bodega.agregarCompartimiento G49,0
EXEC Bodega.agregarCompartimiento G51,0
EXEC Bodega.agregarCompartimiento G52,0
EXEC Bodega.agregarCompartimiento G53,0
EXEC Bodega.agregarCompartimiento G54,0
EXEC Bodega.agregarCompartimiento G55,0
EXEC Bodega.agregarCompartimiento G56,0
EXEC Bodega.agregarCompartimiento G57,0
EXEC Bodega.agregarCompartimiento G58,0
EXEC Bodega.agregarCompartimiento G59,0
EXEC Bodega.agregarCompartimiento G61,0
EXEC Bodega.agregarCompartimiento G62,0
EXEC Bodega.agregarCompartimiento G63,0
EXEC Bodega.agregarCompartimiento G64,0
EXEC Bodega.agregarCompartimiento G65,0
EXEC Bodega.agregarCompartimiento G66,0
EXEC Bodega.agregarCompartimiento G67,0
EXEC Bodega.agregarCompartimiento G68,0
EXEC Bodega.agregarCompartimiento G69,0
EXEC Bodega.agregarCompartimiento G71,0
EXEC Bodega.agregarCompartimiento G72,0
EXEC Bodega.agregarCompartimiento G73,0
EXEC Bodega.agregarCompartimiento G74,0
EXEC Bodega.agregarCompartimiento G75,0
EXEC Bodega.agregarCompartimiento G76,0
EXEC Bodega.agregarCompartimiento G77,0
EXEC Bodega.agregarCompartimiento G78,0
EXEC Bodega.agregarCompartimiento G79,0
EXEC Bodega.agregarCompartimiento G81,0
EXEC Bodega.agregarCompartimiento G82,0
EXEC Bodega.agregarCompartimiento G83,0
EXEC Bodega.agregarCompartimiento G84,0
EXEC Bodega.agregarCompartimiento G85,0
EXEC Bodega.agregarCompartimiento G86,0
EXEC Bodega.agregarCompartimiento G87,0
EXEC Bodega.agregarCompartimiento G88,0
EXEC Bodega.agregarCompartimiento G89,0
EXEC Bodega.agregarCompartimiento H11,0
EXEC Bodega.agregarCompartimiento H12,0
EXEC Bodega.agregarCompartimiento H13,1
EXEC Bodega.agregarCompartimiento H14,0
EXEC Bodega.agregarCompartimiento H15,0
EXEC Bodega.agregarCompartimiento H16,0
EXEC Bodega.agregarCompartimiento H17,0
EXEC Bodega.agregarCompartimiento H18,0
EXEC Bodega.agregarCompartimiento H19,0
EXEC Bodega.agregarCompartimiento H21,0
EXEC Bodega.agregarCompartimiento H22,0
EXEC Bodega.agregarCompartimiento H23,0
EXEC Bodega.agregarCompartimiento H24,0
EXEC Bodega.agregarCompartimiento H25,0
EXEC Bodega.agregarCompartimiento H26,0
EXEC Bodega.agregarCompartimiento H27,0
EXEC Bodega.agregarCompartimiento H28,0
EXEC Bodega.agregarCompartimiento H29,0
EXEC Bodega.agregarCompartimiento H31,0
EXEC Bodega.agregarCompartimiento H32,0
EXEC Bodega.agregarCompartimiento H33,0
EXEC Bodega.agregarCompartimiento H34,0
EXEC Bodega.agregarCompartimiento H35,0
EXEC Bodega.agregarCompartimiento H36,0
EXEC Bodega.agregarCompartimiento H37,0
EXEC Bodega.agregarCompartimiento H38,0
EXEC Bodega.agregarCompartimiento H39,0
EXEC Bodega.agregarCompartimiento H41,0
EXEC Bodega.agregarCompartimiento H42,0
EXEC Bodega.agregarCompartimiento H43,0
EXEC Bodega.agregarCompartimiento H44,0
EXEC Bodega.agregarCompartimiento H45,0
EXEC Bodega.agregarCompartimiento H46,0
EXEC Bodega.agregarCompartimiento H47,0
EXEC Bodega.agregarCompartimiento H48,0
EXEC Bodega.agregarCompartimiento H49,0
EXEC Bodega.agregarCompartimiento H51,0
EXEC Bodega.agregarCompartimiento H52,0
EXEC Bodega.agregarCompartimiento H53,0
EXEC Bodega.agregarCompartimiento H54,0
EXEC Bodega.agregarCompartimiento H55,0
EXEC Bodega.agregarCompartimiento H56,0
EXEC Bodega.agregarCompartimiento H57,0
EXEC Bodega.agregarCompartimiento H58,0
EXEC Bodega.agregarCompartimiento H59,0
EXEC Bodega.agregarCompartimiento H61,0
EXEC Bodega.agregarCompartimiento H62,0
EXEC Bodega.agregarCompartimiento H63,0
EXEC Bodega.agregarCompartimiento H64,0
EXEC Bodega.agregarCompartimiento H65,0
EXEC Bodega.agregarCompartimiento H66,0
EXEC Bodega.agregarCompartimiento H67,0
EXEC Bodega.agregarCompartimiento H68,0
EXEC Bodega.agregarCompartimiento H69,0
EXEC Bodega.agregarCompartimiento H71,0
EXEC Bodega.agregarCompartimiento H72,0
EXEC Bodega.agregarCompartimiento H73,0
EXEC Bodega.agregarCompartimiento H74,0
EXEC Bodega.agregarCompartimiento H75,0
EXEC Bodega.agregarCompartimiento H76,0
EXEC Bodega.agregarCompartimiento H77,0
EXEC Bodega.agregarCompartimiento H78,0
EXEC Bodega.agregarCompartimiento H79,0
EXEC Bodega.agregarCompartimiento H81,0
EXEC Bodega.agregarCompartimiento H82,0
EXEC Bodega.agregarCompartimiento H83,0
EXEC Bodega.agregarCompartimiento H84,0
EXEC Bodega.agregarCompartimiento H85,0
EXEC Bodega.agregarCompartimiento H86,0
EXEC Bodega.agregarCompartimiento H87,0
EXEC Bodega.agregarCompartimiento H88,0
EXEC Bodega.agregarCompartimiento H89,0

EXEC Compra.agregarProveedor 'Textiles Alcacer','Boulevard los procesores, Edificio #4 Poligono #40','2383-9802','alcacerTextil@gmail.com'
EXEC Compra.agregarProveedor 'Variedades Margarita','Mercado central, San Salvador puesto #44','2643-3241','margaritahilos@gmail.com'
EXEC Compra.agregarProveedor 'Dinora´s Tela','Paseo General el escalón edificio #4, contiguo a pollo campero','2908-3221','dinotelas@gmail.com'
EXEC Compra.agregarProveedor 'Textiles la fina','Boulevard los procesores, Edificio #23, local #2','2451-4312','textilesFina@gmail.com'
EXEC Compra.agregarProveedor 'Variedades el cartel','Calle a el puerto de la libertad, en centro comercial la libertad, local #24','2241-2536','varietycartel@gmail.com'
EXEC Compra.agregarProveedor 'Tintas PrintLN','Metrocento,San Salvador contiguo a Raf, local #234','2013-2013','printLnesa@outlook.com'
EXEC Compra.agregarProveedor 'Textufil La libertad','Ciudad Merliot, calle el dolar,Centro comercial Merliot, local #32','2416-2413','textufilLibertad@gmail.com'
EXEC Compra.agregarProveedor 'Textufil San Miguel','Calle de Hotel Florencia, contiguo a Pizza Hut','2416-3215','textufilSanMiguel@gmail.com'
EXEC Compra.agregarProveedor 'Hilo y aguja','Avenida bernal, San Salvador enfrente de COSASE','2361-7513','hiloagujabernal@gmail.com'
EXEC Compra.agregarProveedor 'Textiles Fine','Paseo general Escalón edificio #2, local #654','2163-2451','finetextilescalon@gmail.com'
EXEC Compra.agregarProveedor 'Fabric Fine','Boulevard constitucion, por gasolinera PUMA, edificio #1','2411-2014','fabricfine@gmail.com'
EXEC Compra.agregarProveedor 'Diamond Fabric','Boulevard de los procesores, frente a banco Scotiabank','2383-1234','diamondFabric@gmail.com'
EXEC Compra.agregarProveedor 'Platinum Fabric','Boulevard los soldados, Edificio #4 Poligono #45','2743-3241','platinumgabric@gmail.com'
EXEC Compra.agregarProveedor 'Textiles Salutaris','Boulevard los procesores, Edificio #7 Poligono #48','2523-4335','salutaristela@gmail.com'
EXEC Compra.agregarProveedor 'Textiles Linaza','Boulevard los procesores, Edificio #12 Poligono #54','2341-2555','textileslinaza@gmail.com'
EXEC Compra.agregarProveedor 'Threads Gold','Galerias San Salvador, Edificio #1 Poligono #40, 1º Nivel','2111-1112','theadsgolds@gmail.com'
EXEC Compra.agregarProveedor 'Threads Bold','Soyapango San Salvador,Calle La comunal Poligono #40','7622-1122','hilosgruesos@gmail.com'
EXEC Compra.agregarProveedor 'Textiles Armario','Boulevard los procesores, Edificio #8 Poligono #50','2012-2022','armariotextil@gmail.com'
EXEC Compra.agregarProveedor 'Textiles conacastes','Boulevard la constitucion, Edificio #9 Poligono #2','2432-8032','los_conacastestextil@gmail.com'
EXEC Compra.agregarProveedor 'Textiles Imperio','Galerias Escalón, local #21','2321-4452','textilesImperio@gmail.com'
EXEC Compra.agregarProveedor 'Imperio Real','Las Cascadas, Santa Tecla, local #21','2323-2231','imperiorial@gmail.com'
EXEC Compra.agregarProveedor 'Textiles Unique','Plaza Mundo San Salvador, Local #21, 2º Nivel','2149-2117','txtilUnique@gmail.com'
EXEC Compra.agregarProveedor 'Textiles Dembele','Galerias Escalón, frente a Pollo Real, poligono #2','2789-2122','textildembele@gmail.com'
EXEC Compra.agregarProveedor 'Needle Gold','Ciudad Delgado, calle la brisa edificio verde #12','2721-3221','needlegold@gmail.com'
EXEC Compra.agregarProveedor 'Textiles Sweet','Boulevard la constitucion, Edificio #10, local #1','6751-2121','sweetneedle@gmail.com'
EXEC Compra.agregarProveedor 'Textiles Don Bosco','Boulevard los procesores, Edificio #31 Poligono #21','2123-3212','donBoscoTextil@gmail.com'
EXEC Compra.agregarProveedor 'Variedades Imperio','Mercado central, San Salvador puesto #12','7610-2123','imperiosusa@gmail.com'
EXEC Compra.agregarProveedor 'Dora´s Tela','Paseo General el escalón edificio #7, contiguo a pizza hut','2113-2232','dorastela@gmail.com'
EXEC Compra.agregarProveedor 'Textiles Josefina','Boulevard los procesores, Edificio #99, local #12','6712-4342','textilesjosefina@gmail.com'
EXEC Compra.agregarProveedor 'Variedades la Tenchis','Calle a Cuscatlán, Kilometro #66, Edificio Blanco #89','2692-2556','latenchistelas@gmail.com'
EXEC Compra.agregarProveedor 'Tintas Fortaleza','Metrocento,San Salvador contiguo a panaderia el rosario, local #124','2050-2013','fortaleztinta@outlook.com'
EXEC Compra.agregarProveedor 'Textufil La paz','Ciudad Nuevo Mundo, calle speakers,edificio #90','2098-2086','textufilPaz@gmail.com'
EXEC Compra.agregarProveedor 'Needle and Style','Calle de Hotel Juventus contiguo a Papa John´s','2314-3257','needlestyle@gmail.com'
EXEC Compra.agregarProveedor 'Sant Patricia','Avenida la vega, San Salvador enfrente de China Work','2000-2136','santpatricia@gmail.com'
EXEC Compra.agregarProveedor 'Pintura Fine','Paseo general Escalón Nivel #1, local #98','2190-3246','pinturafine@gmail.com'
EXEC Compra.agregarProveedor 'Tinta Los Santos','Boulevard de los heroes, por Jugueton, edificio #7','2411-2014','fabricfine@gmail.com'
EXEC Compra.agregarProveedor 'Needle and Fabric','Boulevard de los procesores, frente a banco Davivienda','2426-3234','needlefabric@gmail.com'
EXEC Compra.agregarProveedor 'Lightning Fabric','Boulevard los soldados, Edificio #72 Poligono #09','6823-3215','lighningfabricESA@gmail.com'
EXEC Compra.agregarProveedor 'Variedades Jeltrudis','Mercado Zacamil,Mejicanos, puesto #55','2983-4343','jeltrudisvariety@gmail.com'
EXEC Compra.agregarProveedor 'Textiles Guzman','Boulevard los procesores, Edificio #64 Poligono #32','2641-2555','textileslinaza@gmail.com'
EXEC Compra.agregarProveedor 'Threads Prime','Galerias San Salvador, Nivel #3 local #42','6109-1112','theadsprime@gmail.com'
EXEC Compra.agregarProveedor 'Threads Falcon','Soyapango San Salvador,Calle hacia Plaza mundo Poligono #48','2083-4321','hilosfalconmaster@gmail.com'
EXEC Compra.agregarProveedor 'Master Textiles','Boulevard los almendros, Edificio #10 Poligono #2','2042-4202','mastertelas@gmail.com'
EXEC Compra.agregarProveedor 'Variedades la Esquinita','Mercado central San salvador, puesto #65','2803-4351','variedadeslaesquinita@gmail.com'
EXEC Compra.agregarProveedor 'Telas Lemus','Galerias Escalón, local #68','2225-4355','telaslemus@gmail.com'
EXEC Compra.agregarProveedor 'El imperio de los hilos','Las Cascadas, Santa Tecla, local #29','6023-3221','imperiothreads@gmail.com'
EXEC Compra.agregarProveedor 'Pinturas la unica','Plaza Mundo San Salvador, Local #29, 1º Nivel','2808-2997','pinturaslaunica@gmail.com'
EXEC Compra.agregarProveedor 'Textiles Coutinho','Galerias Escalón, frente a Pollo bonanza, poligono #7','2942-2563','textilcoutinho@gmail.com'
EXEC Compra.agregarProveedor 'Needle Miguel','Ciudad Delgado, calle el sol edificio amarillo #12','2934-3424','needlemigueESA@gmail.com'
EXEC Compra.agregarProveedor 'Pinturas el Bucanero','Boulevard la constitucion,a tres cuadras despues de Walmart Edificio #10','2314-2319','elbucaneroesa@gmail.com'

EXEC Bodega.agregarMateriaPrima 'Tela Tipo Velvetón',450,750,1,A11,1,1
EXEC Bodega.agregarMateriaPrima 'Tela Tipo Damasco', 500, 500, 1, A12, 1, 1
EXEC Bodega.agregarMateriaPrima 'Tela Tipo Lona', 600, 650, 1, A13, 2, 2
EXEC Bodega.agregarMateriaPrima 'Tela Tipo Gabardina', 200, 500, 1, A14, 3, 3
EXEC Bodega.agregarMateriaPrima 'Tela Tipo Felpa', 200, 500, 1, A15, 5, 2
EXEC Bodega.agregarMateriaPrima 'Tela Tipo Felpa', 200, 500, 1, A16, 1, 2
EXEC Bodega.agregarMateriaPrima 'Tela Tipo Felpa', 300, 500, 1, A17, 6, 2
EXEC Bodega.agregarMateriaPrima 'Tela Tipo Felpa', 300, 500, 1, A18, 8, 2
EXEC Bodega.agregarMateriaPrima 'Tela Tipo Felpa', 300, 500, 1, A19, 5, 2
EXEC Bodega.agregarMateriaPrima 'Tela Tipo Gabardina', 600, 800, 1, A21, 5, 3
EXEC Bodega.agregarMateriaPrima 'Tela Tipo Gabardina', 600, 800, 1, A22, 8, 3
EXEC Bodega.agregarMateriaPrima 'Tela Tipo Gabardina', 600, 800, 1, A23, 12, 3
EXEC Bodega.agregarMateriaPrima 'Tela Tipo Gabardina', 600, 800, 1, A24, 25, 3
EXEC Bodega.agregarMateriaPrima 'Tela Tipo Gabardina', 600, 800, 1, A25, 27, 3
EXEC Bodega.agregarMateriaPrima 'Hilo de Nylon', 1200, 8000, 2, A26, 1, 10
EXEC Bodega.agregarMateriaPrima 'Hilo de Nylon', 1200, 8000, 2, A27, 2, 10
EXEC Bodega.agregarMateriaPrima 'Hilo de Nylon', 1200, 8000, 2, A28, 3, 10
EXEC Bodega.agregarMateriaPrima 'Hilo de Nylon', 1200, 8000, 2, A29, 4, 10
EXEC Bodega.agregarMateriaPrima 'Hilo de Nylon', 1200, 8000, 2, A31, 5, 10
EXEC Bodega.agregarMateriaPrima 'Hilo de Nylon', 1200, 8000, 2, A32, 40, 10
EXEC Bodega.agregarMateriaPrima 'Hilo de Poliester', 1500, 8000, 2, A33, 7, 11
EXEC Bodega.agregarMateriaPrima 'Hilo de Poliester', 1500, 8000, 2, A34, 6, 11
EXEC Bodega.agregarMateriaPrima 'Hilo de Poliester', 1500, 8000, 2, A35, 25, 11
EXEC Bodega.agregarMateriaPrima 'Hilo de Poliester', 1500, 8000, 2, A36, 6, 11
EXEC Bodega.agregarMateriaPrima 'Hilo de Poliester', 1500, 8000, 2, A37, 12, 11
EXEC Bodega.agregarMateriaPrima 'Hilo de Poliester', 1500, 8000, 2, A38, 13, 11
EXEC Bodega.agregarMateriaPrima 'Hilo de Poliester', 1500, 8000, 2, A39, 14, 11
EXEC Bodega.agregarMateriaPrima 'Tela Tipo Tul', 2000, 2400, 1, A41, 1, 5
EXEC Bodega.agregarMateriaPrima 'Tela Tipo Tul', 2000, 2400, 1, A42, 2, 5
EXEC Bodega.agregarMateriaPrima 'Tela Tipo Tul', 2000, 2400, 1, A43, 42, 5
EXEC Bodega.agregarMateriaPrima 'Tela Tipo Tul', 2000, 2400, 1, A44, 5, 5
EXEC Bodega.agregarMateriaPrima 'Tela Tipo Tul', 2000, 2400, 1, A45, 7, 5
EXEC Bodega.agregarMateriaPrima 'Tela Tipo Tul', 2000, 2400, 1, A46, 3, 5
EXEC Bodega.agregarMateriaPrima 'Tela Tipo Tul', 2000, 2400, 1, A47, 18, 5
EXEC Bodega.agregarMateriaPrima 'Tela Tipo Tul', 2000, 2400, 1, A48, 19, 5
EXEC Bodega.agregarMateriaPrima 'Tela Tipo Tul', 2000, 2400, 1, A49, 21, 5
EXEC Bodega.agregarMateriaPrima 'Cordón tipo natuico', 1000, 1400, 3, A51, 1, 6
EXEC Bodega.agregarMateriaPrima 'Cordón tipo natuico', 1000, 1400, 3, A52, 2, 6
EXEC Bodega.agregarMateriaPrima 'Cordón tipo natuico', 1000, 1400, 3, A53, 3, 6
EXEC Bodega.agregarMateriaPrima 'Cordón tipo natuico', 1000, 1400, 3, A54, 5, 6
EXEC Bodega.agregarMateriaPrima 'Cordón tipo natuico', 1000, 1400, 3, A55, 25, 6
EXEC Bodega.agregarMateriaPrima 'Cordón tipo natuico', 1000, 1400, 3, A55, 28, 6
EXEC Bodega.agregarMateriaPrima 'Cordón tipo natuico', 1000, 1400, 3, A56, 29, 6
EXEC Bodega.agregarMateriaPrima 'Cordón tipo natuico', 1000, 1400, 3, A57, 7, 6
EXEC Bodega.agregarMateriaPrima 'Anilina', 800, 1400, 3, A58, 1, 50
EXEC Bodega.agregarMateriaPrima 'Anilina', 800, 1400, 3, A59, 2, 50
EXEC Bodega.agregarMateriaPrima 'Anilina', 800, 1400, 3, A61, 3, 50
EXEC Bodega.agregarMateriaPrima 'Anilina', 800, 1400, 3, A62, 4, 50
EXEC Bodega.agregarMateriaPrima 'Anilina', 800, 1400, 3, A63, 5, 50
EXEC Bodega.agregarMateriaPrima 'Anilina', 800, 1400, 3, A64, 6, 50
EXEC Bodega.agregarMateriaPrima 'Anilina', 800, 1400, 3, A65, 7, 50

EXEC Compra.agregarEstadoCompras 'Normal'
EXEC Compra.agregarEstadoCompras 'Urgente'
EXEC Compra.agregarEstadoCompras 'Realizada'

EXEC Compra.agregarCompra 600, 1, 1;
EXEC Compra.agregarCompra 300, 1, 2;
EXEC Compra.agregarCompra 200, 1, 3;
EXEC Compra.agregarCompra 100, 1, 4;
EXEC Compra.agregarCompra 400, 1, 5;
EXEC Compra.agregarCompra 300, 1, 6;
EXEC Compra.agregarCompra 100, 1, 7;
EXEC Compra.agregarCompra 450, 1, 8;
EXEC Compra.agregarCompra 200, 1, 9;
EXEC Compra.agregarCompra 520, 1, 10;
EXEC Compra.agregarCompra 600, 1, 11;
EXEC Compra.agregarCompra 700, 1, 12;
EXEC Compra.agregarCompra 250, 1, 13;
EXEC Compra.agregarCompra 300, 1, 14;
EXEC Compra.agregarCompra 3500, 1, 15;
EXEC Compra.agregarCompra 5500, 1, 16;
EXEC Compra.agregarCompra 1520, 1, 17;
EXEC Compra.agregarCompra 6850, 1, 18;
EXEC Compra.agregarCompra 1650, 1, 19;
EXEC Compra.agregarCompra 6520, 1, 20;
EXEC Compra.agregarCompra 7650, 1, 21;
EXEC Compra.agregarCompra 6520, 1, 22;
EXEC Compra.agregarCompra 157, 1, 23;
EXEC Compra.agregarCompra 870, 1, 24;
EXEC Compra.agregarCompra 6080, 1, 25;
EXEC Compra.agregarCompra 7500, 1, 26;
EXEC Compra.agregarCompra 606, 1, 27;
EXEC Compra.agregarCompra 666, 1, 28;
EXEC Compra.agregarCompra 1950, 1, 29;
EXEC Compra.agregarCompra 2000, 1, 30;
EXEC Compra.agregarCompra 180, 1, 31;
EXEC Compra.agregarCompra 607, 1, 32;
EXEC Compra.agregarCompra 1250, 1, 33;
EXEC Compra.agregarCompra 2050, 1, 34;
EXEC Compra.agregarCompra 2300, 1, 35;
EXEC Compra.agregarCompra 900, 1, 36;
EXEC Compra.agregarCompra 1000, 1, 37;
EXEC Compra.agregarCompra 150, 1, 38;
EXEC Compra.agregarCompra 698, 1, 39;
EXEC Compra.agregarCompra 784, 1, 40;
EXEC Compra.agregarCompra 685, 1, 41;
EXEC Compra.agregarCompra 1000, 1, 42;
EXEC Compra.agregarCompra 1350, 1, 43;
EXEC Compra.agregarCompra 600, 1, 44;
EXEC Compra.agregarCompra 800, 1, 45;
EXEC Compra.agregarCompra 150, 1, 46;
EXEC Compra.agregarCompra 250, 1, 47;
EXEC Compra.agregarCompra 600, 1, 48;
EXEC Compra.agregarCompra 1000, 1, 49;
EXEC Compra.agregarCompra 1250, 1, 50;

EXEC Produccion.agregarOrdenVenta 1, 5, 1, 20, 1;
EXEC Produccion.agregarOrdenVenta 1, 5, 1, 4, 1;
EXEC Produccion.agregarOrdenVenta 3, 10, 2, 4, 1;
EXEC Produccion.agregarOrdenVenta 4, 28, 3, 6, 1;
EXEC Produccion.agregarOrdenVenta 5, 47, 1, 8, 1;
EXEC Produccion.agregarOrdenVenta 5, 47, 2, 5, 1;
EXEC Produccion.agregarOrdenVenta 7, 30, 2, 6, 1;
EXEC Produccion.agregarOrdenVenta 8, 24, 2, 8, 1;
EXEC Produccion.agregarOrdenVenta 9, 46, 1, 2, 1;
EXEC Produccion.agregarOrdenVenta 10, 18, 1, 20, 1;
EXEC Produccion.agregarOrdenVenta 11, 19, 3, 3, 1;
EXEC Produccion.agregarOrdenVenta 12, 1, 2, 2, 1;
EXEC Produccion.agregarOrdenVenta 13, 19, 1, 45, 1;
EXEC Produccion.agregarOrdenVenta 14, 8, 2, 50, 1;
EXEC Produccion.agregarOrdenVenta 15, 9, 1, 30, 1;
EXEC Produccion.agregarOrdenVenta 16, 7, 1, 5, 1;
EXEC Produccion.agregarOrdenVenta 16, 7, 1, 6, 1;
EXEC Produccion.agregarOrdenVenta 16, 7, 2, 8, 1;
EXEC Produccion.agregarOrdenVenta 19, 25, 2, 6, 1;
EXEC Produccion.agregarOrdenVenta 20, 7, 2, 7, 1;
EXEC Produccion.agregarOrdenVenta 21, 36, 3, 40, 1;
EXEC Produccion.agregarOrdenVenta 21, 36, 3, 15, 1;
EXEC Produccion.agregarOrdenVenta 21, 36, 2, 20, 1;
EXEC Produccion.agregarOrdenVenta 21, 36, 1, 18, 1;
EXEC Produccion.agregarOrdenVenta 21, 36, 2, 5, 1;
EXEC Produccion.agregarOrdenVenta 26, 7, 1, 8, 1;
EXEC Produccion.agregarOrdenVenta 27, 8, 3, 9, 1;
EXEC Produccion.agregarOrdenVenta 28, 15, 3, 7, 1;
EXEC Produccion.agregarOrdenVenta 29, 21, 1, 20, 1;
EXEC Produccion.agregarOrdenVenta 30, 41, 2, 23, 1;
EXEC Produccion.agregarOrdenVenta 31, 49, 3, 12, 1;
EXEC Produccion.agregarOrdenVenta 32, 15, 1, 40, 1;
EXEC Produccion.agregarOrdenVenta 33, 18, 2, 25, 1;
EXEC Produccion.agregarOrdenVenta 34, 9, 1, 27, 1;
EXEC Produccion.agregarOrdenVenta 34, 9, 3, 50, 1;
EXEC Produccion.agregarOrdenVenta 34, 9, 1, 2, 1;
EXEC Produccion.agregarOrdenVenta 37, 6, 2, 8, 1;
EXEC Produccion.agregarOrdenVenta 38, 7, 3, 9, 1;
EXEC Produccion.agregarOrdenVenta 39, 20, 2, 8, 1;
EXEC Produccion.agregarOrdenVenta 39, 20, 1, 15, 1;
EXEC Produccion.agregarOrdenVenta 41, 45, 3, 26, 1;
EXEC Produccion.agregarOrdenVenta 41, 45, 2, 37, 1;
EXEC Produccion.agregarOrdenVenta 43, 37, 1, 18, 1;
EXEC Produccion.agregarOrdenVenta 44, 38, 3, 19, 1;
EXEC Produccion.agregarOrdenVenta 45, 14, 2, 50, 1;
EXEC Produccion.agregarOrdenVenta 46, 17, 3, 49, 1;
EXEC Produccion.agregarOrdenVenta 47, 7, 2, 5, 1;
EXEC Produccion.agregarOrdenVenta 48, 8, 1, 5, 1;
EXEC Produccion.agregarOrdenVenta 49, 26, 2, 6, 1;
EXEC Produccion.agregarOrdenVenta 50, 29, 3, 5, 1;

EXEC Produccion.agregarOrdenVentaTalla 20, 10.5, idTalla, 5, 1;
EXEC Produccion.agregarOrdenVentaTalla 20, 50, idTalla, 1, 2;
EXEC Produccion.agregarOrdenVentaTalla 26, 47.8, idTalla, 2, 3;
EXEC Produccion.agregarOrdenVentaTalla 25, 9, idTalla, 6, 4;
EXEC Produccion.agregarOrdenVentaTalla 14, 50.6, idTalla, 4, 5;
EXEC Produccion.agregarOrdenVentaTalla 26, 40, idTalla, 8, 6;
EXEC Produccion.agregarOrdenVentaTalla 10, 10, idTalla, 9, 7;
EXEC Produccion.agregarOrdenVentaTalla 40, 74, idTalla, 1, 8;
EXEC Produccion.agregarOrdenVentaTalla 16, 50, idTalla, 2, 9;
EXEC Produccion.agregarOrdenVentaTalla 25, 6.5, idTalla, 11, 10;
EXEC Produccion.agregarOrdenVentaTalla 16, 45.6, idTalla, 11, 11;
EXEC Produccion.agregarOrdenVentaTalla 14, 80.5, idTalla, 6, 12;
EXEC Produccion.agregarOrdenVentaTalla 29, 40.5, idTalla, 3, 13;
EXEC Produccion.agregarOrdenVentaTalla 9, 10, idTalla, 5, 14;
EXEC Produccion.agregarOrdenVentaTalla 7, 84.5, idTalla, 7, 15;
EXEC Produccion.agregarOrdenVentaTalla 15, 46, idTalla, 8, 16;
EXEC Produccion.agregarOrdenVentaTalla 16, 35, idTalla, 6, 17;
EXEC Produccion.agregarOrdenVentaTalla 31, 28, idTalla, 1, 18;
EXEC Produccion.agregarOrdenVentaTalla 17, 36, idTalla, 10, 19;
EXEC Produccion.agregarOrdenVentaTalla 29, 17, idTalla, 11, 20;
EXEC Produccion.agregarOrdenVentaTalla 8, 25, idTalla, 4, 21;
EXEC Produccion.agregarOrdenVentaTalla 17, 18, idTalla, 5, 22;
EXEC Produccion.agregarOrdenVentaTalla 16, 26, idTalla, 6, 23;
EXEC Produccion.agregarOrdenVentaTalla 32, 18, idTalla, 5, 24;
EXEC Produccion.agregarOrdenVentaTalla 17, 17, idTalla, 8, 25;
EXEC Produccion.agregarOrdenVentaTalla 16, 9.01, idTalla, 9, 26;
EXEC Produccion.agregarOrdenVentaTalla 17, 8.8, idTalla, 8, 27;
EXEC Produccion.agregarOrdenVentaTalla 16, 19.6, idTalla, 9, 28;
EXEC Produccion.agregarOrdenVentaTalla 19, 29.6, idTalla, 8, 29;
EXEC Produccion.agregarOrdenVentaTalla 27, 38.8, idTalla, 4, 30;
EXEC Produccion.agregarOrdenVentaTalla 18, 25, idTalla, 5, 31;
EXEC Produccion.agregarOrdenVentaTalla 19, 27, idTalla, 6, 32;
EXEC Produccion.agregarOrdenVentaTalla 25, 19.8, idTalla, 4, 33;
EXEC Produccion.agregarOrdenVentaTalla 26, 15.4, idTalla, 3, 34;
EXEC Produccion.agregarOrdenVentaTalla 9, 16.3, idTalla, 2, 35;
EXEC Produccion.agregarOrdenVentaTalla 7, 9.5, idTalla, 1, 36;
EXEC Produccion.agregarOrdenVentaTalla 46, 18.6, idTalla, 7, 37;
EXEC Produccion.agregarOrdenVentaTalla 8, 34.3, idTalla, 8, 38;
EXEC Produccion.agregarOrdenVentaTalla 9, 38.4, idTalla, 9, 39;
EXEC Produccion.agregarOrdenVentaTalla 8, 45.8, idTalla, 11, 40;
EXEC Produccion.agregarOrdenVentaTalla 7, 6, idTalla, 1, 41;
EXEC Produccion.agregarOrdenVentaTalla 20, 48, idTalla, 9, 42;
EXEC Produccion.agregarOrdenVentaTalla 20, 25, idTalla, 8, 43;
EXEC Produccion.agregarOrdenVentaTalla 16, 14, idTalla, 7, 44;
EXEC Produccion.agregarOrdenVentaTalla 17, 16, idTalla, 9, 45;
EXEC Produccion.agregarOrdenVentaTalla 26, 18.6, idTalla, 6, 46;
EXEC Produccion.agregarOrdenVentaTalla 47, 25.6, idTalla, 7, 47;
EXEC Produccion.agregarOrdenVentaTalla 59, 14.3, idTalla, 5, 48;
EXEC Produccion.agregarOrdenVentaTalla 45, 15.6, idTalla, 6, 49;
EXEC Produccion.agregarOrdenVentaTalla 25, 20.2, idTalla, 4, 50;

EXEC Produccion.agregarFlujoProceso 1, 2
EXEC Produccion.agregarFlujoProceso 1, 3
EXEC Produccion.agregarFlujoProceso 1, 4
EXEC Produccion.agregarFlujoProceso 1, 5
EXEC Produccion.agregarFlujoProceso 1, 6
EXEC Produccion.agregarFlujoProceso 1, 7
EXEC Produccion.agregarFlujoProceso 1, 10
EXEC Produccion.agregarFlujoProceso 1, 11
EXEC Produccion.agregarFlujoProceso 1, 12
EXEC Produccion.agregarFlujoProceso 1, 13
EXEC Produccion.agregarFlujoProceso 1, 14
EXEC Produccion.agregarFlujoProceso 2, 2
EXEC Produccion.agregarFlujoProceso 2, 3
EXEC Produccion.agregarFlujoProceso 2, 4
EXEC Produccion.agregarFlujoProceso 2, 5
EXEC Produccion.agregarFlujoProceso 2, 6
EXEC Produccion.agregarFlujoProceso 2, 7
EXEC Produccion.agregarFlujoProceso 2, 8
EXEC Produccion.agregarFlujoProceso 2, 10
EXEC Produccion.agregarFlujoProceso 2, 11
EXEC Produccion.agregarFlujoProceso 2, 12
EXEC Produccion.agregarFlujoProceso 2, 13
EXEC Produccion.agregarFlujoProceso 2, 14
EXEC Produccion.agregarFlujoProceso 3, 2
EXEC Produccion.agregarFlujoProceso 3, 3
EXEC Produccion.agregarFlujoProceso 3, 4
EXEC Produccion.agregarFlujoProceso 3, 5
EXEC Produccion.agregarFlujoProceso 3, 6
EXEC Produccion.agregarFlujoProceso 3, 7
EXEC Produccion.agregarFlujoProceso 3, 9
EXEC Produccion.agregarFlujoProceso 3, 10
EXEC Produccion.agregarFlujoProceso 3, 11
EXEC Produccion.agregarFlujoProceso 3, 12
EXEC Produccion.agregarFlujoProceso 3, 13
EXEC Produccion.agregarFlujoProceso 3, 14

--EXEC Produccion.agregarOrdenVentaTalla 25,25.50,1,1,1
--EXEC Produccion.agregarOrdenVentaTalla 28,38.4,1,1,1
--select * from Produccion.ordenVenta

CREATE PROCEDURE CrearBackup --BDD
AS
    DECLARE @fecha DATE
    DECLARE @name VARCHAR(100)

    SET @fecha = GETDATE()
    SET @name  = 'C:\Backup\Proyecto-'+CONVERT(VARCHAR(MAX),@fecha, 105)+'.bak'

	BACKUP DATABASE Fedisal TO DISK = 'C:\Backup\Proyecto-FULL.bak' --Backup FULL
	WITH INIT;

    BACKUP DATABASE Fedisal TO DISK = @name
    WITH DIFFERENTIAL;
;
GO

USE msdb;
GO

CREATE PROCEDURE CreandoJob
AS
	DECLARE @fecha DATE
	SET @fecha = GETDATE()

	-- Creando trabajo
	EXEC dbo.sp_add_job
		@job_name = 'BackupProyectoBDDFinal'
	;

	-- Agregando el paso al trabajo
	EXEC dbo.sp_add_jobstep
		@job_name = 'BackupProyectoBDDFinal',
		@database_name = 'CollegeCentralAmerica_LaLibertad',
		@step_name = 'Ejecutar_Backup',
		@subsystem = 'TSQL',
		@command = 'EXEC CrearBackup',
		@retry_attempts = 0,  
		@retry_interval = 0 ;  
	;

	-- Programando Trabajo
	EXEC dbo.sp_add_jobschedule @job_name = 'BackupProyectoBDDFinal',
		@name = 'Base_Backup',
		@freq_type= 4,
		@freq_interval = 1, 
		@active_start_date = 'CONVERT(date, CURRENT_TIMESTAMP)',
		@active_start_time = '202500'
	;

	-- Agregando el trabajo al servidor
	EXEC dbo.sp_add_jobserver
		@job_name = 'BackupProyectoBDDFinal',
		@server_name = @@Servername
	;
;
EXEC CreandoJob;
