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

	ALTER TABLE proveedor
	ADD CONSTRAINT uCorreoP UNIQUE (correo)
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
	CREATE VIEW trabajosProceso AS	
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
--TRIGGERS Extra
CREATE TRIGGER asignarSeguimiento ON Produccion.ordenVenta
FOR INSERT
AS
	DECLARE @idOrdenVenta INT,@idProceso INT,@idEstado INT
	BEGIN
		SELECT @idOrdenVenta = idOrdenventa FROM inserted
		EXEC agregarSeguimientoOrden 3,@idOrdenVenta,1
		EXEC agregarSeguimientoOrden 3,@idOrdenVenta,2
		EXEC agregarSeguimientoOrden 3,@idOrdenVenta,3
		EXEC agregarSeguimientoOrden 3,@idOrdenVenta,4
		EXEC agregarSeguimientoOrden 3,@idOrdenVenta,5
		EXEC agregarSeguimientoOrden 3,@idOrdenVenta,6
		EXEC agregarSeguimientoOrden 3,@idOrdenVenta,7
		EXEC agregarSeguimientoOrden 3,@idOrdenVenta,8
		EXEC agregarSeguimientoOrden 3,@idOrdenVenta,9
		EXEC agregarSeguimientoOrden 3,@idOrdenVenta,10
		EXEC agregarSeguimientoOrden 3,@idOrdenVenta,11
		EXEC agregarSeguimientoOrden 3,@idOrdenVenta,12
		EXEC agregarSeguimientoOrden 3,@idOrdenVenta,13
	END
GO
CREATE TRIGGER verificarCompartimiento ON Bodega.MateriaPrima
FOR INSERT
AS
	DECLARE @idCompartimiento INT,@idMateriaPrima INT
	SELECT @idCompartimiento = idCompartimiento FROM inserted
	IF(SELECT estado FROM Bodega.Compartimiento WHERE idCompartimiento = @idCompartimiento) = 1
	BEGIN
		PRINT 'El compartimiento esta disponible'
		UPDATE Bodega.Compartimiento SET estado = 2 WHERE idCompartimiento = @idCompartimiento
	END
	ELSE IF(SELECT estado FROM Bodega.Compartimiento WHERE idCompartimiento = @idCompartimiento) = 2
	BEGIN
		PRINT 'El compartimiento ya esta ocupado'
		ROLLBACK TRAN
	END
GO
-- Funciones /////////////////////////////////////////////////////////////////////////////////////////////////
create function dbo.getPiezasExtras(@piezas int) RETURNS int
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
create procedure obtenerPiezasExtras @piezas int
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
CREATE PROC agregarClienteEmpresa
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
	INSERT INTO Produccion.detalleVarianteDetalle VALUES(@idVariante,@idDetalle)
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
			IF(@estado > 0)
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
CREATE PROC modificarClienteEmpresa
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
	IF EXISTS(SELECT * FROM Produccion.estadoSeguimiento WHERE idFlujo = @idFlujo)
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
CREATE PROC modificarTipoUnidadMedidas
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
		IF(@estado > 0)
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
CREATE PROCEDURE verificarTela @idColor INT, @cantidadTela DECIMAL(18,2)
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
create procedure asignarModuloOrdenVenta @idOrdenVenta int, @idTalla int, @cantidad int
as
	-- cantidad de talla extra
	declare @extra_talla int, @completo varchar(25) = 'Finalizado'
	exec @extra_talla = obtenerPiezasExtras @piezas = @cantidad

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

create procedure proTallaModuloAutomatico @idOrdenVenta int, @idModulo int, @tallas db_tallas readonly
as
	-- En caso que haya suficiente tela para lo que queremos hacer
	declare @suficienteTela bit = 0

	-- Obtenemos la cantidad total de las telas
	declare @cantidad_total decimal(18, 2) = 0, @count int = 0

	select @count = (@count + 1), @cantidad_total = (@cantidad_total + ((tp_talla.cantidad + dbo.getPiezasExtras(tp_talla.cantidad)) * tbl_talla.cantidadTela)) 
	from Producto.talla as tbl_talla ,@tallas as tp_talla 
	where tbl_talla.idTalla = tp_talla.id_talla

	declare @idColor INT

	select top 1 @idColor = idColor
	from Produccion.ordenVenta
	where idOrdenVenta = @idOrdenVenta

	exec @suficienteTela = verificarTela @idColor = @idColor, @cantidadTela = @cantidad_total

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
			exec asignarModuloOrdenVenta @idOrdenVenta = @idOrdenVenta, @idTalla = @idTalla, @cantidad = @cantidad
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

create procedure crearReporte @idFactura int
as

	IF EXISTS(SELECT * FROM Venta.factura.ordenVenta WHERE Venta.factura.idFactura = @idFactura)
	BEGIN
		-- Variables de la factura
		declare @id_factura int, @direccion varchar(250), @cliente varchar(150), @fecha_actual date = getdate()

		-- Obtenemos la informacion de la factura
		select top 1 @direccion = Venta.factura.direccion, @id_factura = Venta.factura.idFactura, @cliente = Venta.clientes.nombre
		from Venta.factura
		inner join Venta.clientes
		on Venta.clientes.idCliente = Venta.factura.idCliente
		where Venta.factura.idFactura = @idFactura

		-- Informacion del monto total
		DECLARE @Flujos TABLE ( precio_flujo decimal(18, 2), idOrdenVenta int )
		
		declare @precio_flujo decimal(18, 2)

		-- Obtenemos el precio de todos los detalles
		insert into @Flujos
		select sum(Produccion.detalles.precio), Produccion.ordenVenta.idOrdenVenta
		from Venta.factura
		inner join Produccion.ordenVenta
		on Venta.factura.idFactura = Produccion.ordenVenta.idFactura
		inner join Produccion.flujoTrabajo
		on Produccion.flujoTrabajo.idFlujo = Produccion.ordenVenta.idFlujo
		inner join Produccion.detalleFlujoTrabajoProcesos
		on Produccion.detalleFlujoTrabajoProcesos.idFlujo = Produccion.flujoTrabajo.idFlujo
		inner join Produccion.procesos
		on Produccion.procesos.idProceso = Produccion.detalleFlujoTrabajoProcesos.idProceso
		inner join Produccion.detalles
		on Produccion.detalles.idProceso = Produccion.procesos.idProceso
		where Venta.factura.idFactura = @idFactura
		group by Produccion.ordenVenta.idOrdenVenta

		declare @tbl_factura db_factura

		-- Obtenemos la informacion de las prenda
		insert into @tbl_factura
		select Producto.prenda.nombre, Produccion.ordenDeVentaTalla.cantidad, Produccion.ordenDeVentaTalla.cantidadExtra, (Producto.prenda.precio + (select flujos.precio_flujo from @Flujos as flujos where flujos.idOrdenVenta = Produccion.ordenVenta.idOrdenVenta)), 
		STUFF(  
			(  
				SELECT concat(', medida', Producto.medida.dimension, ' en la ubicacion ', Producto.tallaUbicacion.ubicacion)
				FROM Producto.medida
				inner join Producto.tallaUbicacion
				on Producto.tallaUbicacion.idUbicacion = Producto.medida.idUbicacion
				WHERE Producto.medida.idTalla = Producto.talla.idTalla 
				FOR XML PATH ('')
			),1,1,'')
		, ((Producto.prenda.precio + (select flujos.precio_flujo from @Flujos as flujos where flujos.idOrdenVenta = Produccion.ordenVenta.idOrdenVenta)) * Produccion.ordenDeVentaTalla.cantidad)
		from Venta.factura
		inner join Produccion.ordenVenta
		on Venta.factura.idFactura = Produccion.ordenVenta.idFactura
		inner join Produccion.ordenDeVentaTalla
		on Produccion.ordenDeVentaTalla.idOrdenVenta = Produccion.ordenVenta.idOrdenVenta
		inner join Producto.talla
		on talla.idTalla = ordenDeVentaTalla.idTalla
		inner join Producto.prenda
		on Producto.prenda.idPrenda = Producto.talla.idPrenda
		where Venta.factura.idFactura = @idFactura
		--group by Producto.prenda.nombre, Produccion.ordenDeVentaTalla.cantidad, Produccion.ordenDeVentaTalla.cantidadExtra, Producto.prenda.precio

		-- Calcular el total
		declare @total decimal(18, 2) = 0
		select @total = (@total + tbl.precioTotal) from @tbl_factura as tbl
		declare @iva decimal(18, 2) = @total * 0.13
		declare @total_iva decimal(18, 2) = @total + @iva

		declare @factura varchar(max)

		select @factura = '{"id":' + cast(@id_factura as varchar(max)) + ',' +
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

		return @factura
	END
	ELSE
	BEGIN
		return '{ "Error":"El registro no existe" }'
	END
go

--Usuarios de la BDD //////////////////////////////////////////////////////////////////////////////////////
--1. Usuarios del Esquema Compras:
--1.1 Usuario Solamente con permisos de selección de datos.
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
CREATE LOGIN GestorCompras
WITH PASSWORD = '12345'
CREATE USER LeonardoEsquivel FOR LOGIN GestorCompras
WITH DEFAULT_SCHEMA = Compra
GRANT EXECUTE,INSERT,UPDATE
ON SCHEMA :: Compra
TO LeonardoEsquivel
GO

--1.3 Usuario Administrador de Esquema, el cual podrá crear objetos como vistas,
--procedimientos, tablas etc dentro de este esquema.
CREATE LOGIN AdministradorCompras
WITH PASSWORD = '12345'
CREATE USER ElenilsonGuevara FOR LOGIN AdministradorCompras
WITH DEFAULT_SCHEMA = Compra
GRANT CREATE VIEW,CREATE TABLE,CREATE PROC
TO ElenilsonGuevara
GO
--2. Usuarios del Esquema Produccion:
--2.1 Usuario Solamente con permisos de selección de datos.
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
CREATE LOGIN GestorProduccion
WITH PASSWORD = '12345'
CREATE USER FranklinVelasquez FOR LOGIN GestorProduccion
WITH DEFAULT_SCHEMA = Produccion
GRANT EXECUTE,INSERT,UPDATE
ON SCHEMA :: Produccion
TO FranklinVelasquez
GO
--2.3 Usuario Administrador de Esquema, el cual podrá crear objetos como vistas,
--procedimientos, tablas etc dentro de este esquema.
CREATE LOGIN AdministradorProduccion
WITH PASSWORD = '12345'
CREATE USER FernandaValle FOR LOGIN AdministradorProduccion
WITH DEFAULT_SCHEMA = Produccion
GRANT CREATE VIEW,CREATE TABLE,CREATE PROC
TO FernandaValle
GO
--3. Usuarios del Esquema Bodega:
--3.1 Usuario Solamente con permisos de selección de datos.
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
CREATE LOGIN GestorBodega
WITH PASSWORD = '12345'
CREATE USER KarlaChavez FOR LOGIN GestorBodega
WITH DEFAULT_SCHEMA = Bodega
GRANT EXECUTE,INSERT,UPDATE
ON SCHEMA :: Bodega
TO KarlaChavez
GO
--2.3 Usuario Administrador de Esquema, el cual podrá crear objetos como vistas,
--procedimientos, tablas etc dentro de este esquema.
CREATE LOGIN AdministradorBodega
WITH PASSWORD = '12345'
CREATE USER DiegoDiaz FOR LOGIN AdministradorBodega
WITH DEFAULT_SCHEMA = Bodega
GRANT CREATE VIEW,CREATE TABLE,CREATE PROC
TO DiegoDiaz
GO
--4. Usuario Administrador que tendrá control total sobre TODA LA BASE DE DATOS Y TODOS
--SUS OBJETOS.
CREATE LOGIN Administrador
WITH PASSWORD = '54321'
CREATE USER BrandonLee FOR LOGIN Administrador
GRANT ALTER,EXECUTE,SELECT,INSERT,UPDATE,DELETE,CONTROL,REFERENCES,VIEW DEFINITION
TO BrandonLee WITH GRANT OPTION



--Respaldo de la BDD /////////////////////////////////////////////////////////////////////////////////////

--INSERT de las tablas
EXEC agregarDepartamento 'Planificacion', 'En encarga de verificar cada una de las órdenes de trabajo que han ingresado a la empresa, y como su nombre lo dice, planificar todo el proceso productivo de la empresa, esto incluye, verificar el trabajo en proceso en toda la planta, con el objetivo de no asignar más cargas de trabajo de la que se puede tener'
EXEC agregarDepartamento 'CAD','Este departamento se encarga principalmente de generar los diferentes patrones de marcadores para cada talla y estilo que se produce dentro de la planta, así como de imprimirlos y hacerlos llegar al departamento de corte para el inicio del ciclo productivo.'
EXEC agregarDepartamento 'Corte','Este departamento se encarga directamente de recibir los marcadores impresos generados por CAD para procesarlos, cortar la tela y enviar los paquetes de piezas listas para que sean costuradas.'
EXEC agregarDepartamento 'Costura','Se encargan directamente del costurado de las piezas, cabe mencionar que algunas piezas pueden ser costuradas antes o después de algún proceso como el sublimado o el estampado.'
EXEC agregarDepartamento 'Bodega','Se encargan de la recepción y el almacenaje de la materia prima utilizada en la producción de las prendas, estos pueden considerarse en dos grandes categorías, Fabric (Tela), y Supplies (Hilos, Cordones, Tintas, etc.)'
EXEC agregarDepartamento 'Sublimado','Area de Printing en Tela, este proceso se lleva a cabo en ciertas prendas y estilos seleccionados'
EXEC agregarDepartamento 'Serigrafia', 'Área de Estampado en Tela, este proceso se lleva a cabo en ciertas prendas y estilos seleccionado'
EXEC agregarDepartamento 'Empaque','Se encarga directamente de la recepción total de las prendas para el embalaje y preparación para el envío, a los clientes, en este paso, se hace la rotulación de los paquetes de acuerdo a la compañía logística que se encargará del transporte de los mismos'
EXEC agregarDepartamento 'Control de Calidad','De forma segmentada y casi por cada uno de los procesos, se hace un control de calidad para que la orden pueda ser llevada al siguiente paso del proceso productivo.'
EXEC agregarDepartamento 'Recursos Humanos','Se encarga del manejo de la información relativa a los empleados, tiempos de entrada y salida, datos generales, etc'
EXEC agregarDepartamento 'Contabilidad','Datos relativos al pago y la autorización de cada una de las transacciones y pagos de salarios, etc'
EXEC agregarDepartamento 'Compras','Se encarga de generar y realizar las compras de los insumos para todo el proceso productivo y también de los procesos administrativos en general.'

EXEC agregarProcesos 'Order Ready',10,1
EXEC agregarProcesos 'Printing Marker',5,2
EXEC agregarProcesos 'Marker Ready',15,2
EXEC agregarProcesos 'Cutting',5,3 
EXEC agregarProcesos 'Sewing line',10,4
EXEC agregarProcesos 'Out of Sewing Line',15,4
EXEC agregarProcesos 'Ironing',15,4
EXEC agregarProcesos 'Screen Printing',15,7
EXEC agregarProcesos 'Quality Assurance',15,9
EXEC agregarProcesos 'Ready for Packing',10,9
EXEC agregarProcesos 'Packing Ready',10,8
EXEC agregarProcesos 'Ready for Shipment',10,8
EXEC agregarProcesos 'Shipped',10,8

EXEC agregarTipoCliente 'Empresa'
EXEC agregarTipoCliente 'Persona'

EXEC agregarClientePersona 'Juan Lionel','12345678-9','1234-123456-123-2','Calle las brisas, Av. Chinameca Condominio #4','7321-0998','juanitoLeon@hotmail.com',2
EXEC agregarClienteEmpresa 'SIMAN Metrocentro','Sucursal de Metrocento, San Salvador','2542-4421','siman.metrocentro@gmail.com',1
EXEC agregarClienteEmpresa 'ST Jack´s Soyapango','Sucursal Unicentro Soyapango','2353-0983','stjacksoyapango@gmail.com',1
EXEC agregarClienteEmpresa 'Picaras Boutique','Sucursal Metrocentro, Cerca de Adidas','2260-3444','picarasboutique@gmail.com',1
EXEC agregarClientePersona 'Leonardo Edenilson Valle','87654321-9','4321-654231-983-5','Boulevar Constitución, atras de Papa Jonh`s','7293-9432','leoValleBoutique@gmail.com',2
EXEC agregarClientePersona 'Fernando Roberto Lemus Lemus','01928374-5','3241-028743-876-3','Calle a Apulo, Edificio #45,parcela #40','6023-3212','fernanflores@gmail.com',2
EXEC agregarClienteEmpresa 'Jacarandas','Metrocentro Doceava Etapa, a la par St Jack´s','2200-0332','jacarandasmetro@gmail.com',1
EXEC agregarClienteEmpresa 'Carlos Boutique','Plaza Mundo San Salvador, local #53','2999-4322','carlosstyle@gmail.com',1
EXEC agregarClienteEmpresa 'San Sebastian','Calle a San sebastian, condominio #55, Edificio Rojo','2303-4445','sebastianboutique@gmail.com',1
EXEC agregarClienteEmpresa 'Aqua eco','44 calle 2 Zona 12,Guatemala','2248-6000','AquaEcho@gmail.com',1
EXEC agregarClienteEmpresa 'Style Life','Centro comercial la cascada etapa #1,Local #12','2432-3333','stylelifecascada@gmail.com',1
EXEC agregarClientePersona 'Erick Alberto Esquivel Cañas','65784390-2','0192-657402-543-8','Calle la utilisima, Departamento de la Paz, en redondel la gloria edificio #1','2222-2223','xErickaec@gmail.com',2
EXEC agregarClienteEmpresa 'Vida Estilizada','Metrosur San Salvador, segunda planta local #99','2893-4444','vidaestilizada@gmail.com',1
EXEC agregarClienteEmpresa 'Dora´s','Galerias San Salvador, 3º nivel, local #12','2390-3333','dorasStyle@gmail.com',1
EXEC agregarClienteEmpresa 'Garage','Galerias San Salvador,Cerca del cine local #41','2533-3339','garageESA@gmail.com',1
EXEC agregarClientePersona 'Ezequiel Pocho Lavezzi Hernández','65780129-8','8888-444222-443-2','Calle el estante, Cabañas, comercial maria purisima,local #47','6555-3333','ezequielpocho@gmail.com',2
EXEC agregarClienteEmpresa 'Prisma Moda Plaza mundo','Sucursal Plaza Mundo, Etapa 2, local #43','2333-4444','prismamodaPM@gmail.com',1
EXEC agregarClienteEmpresa 'Branson Metrocentro','Sucursal Metrocentro San Salvador, 2 Etapa, por fuente con Starbucks','2333-4779','bransonmetrocentro@gmail.com',1
EXEC agregarClienteEmpresa 'Calvin Klein Metrocentro','Sucursal Metrocentro San Salvador, 1 Etapa, por parqueo principal de Metrocentro','2441-4461','calvinKleinmetroSS@gmail.com',1
EXEC agregarClientePersona 'Jimena Abigail Sanchez Guardado','65748309-2','1432-444090-341-5','Calle a Paseo general Escalón, Edificio Verde Local #1','7442-1223','jimenaAbigail@gmail.com',2
EXEC agregarClienteEmpresa 'Carolina´s','Metrocentro San Salvador,1º Nivel, Local #43','2309-3333','carolinas_bouti@gmail.com',1
EXEC agregarClienteEmpresa 'Tatiana´s','Galerias San Salvador, 2º Etapa, nivel #2, local #55','7203-4452','tatiandesign@gmail.com',1
EXEC agregarClienteEmpresa 'Colegio Don Bosco','Soyapango San Salvador, Calle a plan del pino','2000-1123','colegiodonbosco@gmail.com',1
EXEC agregarClienteEmpresa 'Scotiabank','Metrocentro San Salvador, Enfrente de Restaurante los Cebollines','2633-0110','scotiabankss@gmail.com',1
EXEC agregarClientePersona 'Kevin Alexander De Bruyne Reyes','23341928-3','5432-345019-245-5','Soyapango San Salvador calle la esperanza, edificio #4, parcela #1','6012-5145','KevinBruyne@gmail.com',2
EXEC agregarClienteEmpresa 'Agua Cristal','San Miguel, El Salvador, Calle la Conquista Edificio Azul','2201-2910','cristalelagua@gmail.com',1
EXEC agregarClienteEmpresa 'SIMAN Plaza Mundo','Sucursal de Plaza Muno, San Salvador','2549-4421','siman.plazamundo@gmail.com',1
EXEC agregarClienteEmpresa 'ST Jack´s Metrocentro','Sucursal Metrocentro San Salvador','2883-0983','stjacksometrocentro@gmail.com',1
EXEC agregarClienteEmpresa 'Local Boutique','Sucursal Metrocentro, Cerca de ADOC y MD','2940-3414','localboutique@gmail.com',1
EXEC agregarClientePersona 'Vanessa Alexandra Carranza','87654797-1','0182-654231-983-5','Boulevar Constitución, atras de Pollo Real','7423-9432','carranzastyle@gmail.com',2
EXEC agregarClientePersona 'Diana Alondra Canales','01928373-0','3241-651029-876-3','Calle a Apulo, Edificio #42,parcela #2','6003-3212','alondracanales@gmail.com',2
EXEC agregarClienteEmpresa 'Las Gemas','Metrocentro Cuarta etapa, a la par de Jacarandas','2212-0342','lasgemasmetro@gmail.com',1
EXEC agregarClienteEmpresa 'Antonella Boutique','Metrocentro San Salvador, local #23','2999-0312','antonellasalon@gmail.com',1
EXEC agregarClienteEmpresa 'Sant France','Paseo General Escalón, condominio #15, Edificio Azul','2113-4985','santfrance@gmail.com',1
EXEC agregarClienteEmpresa 'DollarCity Unicentro Soyapango','Unicentro Soyapango San Salvador, local #40','2093-1000','dollacitysoya@gmail.com',1
EXEC agregarClienteEmpresa 'Gorgeous','Centro comercial la cascada etapa #6,Local #68','2098-3331','Gorgeouscascada@gmail.com',1
EXEC agregarClientePersona 'Diego Gilberto López Lemus','01294390-2','1254-019402-543-8','Calle la hacienda, Departamento de San Miguel, en redondel la esperanza edificio #4','2999-6210','diegopresa@gmail.com',2
EXEC agregarClienteEmpresa 'Star Style','MetroNorte San Salvador, tercera planta local #68','2084-3415','Starstyle@gmail.com',1
EXEC agregarClienteEmpresa 'Carabana´s','Galerias San Salvador, 1º nivel, local #10','2093-7313','carabanaSS@gmail.com',1
EXEC agregarClienteEmpresa 'Mega Variety','Plaza Mundo San Salvador, 2º etapa,local #22','2028-4218','mevarietyPM@gmail.com',1
EXEC agregarClientePersona 'Filipe Ousmane Hernández Capilla','01829300-8','5017-444222-107-2','Calle la sucia, La unión, comercial maria santisima,local 2','7102-6666','ousmandembele@gmail.com',2
EXEC agregarClienteEmpresa 'Prisma Moda Galerias','Sucursal Galerias, Etapa 1, local #9','2546-0002','prismamodaGAL@gmail.com',1
EXEC agregarClienteEmpresa 'Branson La cascada','Sucursal La Cascada San Salvador, 1 Etapa,por la pizza Hut, local #4','2019-2019','bransoncascada@gmail.com',1
EXEC agregarClienteEmpresa 'Calvin Klein Galerias','Sucursal Galerias San Salvador, 3 Nivel, por salida de parqueo principal','2545-2543','calvinKleingalerias@gmail.com',1
EXEC agregarClientePersona 'Tomas Alexander Madrid Versa','36451026-2','1432-000192-415-5','Calle a Paseo general Escalón, por plaza Agua pura, Edificio #2, local #41','6442-1302','versamadriddecima@gmail.com',2
EXEC agregarClienteEmpresa 'Central´s','Metrocentro San Salvador,2º Nivel, Local #66','2098-4133','centralsdress@gmail.com',1
EXEC agregarClienteEmpresa 'Dresess Karla','Galerias San Salvador, 1º Etapa, nivel #1, frente a Samsung','7102-4210','dresseskarl@gmail.com',1
EXEC agregarClienteEmpresa 'Elegance boutique','Soyapango San Salvador, Calle a Plaza mundo, a la par del Pollo Campero','2534-7356','eleganceboutiquess@gmail.com',1
EXEC agregarClienteEmpresa 'Puma Metrocentro','Metrocentro San Salvador, A la par de Restaurante los Cebollines','2309-1221','pumasmetro@gmail.com',1
EXEC agregarClienteEmpresa 'Elegance T-Shirt','Galerias San salvador, local #22 nivel #4, a la par de Calvin Klein','2120-3313','elegandeshirt@gmail.com',1

EXEC agregarMetodologia 'Normal'
EXEC agregarMetodologia 'Fasttrack'

EXEC agregarModulo 'Módulo 1', 400,1
EXEC agregarModulo 'Módulo 2', 300,1
EXEC agregarModulo 'Módulo 3', 300,1
EXEC agregarModulo 'Módulo 4', 300,1
EXEC agregarModulo 'Módulo 5', 200,1
EXEC agregarModulo 'Módulo 6', 250,1
EXEC agregarModulo 'Módulo 7', 200,1
EXEC agregarModulo 'Módulo 8', 150,1
EXEC agregarModulo 'Módulo 9', 300,1
EXEC agregarModulo 'Módulo 10', 300,1
EXEC agregarModulo 'FastTrack',125,2

EXEC agregarFactura '2018-06-15','2018-05-27','2018-05-31','2018-06-01','Calle las brisas, Av. Chinameca Condominio #4',1
EXEC agregarFactura '2018-09-21','2018-08-27','2018-09-06','2018-09-07','Sucursal de Metrocento, San Salvador',2
EXEC agregarFactura '2018-08-22','2018-05-27','2018-08-07','2018-08-08','Sucursal Unicentro Soyapango',3
EXEC agregarFactura '2018-07-17','2018-07-27','2018-07-02','2018-07-03','Sucursal Metrocentro, Cerca de Adidas',4
EXEC agregarFactura '2018-01-19','2017-12-25','2018-01-04','2018-01-05','Boulevar Constitución, atras de Papa Jonh`s',5
EXEC agregarFactura '2018-01-16','2017-12-21','2018-01-02','2018-01-02','Calle a Apulo, Edificio #45,parcela #40',6
EXEC agregarFactura '2018-02-25','2018-01-27','2018-02-10','2018-02-11','Metrocentro Doceava Etapa, a la par St Jack´s',7
EXEC agregarFactura '2018-10-24','2018-09-27','2018-10-09','2018-10-10','Plaza Mundo San Salvador, local #53',8
EXEC agregarFactura '2018-09-29','2018-08-27','2018-09-14','2018-09-15','Calle a San sebastian, condominio #55, Edificio Rojo',9
EXEC agregarFactura '2018-05-26','2018-04-27','2018-05-11','2018-05-12','44 calle 2 Zona 12,Guatemala',10
EXEC agregarFactura '2018-04-21','2018-03-27','2018-04-06','2018-04-07','Centro comercial la cascada etapa #1,Local #12',11
EXEC agregarFactura '2018-03-20','2018-02-27','2018-03-05','2018-03-06','Calle la utilisima, Departamento de la Paz, en redondel la gloria edificio #1',12
EXEC agregarFactura '2018-06-28','2018-05-27','2018-06-13','2018-06-14','Metrosur San Salvador, segunda planta local #99',13
EXEC agregarFactura '2018-05-30','2018-04-27','2018-05-15','2018-05-16','Galerias San Salvador, 3º nivel, local #12',14
EXEC agregarFactura '2018-03-29','2018-02-27','2018-03-14','2018-03-15','Galerias San Salvador,Cerca del cine local #41',15
EXEC agregarFactura '2018-09-16','2018-08-27','2018-09-01','2018-09-02','Calle el estante, Cabañas, comercial maria purisima,local #47',16
EXEC agregarFactura '2018-03-26','2018-02-27','2018-03-11','2018-03-12','Sucursal Plaza Mundo, Etapa 2, local #43',17
EXEC agregarFactura '2018-08-31','2018-07-27','2018-08-16','2018-08-17','Sucursal Metrocentro San Salvador, 2 Etapa, por fuente con Starbucks',18
EXEC agregarFactura '2018-08-20','2018-07-27','2018-08-05','2018-08-06','Sucursal Metrocentro San Salvador, 1 Etapa, por parqueo principal de Metrocentro',19
EXEC agregarFactura '2018-05-15','2018-04-27','2018-04-30','2018-05-01','Calle a Paseo general Escalón, Edificio Verde Local #1',20
EXEC agregarFactura '2018-04-02','2018-03-27','2018-03-18','2018-03-19','Metrocentro San Salvador,1º Nivel, Local #43',21
EXEC agregarFactura '2018-04-22','2018-03-27','2018-04-07','2018-04-08','Galerias San Salvador, 2º Etapa, nivel #2, local #55',22
EXEC agregarFactura '2018-03-27','2018-02-27','2018-03-12','2018-03-13','Soyapango San Salvador, Calle a plan del pino',23
EXEC agregarFactura '2018-02-28','2018-01-27','2018-02-13','2018-02-14','Metrocentro San Salvador, Enfrente de Restaurante los Cebollines',24
EXEC agregarFactura '2018-01-20','2017-12-20','2018-01-05','2018-01-06','Soyapango San Salvador calle la esperanza, edificio #4, parcela #1',25
EXEC agregarFactura '2018-04-15','2018-03-21','2018-03-31','2018-04-01','San Miguel, El Salvador, Calle la Conquista Edificio Azul',26
EXEC agregarFactura '2018-08-21','2018-07-23','2018-08-06','2018-08-07','Sucursal de Plaza Mundo, San Salvador',27
EXEC agregarFactura '2018-07-22','2018-06-26','2018-07-07','2018-07-08','Sucursal Metrocentro San Salvador',28
EXEC agregarFactura '2018-06-17','2018-05-29','2018-06-02','2018-06-03','Sucursal Metrocentro, Cerca de ADOC y MD',29
EXEC agregarFactura '2018-02-19','2018-01-25','2018-02-04','2018-02-05','Boulevar Constitución, atras de Pollo Real',30
EXEC agregarFactura '2018-02-16','2018-01-21','2018-02-01','2018-02-02','Calle a Apulo, Edificio #42,parcela #2',31
EXEC agregarFactura '2018-03-25','2018-02-27','2018-03-10','2018-03-11','Metrocentro Cuarta etapa, a la par de Jacarandas',32
EXEC agregarFactura '2018-09-24','2018-08-29','2018-09-09','2018-09-10','Metrocentro San Salvador, local #23',33
EXEC agregarFactura '2018-08-29','2018-07-20','2018-08-14','2018-08-15','Paseo General Escalón, condominio #15, Edificio Azul',34
EXEC agregarFactura '2018-04-26','2018-03-23','2018-04-11','2018-04-12','Unicentro Soyapango San Salvador, local #40',35
EXEC agregarFactura '2018-03-21','2018-02-25','2018-03-06','2018-03-07','Centro comercial la cascada etapa #6,Local #68',36
EXEC agregarFactura '2018-02-20','2018-01-27','2018-02-05','2018-02-06','Calle la hacienda, Departamento de San Miguel, en redondel la esperanza edificio #4',37
EXEC agregarFactura '2018-05-28','2018-04-26','2018-05-13','2018-05-14','MetroNorte San Salvador, tercera planta local #68',38
EXEC agregarFactura '2018-04-30','2018-05-21','2018-04-15','2018-04-16','Galerias San Salvador, 1º nivel, local #10',39
EXEC agregarFactura '2018-02-29','2018-01-22','2018-02-14','2018-02-15','Plaza Mundo San Salvador, 2º etapa,local #22',40
EXEC agregarFactura '2018-08-16','2018-07-20','2018-08-01','2018-08-02','Calle la sucia, La unión, comercial maria santisima,local 2',41
EXEC agregarFactura '2018-02-26','2018-01-27','2018-02-11','2018-02-12','Sucursal Galerias, Etapa 1, local #9',42
EXEC agregarFactura '2018-07-31','2018-06-27','2018-07-16','2018-07-17','Sucursal La Cascada San Salvador, 1 Etapa,por la pizza Hut, local #4',43
EXEC agregarFactura '2018-07-20','2018-06-27','2018-07-05','2018-07-06','Sucursal Galerias San Salvador, 3 Nivel, por salida de parqueo principal',44
EXEC agregarFactura '2018-04-15','2018-03-27','2018-03-31','2018-04-01','Calle a Paseo general Escalón, por plaza Agua pura, Edificio #2, local #41',45
EXEC agregarFactura '2018-03-02','2018-02-27','2018-02-16','2018-02-17','Metrocentro San Salvador,2º Nivel, Local #66',46
EXEC agregarFactura '2018-03-22','2018-02-27','2018-03-07','2018-03-08','Galerias San Salvador, 1º Etapa, nivel #1, frente a Samsung',47
EXEC agregarFactura '2018-02-27','2018-01-27','2018-02-12','2018-02-13','Soyapango San Salvador, Calle a Plaza mundo, a la par del Pollo Campero',48
EXEC agregarFactura '2018-01-28','2017-12-27','2018-01-13','2018-01-14','Metrocentro San Salvador, A la par de Restaurante los Cebollines',49
EXEC agregarFactura '2018-02-20','2018-01-20','2018-02-05','2018-02-06','Galerias San salvador, local #22 nivel #4, a la par de Calvin Klein',50

EXEC agregarTipoVariante 'BLANKS'
EXEC agregarTipoVariante 'SCREEN PRINTING'
EXEC agregarTipoVariante 'SUBLIMATION'

EXEC agregarDetalles 'Pecho Completo',0.75,8 
EXEC agregarDetalles 'Pecho Derecho',0.55,8
EXEC agregarDetalles 'Manga Derecha',0.55,8
--revisar
EXEC agregarVarianteDetalle 2,1

EXEC agregarFlujoTrabajo 2

EXEC agregarFlujoProceso 1,1

EXEC agregarEstadoSeguimiento 'En proceso'
EXEC agregarEstadoSeguimiento 'Finalizado'
EXEC agregarEstadoSeguimiento 'Pendiente'

EXEC agregarEstadoOrden 'En proceso'
EXEC agregarEstadoOrden 'Finalizado'
EXEC agregarEstadoOrden 'Pendiente'

EXEC agregarPrenda 'Camisa',5.75
EXEC agregarPrenda 'Pantalon',8.75
EXEC agregarPrenda 'Suéter',11.75
EXEC agregarPrenda 'Sudadera',11.75

EXEC agregarEstilo 'CH350',1

EXEC agregarTipoTalla 'small','S'
exec agregarTipoTalla @nombre = 'Medium', @abreviacion = 'M'
exec agregarTipoTalla @nombre = 'Large', @abreviacion = 'L'
exec agregarTipoTalla @nombre = 'Extra large', @abreviacion = 'XL'
exec agregarTipoTalla @nombre = 'Extra extra small', @abreviacion = '2XS'
exec agregarTipoTalla @nombre = 'Extra small', @abreviacion = 'XS'
exec agregarTipoTalla @nombre = 'Extra extra large', @abreviacion = '2XL'
exec agregarTipoTalla @nombre = 'Extra extra large', @abreviacion = '3XL'
exec agregarTipoTalla @nombre = 'Extra extra large', @abreviacion = '4XL'

EXEC agregarUbicacion 'Cintura'
exec agregarUbicacion @ubicacion = 'Pecho'
exec agregarUbicacion @ubicacion = 'Cintura'
exec agregarUbicacion @ubicacion = 'Trasero'
exec agregarUbicacion @ubicacion = 'Tiro'
exec agregarUbicacion @ubicacion = 'Manga'
exec agregarUbicacion @ubicacion = 'Costura interior'
exec agregarUbicacion @ubicacion = 'Largo pantalon'
exec agregarUbicacion @ubicacion = 'Ancho espalda'
exec agregarUbicacion @ubicacion = 'Talle espalda'
exec agregarUbicacion @ubicacion = 'Cuello'
exec agregarUbicacion @ubicacion = 'Entrepierna'
exec agregarUbicacion @ubicacion = 'Manga corta'
exec agregarUbicacion @ubicacion = 'Largo rodilla'
exec agregarUbicacion @ubicacion = 'Contorno rodilla'
exec agregarUbicacion @ubicacion = 'Cadera'
exec agregarUbicacion @ubicacion = 'Largo camisa'
exec agregarUbicacion @ubicacion = 'Manga larga'

EXEC agregarTalla 1.00,1,1,1 --Aqui debe coincidir con los registro del PDF
exec agregarTalla @cantidadTela = 1.25, @idTipoTalla = 2,@idPrenda = 1, @idEstilo = 1
exec agregarTalla @cantidadTela = 1.50, @idTipoTalla = 3,@idPrenda = 1, @idEstilo = 1
exec agregarTalla @cantidadTela = 1.75, @idTipoTalla = 4,@idPrenda = 1, @idEstilo = 1

exec agregarTalla @cantidadTela = 1.50, @idTipoTalla = 2,@idPrenda = 2, @idEstilo = 1
exec agregarTalla @cantidadTela = 1.70, @idTipoTalla = 2,@idPrenda = 2, @idEstilo = 1
exec agregarTalla @cantidadTela = 1.90, @idTipoTalla = 3,@idPrenda = 2, @idEstilo = 1
exec agregarTalla @cantidadTela = 2.10, @idTipoTalla = 4,@idPrenda = 2, @idEstilo = 1

exec agregarTalla @cantidadTela = 1.75, @idTipoTalla = 2,@idPrenda = 3, @idEstilo = 1
exec agregarTalla @cantidadTela = 1.95, @idTipoTalla = 2,@idPrenda = 3, @idEstilo = 1
exec agregarTalla @cantidadTela = 2.15, @idTipoTalla = 3,@idPrenda = 3, @idEstilo = 1
exec agregarTalla @cantidadTela = 2.35, @idTipoTalla = 4,@idPrenda = 3, @idEstilo = 1

exec agregarTalla @cantidadTela = 1.75, @idTipoTalla = 2,@idPrenda = 4, @idEstilo = 1
exec agregarTalla @cantidadTela = 1.95, @idTipoTalla = 2,@idPrenda = 4, @idEstilo = 1
exec agregarTalla @cantidadTela = 2.15, @idTipoTalla = 3,@idPrenda = 4, @idEstilo = 1
exec agregarTalla @cantidadTela = 2.35, @idTipoTalla = 4,@idPrenda = 4, @idEstilo = 1

-- Camisa --
EXEC agregarMedida 86.5,1,1
exec agregarMedida @dimension = 36, @idTalla = 1, @idUbicacion = 10
exec agregarMedida @dimension = 72, @idTalla = 1, @idUbicacion = 16
exec agregarMedida @dimension = 25, @idTalla = 1, @idUbicacion = 17

-- Pantalon --
EXEC agregarMedida 30.5,2,1
exec agregarMedida @dimension = 40, @idTalla = 2, @idUbicacion = 15
exec agregarMedida @dimension = 80, @idTalla = 2, @idUbicacion = 7
exec agregarMedida @dimension = 53, @idTalla = 2, @idUbicacion = 12

-- Sueter--
exec agregarMedida @dimension = 38, @idTalla = 3, @idUbicacion = 17
exec agregarMedida @dimension = 54, @idTalla = 3, @idUbicacion = 16
exec agregarMedida @dimension = 48, @idTalla = 3, @idUbicacion = 15

-- Sudadera--
exec agregarMedida @dimension = 51, @idTalla = 4, @idUbicacion = 17
exec agregarMedida @dimension = 70, @idTalla = 4, @idUbicacion = 16
exec agregarMedida @dimension = 60, @idTalla = 4, @idUbicacion = 15

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

EXEC agregartipoUnidadMedidas 'YDS','Yardas'
EXEC agregartipoUnidadMedidas 'GAL','Galones'
EXEC agregartipoUnidadMedidas 'LTR','Litros'
EXEC agregartipoUnidadMedidas 'UDS','Unidades'

EXEC agregarTipoMateriaPrima 'Tela','YDS'
EXEC agregarTipoMateriaPrima 'Hilo', 'YDS'
EXEC agregarTipoMateriaPrima 'Cordones', 'YDS'
EXEC agregarTipoMateriaPrima 'Viñetas', 'UDS'
EXEC agregarTipoMateriaPrima 'Tintas', 'LTR'

EXEC agregarEstante 'A'
EXEC agregarEstante 'B'
EXEC agregarEstante 'C'
EXEC agregarEstante 'D'
EXEC agregarEstante 'E'
EXEC agregarEstante 'F'
EXEC agregarEstante 'G'
EXEC agregarEstante 'H'

EXEC agregarNivel 1
EXEC agregarNivel 2
EXEC agregarNivel 3
EXEC agregarNivel 4
EXEC agregarNivel 5
EXEC agregarNivel 6
EXEC agregarNivel 7
EXEC agregarNivel 8

EXEC agregarColumna 1
EXEC agregarColumna 2
EXEC agregarColumna 3
EXEC agregarColumna 4
EXEC agregarColumna 5
EXEC agregarColumna 6
EXEC agregarColumna 7
EXEC agregarColumna 8
EXEC agregarColumna 9

EXEC agregarCompartimiento A11,0
EXEC agregarCompartimiento A12,0
EXEC agregarCompartimiento A13,0
EXEC agregarCompartimiento A14,0
EXEC agregarCompartimiento A15,0
EXEC agregarCompartimiento A16,0
EXEC agregarCompartimiento A17,0
EXEC agregarCompartimiento A18,0
EXEC agregarCompartimiento A19,0
EXEC agregarCompartimiento A21,0
EXEC agregarCompartimiento A22,0
EXEC agregarCompartimiento A23,0
EXEC agregarCompartimiento A24,0
EXEC agregarCompartimiento A25,0
EXEC agregarCompartimiento A26,0
EXEC agregarCompartimiento A27,0
EXEC agregarCompartimiento A28,0
EXEC agregarCompartimiento A29,0
EXEC agregarCompartimiento A31,0
EXEC agregarCompartimiento A32,0
EXEC agregarCompartimiento A33,0
EXEC agregarCompartimiento A34,0
EXEC agregarCompartimiento A35,0
EXEC agregarCompartimiento A36,0
EXEC agregarCompartimiento A37,0
EXEC agregarCompartimiento A38,0
EXEC agregarCompartimiento A39,0
EXEC agregarCompartimiento A41,0
EXEC agregarCompartimiento A42,0
EXEC agregarCompartimiento A43,0
EXEC agregarCompartimiento A44,0
EXEC agregarCompartimiento A45,0
EXEC agregarCompartimiento A46,0
EXEC agregarCompartimiento A47,0
EXEC agregarCompartimiento A48,0
EXEC agregarCompartimiento A49,0
EXEC agregarCompartimiento A51,0
EXEC agregarCompartimiento A52,0
EXEC agregarCompartimiento A53,0
EXEC agregarCompartimiento A54,0
EXEC agregarCompartimiento A55,0
EXEC agregarCompartimiento A56,0
EXEC agregarCompartimiento A57,0
EXEC agregarCompartimiento A58,0
EXEC agregarCompartimiento A59,0
EXEC agregarCompartimiento A61,0
EXEC agregarCompartimiento A62,0
EXEC agregarCompartimiento A63,0
EXEC agregarCompartimiento A64,0
EXEC agregarCompartimiento A65,0
EXEC agregarCompartimiento A66,0
EXEC agregarCompartimiento A67,0
EXEC agregarCompartimiento A68,0
EXEC agregarCompartimiento A69,0
EXEC agregarCompartimiento A71,0
EXEC agregarCompartimiento A72,0
EXEC agregarCompartimiento A73,0
EXEC agregarCompartimiento A74,0
EXEC agregarCompartimiento A75,0
EXEC agregarCompartimiento A76,0
EXEC agregarCompartimiento A77,0
EXEC agregarCompartimiento A78,0
EXEC agregarCompartimiento A79,0
EXEC agregarCompartimiento A81,0
EXEC agregarCompartimiento A82,0
EXEC agregarCompartimiento A83,0
EXEC agregarCompartimiento A84,0
EXEC agregarCompartimiento A85,0
EXEC agregarCompartimiento A86,0
EXEC agregarCompartimiento A87,0
EXEC agregarCompartimiento A88,0
EXEC agregarCompartimiento A89,0
EXEC agregarCompartimiento B11,0
EXEC agregarCompartimiento B12,0
EXEC agregarCompartimiento B13,0
EXEC agregarCompartimiento B14,0
EXEC agregarCompartimiento B15,0
EXEC agregarCompartimiento B16,0
EXEC agregarCompartimiento B17,0
EXEC agregarCompartimiento B18,0
EXEC agregarCompartimiento B19,0
EXEC agregarCompartimiento B21,0
EXEC agregarCompartimiento B22,0
EXEC agregarCompartimiento B23,0
EXEC agregarCompartimiento B24,0
EXEC agregarCompartimiento B25,0
EXEC agregarCompartimiento B26,0
EXEC agregarCompartimiento B27,0
EXEC agregarCompartimiento B28,0
EXEC agregarCompartimiento B29,0
EXEC agregarCompartimiento B31,0
EXEC agregarCompartimiento B32,0
EXEC agregarCompartimiento B33,0
EXEC agregarCompartimiento B34,0
EXEC agregarCompartimiento B35,0
EXEC agregarCompartimiento B36,0
EXEC agregarCompartimiento B37,0
EXEC agregarCompartimiento B38,0
EXEC agregarCompartimiento B39,0
EXEC agregarCompartimiento B41,0
EXEC agregarCompartimiento B42,0
EXEC agregarCompartimiento B43,0
EXEC agregarCompartimiento B44,0
EXEC agregarCompartimiento B45,0
EXEC agregarCompartimiento B46,0
EXEC agregarCompartimiento B47,0
EXEC agregarCompartimiento B48,0
EXEC agregarCompartimiento B49,0
EXEC agregarCompartimiento B51,0
EXEC agregarCompartimiento B52,0
EXEC agregarCompartimiento B53,0
EXEC agregarCompartimiento B54,0
EXEC agregarCompartimiento B55,0
EXEC agregarCompartimiento B56,0
EXEC agregarCompartimiento B57,0
EXEC agregarCompartimiento B58,0
EXEC agregarCompartimiento B59,0
EXEC agregarCompartimiento B61,0
EXEC agregarCompartimiento B62,0
EXEC agregarCompartimiento B63,0
EXEC agregarCompartimiento B64,0
EXEC agregarCompartimiento B65,0
EXEC agregarCompartimiento B66,0
EXEC agregarCompartimiento B67,0
EXEC agregarCompartimiento B68,0
EXEC agregarCompartimiento B69,0
EXEC agregarCompartimiento B71,0
EXEC agregarCompartimiento B72,0
EXEC agregarCompartimiento B73,0
EXEC agregarCompartimiento B74,0
EXEC agregarCompartimiento B75,0
EXEC agregarCompartimiento B76,0
EXEC agregarCompartimiento B77,0
EXEC agregarCompartimiento B78,0
EXEC agregarCompartimiento B79,0
EXEC agregarCompartimiento B81,0
EXEC agregarCompartimiento B82,0
EXEC agregarCompartimiento B83,0
EXEC agregarCompartimiento B84,0
EXEC agregarCompartimiento B85,0
EXEC agregarCompartimiento B86,0
EXEC agregarCompartimiento B87,0
EXEC agregarCompartimiento B88,0
EXEC agregarCompartimiento B89,0
EXEC agregarCompartimiento C11,0
EXEC agregarCompartimiento C12,0
EXEC agregarCompartimiento C13,0
EXEC agregarCompartimiento C14,0
EXEC agregarCompartimiento C15,0
EXEC agregarCompartimiento C16,0
EXEC agregarCompartimiento C17,0
EXEC agregarCompartimiento C18,0
EXEC agregarCompartimiento C19,0
EXEC agregarCompartimiento C21,0
EXEC agregarCompartimiento C22,0
EXEC agregarCompartimiento C23,0
EXEC agregarCompartimiento C24,0
EXEC agregarCompartimiento C25,0
EXEC agregarCompartimiento C26,0
EXEC agregarCompartimiento C27,0
EXEC agregarCompartimiento C28,0
EXEC agregarCompartimiento C29,0
EXEC agregarCompartimiento C31,0
EXEC agregarCompartimiento C32,0
EXEC agregarCompartimiento C33,0
EXEC agregarCompartimiento C34,0
EXEC agregarCompartimiento C35,0
EXEC agregarCompartimiento C36,0
EXEC agregarCompartimiento C37,0
EXEC agregarCompartimiento C38,0
EXEC agregarCompartimiento C39,0
EXEC agregarCompartimiento C41,0
EXEC agregarCompartimiento C42,0
EXEC agregarCompartimiento C43,0
EXEC agregarCompartimiento C44,0
EXEC agregarCompartimiento C45,0
EXEC agregarCompartimiento C46,0
EXEC agregarCompartimiento C47,0
EXEC agregarCompartimiento C48,0
EXEC agregarCompartimiento C49,0
EXEC agregarCompartimiento C51,0
EXEC agregarCompartimiento C52,0
EXEC agregarCompartimiento C53,0
EXEC agregarCompartimiento C54,0
EXEC agregarCompartimiento C55,0
EXEC agregarCompartimiento C56,0
EXEC agregarCompartimiento C57,0
EXEC agregarCompartimiento C58,0
EXEC agregarCompartimiento C59,0
EXEC agregarCompartimiento C61,0
EXEC agregarCompartimiento C62,0
EXEC agregarCompartimiento C63,0
EXEC agregarCompartimiento C64,0
EXEC agregarCompartimiento C65,0
EXEC agregarCompartimiento C66,0
EXEC agregarCompartimiento C67,0
EXEC agregarCompartimiento C68,0
EXEC agregarCompartimiento C69,0
EXEC agregarCompartimiento C71,0
EXEC agregarCompartimiento C72,0
EXEC agregarCompartimiento C73,0
EXEC agregarCompartimiento C74,0
EXEC agregarCompartimiento C75,0
EXEC agregarCompartimiento C76,0
EXEC agregarCompartimiento C77,0
EXEC agregarCompartimiento C78,0
EXEC agregarCompartimiento C79,0
EXEC agregarCompartimiento C81,0
EXEC agregarCompartimiento C82,0
EXEC agregarCompartimiento C83,0
EXEC agregarCompartimiento C84,0
EXEC agregarCompartimiento C85,0
EXEC agregarCompartimiento C86,0
EXEC agregarCompartimiento C87,0
EXEC agregarCompartimiento C88,0
EXEC agregarCompartimiento C89,0
EXEC agregarCompartimiento D11,0
EXEC agregarCompartimiento D12,0
EXEC agregarCompartimiento D13,0
EXEC agregarCompartimiento D14,0
EXEC agregarCompartimiento D15,0
EXEC agregarCompartimiento D16,0
EXEC agregarCompartimiento D17,0
EXEC agregarCompartimiento D18,0
EXEC agregarCompartimiento D19,0
EXEC agregarCompartimiento D21,0
EXEC agregarCompartimiento D22,0
EXEC agregarCompartimiento D23,0
EXEC agregarCompartimiento D24,0
EXEC agregarCompartimiento D25,0
EXEC agregarCompartimiento D26,0
EXEC agregarCompartimiento D27,0
EXEC agregarCompartimiento D28,0
EXEC agregarCompartimiento D29,0
EXEC agregarCompartimiento D31,0
EXEC agregarCompartimiento D32,0
EXEC agregarCompartimiento D33,0
EXEC agregarCompartimiento D34,0
EXEC agregarCompartimiento D35,0
EXEC agregarCompartimiento D36,0
EXEC agregarCompartimiento D37,0
EXEC agregarCompartimiento D38,0
EXEC agregarCompartimiento D39,0
EXEC agregarCompartimiento D41,0
EXEC agregarCompartimiento D42,0
EXEC agregarCompartimiento D43,0
EXEC agregarCompartimiento D44,0
EXEC agregarCompartimiento D45,0
EXEC agregarCompartimiento D46,0
EXEC agregarCompartimiento D47,0
EXEC agregarCompartimiento D48,0
EXEC agregarCompartimiento D49,0
EXEC agregarCompartimiento D51,0
EXEC agregarCompartimiento D52,0
EXEC agregarCompartimiento D53,0
EXEC agregarCompartimiento D54,0
EXEC agregarCompartimiento D55,0
EXEC agregarCompartimiento D56,0
EXEC agregarCompartimiento D57,0
EXEC agregarCompartimiento D58,0
EXEC agregarCompartimiento D59,0
EXEC agregarCompartimiento D61,0
EXEC agregarCompartimiento D62,0
EXEC agregarCompartimiento D63,0
EXEC agregarCompartimiento D64,0
EXEC agregarCompartimiento D65,0
EXEC agregarCompartimiento D66,0
EXEC agregarCompartimiento D67,0
EXEC agregarCompartimiento D68,0
EXEC agregarCompartimiento D69,0
EXEC agregarCompartimiento D71,0
EXEC agregarCompartimiento D72,0
EXEC agregarCompartimiento D73,0
EXEC agregarCompartimiento D74,0
EXEC agregarCompartimiento D75,0
EXEC agregarCompartimiento D76,1
EXEC agregarCompartimiento D77,0
EXEC agregarCompartimiento D78,0
EXEC agregarCompartimiento D79,0
EXEC agregarCompartimiento D81,0
EXEC agregarCompartimiento D82,0
EXEC agregarCompartimiento D83,0
EXEC agregarCompartimiento D84,0
EXEC agregarCompartimiento D85,0
EXEC agregarCompartimiento D86,0
EXEC agregarCompartimiento D87,0
EXEC agregarCompartimiento D88,0
EXEC agregarCompartimiento D89,0
EXEC agregarCompartimiento E11,0
EXEC agregarCompartimiento E12,0
EXEC agregarCompartimiento E13,0
EXEC agregarCompartimiento E14,0
EXEC agregarCompartimiento E15,0
EXEC agregarCompartimiento E16,0
EXEC agregarCompartimiento E17,0
EXEC agregarCompartimiento E18,0
EXEC agregarCompartimiento E19,0
EXEC agregarCompartimiento E21,0
EXEC agregarCompartimiento E22,0
EXEC agregarCompartimiento E23,0
EXEC agregarCompartimiento E24,0
EXEC agregarCompartimiento E25,0
EXEC agregarCompartimiento E26,0
EXEC agregarCompartimiento E27,0
EXEC agregarCompartimiento E28,0
EXEC agregarCompartimiento E29,0
EXEC agregarCompartimiento E31,0
EXEC agregarCompartimiento E32,0
EXEC agregarCompartimiento E33,0
EXEC agregarCompartimiento E34,0
EXEC agregarCompartimiento E35,0
EXEC agregarCompartimiento E36,0
EXEC agregarCompartimiento E37,0
EXEC agregarCompartimiento E38,0
EXEC agregarCompartimiento E39,0
EXEC agregarCompartimiento E41,0
EXEC agregarCompartimiento E42,0
EXEC agregarCompartimiento E43,0
EXEC agregarCompartimiento E44,0
EXEC agregarCompartimiento E45,0
EXEC agregarCompartimiento E46,0
EXEC agregarCompartimiento E47,0
EXEC agregarCompartimiento E48,0
EXEC agregarCompartimiento E49,0
EXEC agregarCompartimiento E51,0
EXEC agregarCompartimiento E52,0
EXEC agregarCompartimiento E53,0
EXEC agregarCompartimiento E54,0
EXEC agregarCompartimiento E55,0
EXEC agregarCompartimiento E56,0
EXEC agregarCompartimiento E57,0
EXEC agregarCompartimiento E58,0
EXEC agregarCompartimiento E59,0
EXEC agregarCompartimiento E61,0
EXEC agregarCompartimiento E62,0
EXEC agregarCompartimiento E63,0
EXEC agregarCompartimiento E64,0
EXEC agregarCompartimiento E65,0
EXEC agregarCompartimiento E66,0
EXEC agregarCompartimiento E67,0
EXEC agregarCompartimiento E68,0
EXEC agregarCompartimiento E69,0
EXEC agregarCompartimiento E71,0
EXEC agregarCompartimiento E72,0
EXEC agregarCompartimiento E73,0
EXEC agregarCompartimiento E74,0
EXEC agregarCompartimiento E75,0
EXEC agregarCompartimiento E76,0
EXEC agregarCompartimiento E77,0
EXEC agregarCompartimiento E78,0
EXEC agregarCompartimiento E79,0
EXEC agregarCompartimiento E81,0
EXEC agregarCompartimiento E82,0
EXEC agregarCompartimiento E83,0
EXEC agregarCompartimiento E84,0
EXEC agregarCompartimiento E85,0
EXEC agregarCompartimiento E86,0
EXEC agregarCompartimiento E87,0
EXEC agregarCompartimiento E88,0
EXEC agregarCompartimiento E89,0
EXEC agregarCompartimiento F11,0
EXEC agregarCompartimiento F12,0
EXEC agregarCompartimiento F13,0
EXEC agregarCompartimiento F14,0
EXEC agregarCompartimiento F15,0
EXEC agregarCompartimiento F16,0
EXEC agregarCompartimiento F17,0
EXEC agregarCompartimiento F18,0
EXEC agregarCompartimiento F19,0
EXEC agregarCompartimiento F21,0
EXEC agregarCompartimiento F22,0
EXEC agregarCompartimiento F23,0
EXEC agregarCompartimiento F24,0
EXEC agregarCompartimiento F25,0
EXEC agregarCompartimiento F26,0
EXEC agregarCompartimiento F27,0
EXEC agregarCompartimiento F28,0
EXEC agregarCompartimiento F29,0
EXEC agregarCompartimiento F31,0
EXEC agregarCompartimiento F32,0
EXEC agregarCompartimiento F33,0
EXEC agregarCompartimiento F34,0
EXEC agregarCompartimiento F35,0
EXEC agregarCompartimiento F36,0
EXEC agregarCompartimiento F37,0
EXEC agregarCompartimiento F38,0
EXEC agregarCompartimiento F39,0
EXEC agregarCompartimiento F41,0
EXEC agregarCompartimiento F42,0
EXEC agregarCompartimiento F43,0
EXEC agregarCompartimiento F44,0
EXEC agregarCompartimiento F45,0
EXEC agregarCompartimiento F46,0
EXEC agregarCompartimiento F47,0
EXEC agregarCompartimiento F48,0
EXEC agregarCompartimiento F49,0
EXEC agregarCompartimiento F51,0
EXEC agregarCompartimiento F52,0
EXEC agregarCompartimiento F53,0
EXEC agregarCompartimiento F54,0
EXEC agregarCompartimiento F55,0
EXEC agregarCompartimiento F56,0
EXEC agregarCompartimiento F57,0
EXEC agregarCompartimiento F58,0
EXEC agregarCompartimiento F59,0
EXEC agregarCompartimiento F61,0
EXEC agregarCompartimiento F62,0
EXEC agregarCompartimiento F63,0
EXEC agregarCompartimiento F64,0
EXEC agregarCompartimiento F65,0
EXEC agregarCompartimiento F66,0
EXEC agregarCompartimiento F67,0
EXEC agregarCompartimiento F68,0
EXEC agregarCompartimiento F69,0
EXEC agregarCompartimiento F71,0
EXEC agregarCompartimiento F72,0
EXEC agregarCompartimiento F73,0
EXEC agregarCompartimiento F74,0
EXEC agregarCompartimiento F75,0
EXEC agregarCompartimiento F76,0
EXEC agregarCompartimiento F77,0
EXEC agregarCompartimiento F78,0
EXEC agregarCompartimiento F79,0
EXEC agregarCompartimiento F81,0
EXEC agregarCompartimiento F82,0
EXEC agregarCompartimiento F83,0
EXEC agregarCompartimiento F84,0
EXEC agregarCompartimiento F85,0
EXEC agregarCompartimiento F86,0
EXEC agregarCompartimiento F87,0
EXEC agregarCompartimiento F88,0
EXEC agregarCompartimiento F89,0
EXEC agregarCompartimiento G11,0
EXEC agregarCompartimiento G12,0
EXEC agregarCompartimiento G13,0
EXEC agregarCompartimiento G14,0
EXEC agregarCompartimiento G15,0
EXEC agregarCompartimiento G16,0
EXEC agregarCompartimiento G17,0
EXEC agregarCompartimiento G18,0
EXEC agregarCompartimiento G19,0
EXEC agregarCompartimiento G21,0
EXEC agregarCompartimiento G22,0
EXEC agregarCompartimiento G23,0
EXEC agregarCompartimiento G24,0
EXEC agregarCompartimiento G25,0
EXEC agregarCompartimiento G26,0
EXEC agregarCompartimiento G27,0
EXEC agregarCompartimiento G28,0
EXEC agregarCompartimiento G29,0
EXEC agregarCompartimiento G31,0
EXEC agregarCompartimiento G32,0
EXEC agregarCompartimiento G33,0
EXEC agregarCompartimiento G34,0
EXEC agregarCompartimiento G35,0
EXEC agregarCompartimiento G36,0
EXEC agregarCompartimiento G37,0
EXEC agregarCompartimiento G38,0
EXEC agregarCompartimiento G39,0
EXEC agregarCompartimiento G41,0
EXEC agregarCompartimiento G42,0
EXEC agregarCompartimiento G43,0
EXEC agregarCompartimiento G44,0
EXEC agregarCompartimiento G45,0
EXEC agregarCompartimiento G46,0
EXEC agregarCompartimiento G47,0
EXEC agregarCompartimiento G48,0
EXEC agregarCompartimiento G49,0
EXEC agregarCompartimiento G51,0
EXEC agregarCompartimiento G52,0
EXEC agregarCompartimiento G53,0
EXEC agregarCompartimiento G54,0
EXEC agregarCompartimiento G55,0
EXEC agregarCompartimiento G56,0
EXEC agregarCompartimiento G57,0
EXEC agregarCompartimiento G58,0
EXEC agregarCompartimiento G59,0
EXEC agregarCompartimiento G61,0
EXEC agregarCompartimiento G62,0
EXEC agregarCompartimiento G63,0
EXEC agregarCompartimiento G64,0
EXEC agregarCompartimiento G65,0
EXEC agregarCompartimiento G66,0
EXEC agregarCompartimiento G67,0
EXEC agregarCompartimiento G68,0
EXEC agregarCompartimiento G69,0
EXEC agregarCompartimiento G71,0
EXEC agregarCompartimiento G72,0
EXEC agregarCompartimiento G73,0
EXEC agregarCompartimiento G74,0
EXEC agregarCompartimiento G75,0
EXEC agregarCompartimiento G76,0
EXEC agregarCompartimiento G77,0
EXEC agregarCompartimiento G78,0
EXEC agregarCompartimiento G79,0
EXEC agregarCompartimiento G81,0
EXEC agregarCompartimiento G82,0
EXEC agregarCompartimiento G83,0
EXEC agregarCompartimiento G84,0
EXEC agregarCompartimiento G85,0
EXEC agregarCompartimiento G86,0
EXEC agregarCompartimiento G87,0
EXEC agregarCompartimiento G88,0
EXEC agregarCompartimiento G89,0
EXEC agregarCompartimiento H11,0
EXEC agregarCompartimiento H12,0
EXEC agregarCompartimiento H13,1
EXEC agregarCompartimiento H14,0
EXEC agregarCompartimiento H15,0
EXEC agregarCompartimiento H16,0
EXEC agregarCompartimiento H17,0
EXEC agregarCompartimiento H18,0
EXEC agregarCompartimiento H19,0
EXEC agregarCompartimiento H21,0
EXEC agregarCompartimiento H22,0
EXEC agregarCompartimiento H23,0
EXEC agregarCompartimiento H24,0
EXEC agregarCompartimiento H25,0
EXEC agregarCompartimiento H26,0
EXEC agregarCompartimiento H27,0
EXEC agregarCompartimiento H28,0
EXEC agregarCompartimiento H29,0
EXEC agregarCompartimiento H31,0
EXEC agregarCompartimiento H32,0
EXEC agregarCompartimiento H33,0
EXEC agregarCompartimiento H34,0
EXEC agregarCompartimiento H35,0
EXEC agregarCompartimiento H36,0
EXEC agregarCompartimiento H37,0
EXEC agregarCompartimiento H38,0
EXEC agregarCompartimiento H39,0
EXEC agregarCompartimiento H41,0
EXEC agregarCompartimiento H42,0
EXEC agregarCompartimiento H43,0
EXEC agregarCompartimiento H44,0
EXEC agregarCompartimiento H45,0
EXEC agregarCompartimiento H46,0
EXEC agregarCompartimiento H47,0
EXEC agregarCompartimiento H48,0
EXEC agregarCompartimiento H49,0
EXEC agregarCompartimiento H51,0
EXEC agregarCompartimiento H52,0
EXEC agregarCompartimiento H53,0
EXEC agregarCompartimiento H54,0
EXEC agregarCompartimiento H55,0
EXEC agregarCompartimiento H56,0
EXEC agregarCompartimiento H57,0
EXEC agregarCompartimiento H58,0
EXEC agregarCompartimiento H59,0
EXEC agregarCompartimiento H61,0
EXEC agregarCompartimiento H62,0
EXEC agregarCompartimiento H63,0
EXEC agregarCompartimiento H64,0
EXEC agregarCompartimiento H65,0
EXEC agregarCompartimiento H66,0
EXEC agregarCompartimiento H67,0
EXEC agregarCompartimiento H68,0
EXEC agregarCompartimiento H69,0
EXEC agregarCompartimiento H71,0
EXEC agregarCompartimiento H72,0
EXEC agregarCompartimiento H73,0
EXEC agregarCompartimiento H74,0
EXEC agregarCompartimiento H75,0
EXEC agregarCompartimiento H76,0
EXEC agregarCompartimiento H77,0
EXEC agregarCompartimiento H78,0
EXEC agregarCompartimiento H79,0
EXEC agregarCompartimiento H81,0
EXEC agregarCompartimiento H82,0
EXEC agregarCompartimiento H83,0
EXEC agregarCompartimiento H84,0
EXEC agregarCompartimiento H85,0
EXEC agregarCompartimiento H86,0
EXEC agregarCompartimiento H87,0
EXEC agregarCompartimiento H88,0
EXEC agregarCompartimiento H89,0

EXEC agregarProveedor 'Textiles Alcacer','Boulevard los procesores, Edificio #4 Poligono #40','2383-9802','alcacerTextil@gmail.com'

EXEC agregarMateriaPrima 'Tela para Camisas',450,750,1,A11,1,1

EXEC agregarEstadoCompras 'Normal'
EXEC agregarEstadoCompras 'Urgente'
EXEC agregarEstadoCompras 'Realizada'

EXEC agregarCompra 50.50,1,1

EXEC agregarOrdenVenta 1,1,1,1,1

EXEC agregarOrdenVentaTalla 25,25.50,1,1,1

EXEC agregarOrdenVentaTalla 28,38.4,1,1,1

EXEC agregarSeguimientoOrden 1,1,1
