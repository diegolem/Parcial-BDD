Create database CollegeCentralAmerica_LaLibertad;

use CollegeCentralAmerica_LaLibertad;


Create table departamento(
	idDepartamento int primary key IDENTITY(1,1) NOT NULL,
	nombre varchar(100) NOT NULL,
	descripcion varchar(250) NOT NULL 
);

Create table procesos(
	idProceso int primary key IDENTITY(1,1) NOT NULL,
	nombre varchar(30) NOT NULL,
	duracion int NOT NULL,
	idDepartamento int foreign key references departamento(idDepartamento)
);

Create table tipoCliente(
	idTipo int primary key IDENTITY(1,1) NOT NULL,
	nombre varchar(25) NOT NULL,
);

Create table clientes(
	idCliente int primary key IDENTITY(1,1) NOT NULL,
	nombre varchar(35) NOT NULL,
	dui char(10) NOT NULL,
	nit char(17) NOT NULL,
	direccion varchar(150) NOT NULL,
	telefono varchar(9) NOT NULL,
	correo varchar(50) NOT NULL,
	idTipo int foreign key references tipoCliente(idTipo)
);

Create table metodologia(
	idMetodologia int primary key IDENTITY(1,1) NOT NULL,
	nombre varchar(100) NOT NULL,
);

Create table modulo(
	idModulo int primary key IDENTITY(1,1) NOT NULL,
	nombre varchar(60) NOT NULL,
	cantidadProduccion int NOT NULL,
	idMetodologia int foreign key references metodologia(idMetodologia)
);

Create table factura(
	idFactura int primary key IDENTITY(1,1) NOT NULL,
	requiredDate date NOT NULL,
	orderDate date NOT NULL,
	finishedDate date NOT NULL,
	shipmentDate date NOT NULL,
	total money NOT NULL,
	descripcion varchar(250) NOT NULL,
	idCliente int foreign key references clientes(idCliente)
);

Create table tipoVariante(
	idVariante int primary key IDENTITY(1,1) NOT NULL,
	nombre varchar(25) NOT NULL
);

Create table detalles(
	idDetalle int primary key IDENTITY(1,1) NOT NULL,
	descripcion varchar(200) NOT NULL,
	precio money NOT NULL,
	idProceso int foreign key references procesos(idProceso)
);

Create table detalleVarianteDetalle(
	idVariante int foreign key references tipoVariante(idVariante),
	idDetalle int foreign key references detalles(idDetalle)
);

Create table flujoTrabajo(
	idFlujo int primary key IDENTITY(1,1) NOT NULL,
	idVariante int foreign key references tipoVariante(idVariante)
);

Create table detalleFlujoTrabajoProcesos(
	idFlujo int foreign key references flujoTrabajo(idFlujo),
	idProceso int foreign key references procesos(idProceso)
);

Create table estadoSeguimiento(
	idEstadoSeguimiento int primary key IDENTITY(1,1) NOT NULL,
	nombre varchar(25) NOT NULL
);

Create table estadoOrden(
	idEstadoOrden int primary key IDENTITY(1,1) NOT NULL,
	nombre varchar(25) NOT NULL
);

Create table prenda(
	idPrenda int primary key IDENTITY(1,1) NOT NULL,
	nombre varchar(100) NOT NULL,
	precio money NOT NULL
);

Create table estilo(
	idEstilo int primary key IDENTITY(1,1) NOT NULL,
	codigo char(5) NOT NULL,
	idPrenda int foreign key references prenda(idPrenda)
);

Create table tipoTalla(
	idTipoTalla int primary key IDENTITY(1,1) NOT NULL,
	nombre varchar(40) NOT NULL,
	abreviacion char(4) NOT NULL
);

Create table tallaUbicacion(
	idUbicacion int primary key IDENTITY(1,1) NOT NULL,
	ubicacion varchar(50) NOT NULL
);

Create table talla(
	idTalla int primary key IDENTITY(1,1) NOT NULL,
	cantidadTela decimal(18, 2) NOT NULL,
	idTipoTalla int foreign key references tipoTalla(idTipoTalla),
	idPrenda int foreign key references prenda(idPrenda),
	idEstilo int foreign key references estilo(idEstilo)
);

Create table medida(
	idMedida int primary key IDENTITY(1,1) NOT NULL,
	dimension decimal(18,2) NOT NULL,
	idTalla int foreign key references talla(idTalla),
	idUbicacion int foreign key references tallaUbicacion(idUbicacion)
);

Create table color(
	idColor int primary key IDENTITY(1,1) NOT NULL,
	nombre varchar(50) NOT NULL
);

Create table ordenVenta(
	idOrdenVenta int primary key IDENTITY(1,1) NOT NULL,
	monto money NOT NULL,
	cantidad int NOT NULL,
	idFactura int foreign key references factura(idFactura),
	idEstilo int foreign key references estilo(idEstilo),
	idFlujo int foreign key references flujoTrabajo(idFlujo),
	idColor int foreign key references color(idColor),
	idEstado int foreign key references estadoOrden(idEstadoOrden)
);

Create table ordenDeVentaTalla(
	idOrdenVentaTalla int primary key IDENTITY(1,1) NOT NULL,
	cantidad int NOT NULL,
	cantidadExtra int NOT NULL,
	cantidadTela decimal(18,2) NOT NULL,
	idTalla int foreign key references talla(idTalla),
	idModulo int foreign key references modulo(idModulo),
	idOrdenVenta int foreign key references ordenVenta(idOrdenVenta)
);

Create table seguimientoOrden(
	idSeguimiento int primary key IDENTITY(1,1) NOT NULL,
	idEstado int foreign key references estadoSeguimiento(idEstadoSeguimiento),
	idOrdenVenta int foreign key references ordenVenta(idOrdenVenta),
	idProceso int foreign key references procesos(idProceso)
);

Create table tipoUnidadMedidas(
	idTipoUnidad char(6) primary key NOT NULL,
	nombre varchar(60) NOT NULL
);

Create Table tipoMateriaPrima(
	idTipoMateriaPrima int primary key IDENTITY(1,1) NOT NULL,
	nombre varchar(60) NOT NULL,
	idMedicion char(6) foreign key references tipoUnidadMedidas(idTipoUnidad)
);

Create table estante(
	idEstante char(1) primary key NOT NULL
);

Create table nivel(
	idNivel int primary key IDENTITY(1,1) NOT NULL,
	nivel int NOT NULL
);

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
);

Create table Proveedor(
	idProveedor int primary key IDENTITY(1,1) NOT NULL,
	nombre varchar(100) NOT NULL,
	direccion varchar(200) NOT NULL,
	telefono char(9) NOT NULL,
	correo varchar(50) NOT NULL
);

Create table MateriaPrima(
	idMateriaPrima int primary key IDENTITY(1,1) NOT NULL,
	descripcion varchar(200) NOT NULL,
	existencia decimal(18,2) NOT NULL,
	stockMaximo decimal(18,2) NOT NULL,
	idTipoMateriaPrima int foreign key references tipoMateriaPrima(idTipoMateriaPrima),
	idCompartimiento char(3) foreign key references compartimiento(idCompartimiento) NOT NULL,
	idColor int foreign key references color(idColor),
	idProveedor int foreign key references proveedor(idProveedor)
);

Create table estadoCompras(
	idEstadoCompras int primary key IDENTITY(1,1) NOT NULL,
	nombre varchar(25) NOT NULL
)

Create Table compras(
	idCompras int primary key IDENTITY(1,1) NOT NULL,
	cantidad decimal(18,2) NOT NULL,
	idEstado int foreign key references estadoCompras(idEstadoCompras),
	idMateriaPrima int foreign key references materiaPrima(idMateriaPrima)
);


 --En la tabla procesos, la duración debe ser mayor a 0 y menor a 28
ALTER TABLE procesos
ADD CONSTRAINT chkduracion
CHECK ((duracion > 0 ) AND (duracion < 28)); 
 --En cada campo donde posea teléfono que siga formato (XXXXXXX ó XXXX-XXX).
 
 --El campo código en Estilo debe ser: [A-Z]{2}[0-9]{3}, ademas debe ser unico
 ALTER TABLE [estilo] ADD CONSTRAINT chkCodigoEstilo CHECK (codigo LIKE '%[A-Z][A-Z][0-9][0-9][0-9]%');
	
ALTER TABLE estilo 
ADD CONSTRAINT uCodigo UNIQUE (codigo);
	
--Campos emails o de correo electrónico deben ser únicos.
ALTER TABLE clientes
ADD CONSTRAINT uCorreo UNIQUE (correo);

ALTER TABLE proveedor
ADD CONSTRAINT uCorreoP UNIQUE (correo);

--Campo abreviacion debe ser unico
ALTER TABLE tipoTalla
ADD CONSTRAINT uAbreviacion UNIQUE (abreviacion)
--En todas las tabas que se tenga un total o cantidad deben ser mayores a 0.
ALTER TABLE modulo
ADD CONSTRAINT chkCantidadProduccion
CHECK (cantidadProduccion >= 0);

ALTER TABLE factura
ADD CONSTRAINT chkTotal
CHECK (total >= 0);

ALTER TABLE ordenDeVentaTalla
ADD CONSTRAINT chkCantidad
CHECK (cantidad >= 0);

ALTER TABLE ordenDeVentaTalla
ADD CONSTRAINT chkCantidadExtra
CHECK (cantidadExtra >= 0);

ALTER TABLE ordenDeVentaTalla
ADD CONSTRAINT chkCantidadTela
CHECK (cantidadTela >= 0);

ALTER TABLE ordenVenta
ADD CONSTRAINT chkCantidadSalesOrder
CHECK (cantidad >= 0);

ALTER TABLE materiaPrima
ADD CONSTRAINT chkStockMaximo
CHECK (stockMaximo >= 0);

ALTER TABLE talla
ADD CONSTRAINT chkCantidadTelaTalla
CHECK (cantidadTela >= 0);

ALTER TABLE compras
ADD CONSTRAINT chkCantidadCompra
CHECK (cantidad >= 0);

--Nivel y columna (campos nivel y columna respectivamente) deben ser números mayores a 0 y únicos.
ALTER TABLE nivel
ADD CONSTRAINT chkNivel
CHECK (nivel >= 0);

ALTER TABLE columna
ADD CONSTRAINT chkColumna
CHECK (columna >= 0);

--En la tabla estante en id, solo debe aceptar de la A – Z.
ALTER TABLE [estante] ADD CONSTRAINT chkIdEstante CHECK (idEstante LIKE '[A-Z]');

--En cada campo donde posea teléfono que siga formato (XXXXXXX ó XXXX-XXX).
ALTER TABLE clientes
ADD CONSTRAINT chkTelefono
CHECK( telefono LIKE '%[267][0-9][0-9][0-9][-][0-9][0-9][0-9][0-9]%');

ALTER TABLE proveedor
ADD CONSTRAINT chkTelefonoP
CHECK (telefono LIKE '%[267][0-9][0-9][0-9][-][0-9][0-9][0-9][0-9]%');


--Creaccion de Esquemas
create schema Venta;
create schema Compra;
create schema Produccion;
create schema Bodega;
create schema Producto;

--Asignacion de Tablas a su respectivo Esquema
ALTER SCHEMA Venta TRANSFER object::dbo.tipoCliente;
ALTER SCHEMA Venta TRANSFER object::dbo.clientes;
ALTER SCHEMA Venta TRANSFER object::dbo.factura;

ALTER SCHEMA Compra TRANSFER object::dbo.compras;
ALTER SCHEMA Compra TRANSFER object::dbo.estadoCompras;
ALTER SCHEMA Compra TRANSFER object::dbo.proveedor;

ALTER SCHEMA Produccion TRANSFER object::dbo.seguimientoOrden;
ALTER SCHEMA Produccion TRANSFER object::dbo.ordenDeVentaTalla;
ALTER SCHEMA Produccion TRANSFER object::dbo.ordenVenta;
ALTER SCHEMA Produccion TRANSFER object::dbo.estadoSeguimiento;
ALTER SCHEMA Produccion TRANSFER object::dbo.detalleFlujoTrabajoProcesos;
ALTER SCHEMA Produccion TRANSFER object::dbo.flujoTrabajo;
ALTER SCHEMA Produccion TRANSFER object::dbo.detalleVarianteDetalle;
ALTER SCHEMA Produccion TRANSFER object::dbo.detalles;
ALTER SCHEMA Produccion TRANSFER object::dbo.tipoVariante;
ALTER SCHEMA Produccion TRANSFER object::dbo.modulo;
ALTER SCHEMA Produccion TRANSFER object::dbo.metodologia;
ALTER SCHEMA Produccion TRANSFER object::dbo.procesos;
ALTER SCHEMA Produccion TRANSFER object::dbo.departamento;
ALTER SCHEMA Produccion TRANSFER object::dbo.estadoOrden;

ALTER SCHEMA Bodega TRANSFER object::dbo.tipoUnidadMedidas;
ALTER SCHEMA Bodega TRANSFER object::dbo.tipoMateriaPrima;
ALTER SCHEMA Bodega TRANSFER object::dbo.estante;
ALTER SCHEMA Bodega TRANSFER object::dbo.nivel;
ALTER SCHEMA Bodega TRANSFER object::dbo.compartimiento;
ALTER SCHEMA Bodega TRANSFER object::dbo.materiaPrima;
ALTER SCHEMA Bodega TRANSFER object::dbo.columna;
 
ALTER SCHEMA Producto TRANSFER object::dbo.prenda;
ALTER SCHEMA Producto TRANSFER object::dbo.estilo;
ALTER SCHEMA Producto TRANSFER object::dbo.tipoTalla;
ALTER SCHEMA Producto TRANSFER object::dbo.tallaUbicacion;
ALTER SCHEMA Producto TRANSFER object::dbo.talla;
ALTER SCHEMA Producto TRANSFER object::dbo.medida;

--Procedure para INSERTS
--Tabla Bodega.Columna
CREATE PROCEDURE agregarColumna
@columna INT
AS
	IF NOT EXISTS(SELECT * FROM Bodega.columna WHERE columna = @columna)
	BEGIN
		IF(@columna > 0)
		BEGIN
			INSERT INTO Bodega.columna VALUES(@columna)
			PRINT 'Columna Ingresada correctamente'
		END
		ELSE
		BEGIN
			PRINT 'El valor de la columna no puede ser negativo'
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
CREATE PROCEDURE agregarCompartimiento
@idCompartimiento CHAR(3),@estado TINYINT,@idEstante CHAR(1),@idNivel INT,@idColumna INT
AS
	IF NOT EXISTS(SELECT * FROM Bodega.Compartimiento WHERE idCompartimiento = @idCompartimiento)
	BEGIN
		IF (@idCompartimiento LIKE '%[A-H][0-8][0-9]%')
		BEGIN
			IF(@estado > 0)
			BEGIN
				IF (@idEstante LIKE '%[A-H]%')
				BEGIN
					INSERT INTO Bodega.Compartimiento VALUES(@idCompartimiento,@estado,@idEstante,@idNivel,@idColumna)
					PRINT 'Compartimiento ingresado correctamente'
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
--Tabla Bodega.estante
CREATE PROCEDURE agregarEstante
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
--Tabla Bodega.MateriaPrima
CREATE PROCEDURE agregarMateriaPrima
@descripcion varchar(200),@existencia decimal(18,2),@stockMaximo decimal(18,2),@idTipoMateriaPrima INT,
@idCompartimiento INT,@idColor INT,@idProveedor INT
AS
	IF NOT EXISTS(SELECT * FROM Bodega.MateriaPrima WHERE descripcion = @descripcion AND idTipoMateriaPrima = @idTipoMateriaPrima AND idCompartimiento = @idCompartimiento)
	BEGIN
		IF(@existencia > 0)
		BEGIN
			IF(@stockMaximo > @existencia AND @stockMaximo > 0)
			BEGIN
				IF (@idCompartimiento LIKE '%[A-H][0-8][0-9]%')
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
--Tabla Bodega.Nivel
CREATE PROC ingresarNivel
@nivel INT
AS
	IF NOT EXISTS(SELECT * FROM Bodega.nivel WHERE nivel = @nivel)
	BEGIN
		INSERT INTO Bodega.nivel VALUES(@nivel)
		PRINT 'Nivel ingresado correctamente'
	END
	ELSE
	BEGIN
		PRINT 'El nivel ya existe'
	END
GO
--Tabla Bodega.tipoMateriaPrima
CREATE PROC ingresarTipoMateriaPrima
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
--Tabla tipoUnidadMedidas
CREATE PROC ingresartipoUnidadMedidas
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
--Tabla Compra.compras
	CREATE PROCEDURE ingresarCompra
	@cantidad DECIMAL(18,2),@idEstado INT,@idMateriaPrima INT
	AS
		IF NOT EXISTS(SELECT * FROM Compra.compras WHERE cantidad = @cantidad AND idEstado = @idEstado AND idMateriaPrima = @idMateriaPrima)
		BEGIN
			IF (@cantidad > 0)
			BEGIN
				INSERT INTO Compra.compras VALUES(@cantidad,@idEstado,@idMateriaPrima)
				PRINT 'Compra ingresada con éxito'
			END
		END
		ELSE
		BEGIN
			PRINT 'La compra ya existe'
			ROLLBACK TRAN
		END
	GO
--Tabla Compra.estadoCompras
CREATE PROC ingresarEstadoCompras
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
--Tabla Compra.Proveedor
CREATE PROC agregarProveedor
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
--Tabla Produccion.departamento
CREATE PROC agregarDepartamento
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
--Tabla Produccion.detalleFlujoTrabajoProcesos
CREATE PROC agregarFlujoProceso
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
--Tabla Produccion.Detalles
CREATE PROC agregarDetalles
@descripcion VARCHAR(200),@precio MONEY,@idProceso INT
AS
	--IF NOT EXISTS(SELECT * FROM Produccion.Detalles WHERE descripcion = @descripcion AND precio = @precio AND idProceso = @idProceso)
	--BEGIN
		INSERT INTO Produccion.Detalles VALUES(@descripcion,@precio,@idProceso)
		PRINT 'Detalles ingresados correctamente'
	--END
	--ELSE
	--BEGIN
		--PRINT 'Este Detalle ya existe'
		--ROLLBACK TRAN
	--END
GO
--Tabla Produccion.detalleVarianteDetalle
CREATE PROC agregarVarianteDetalle
@idVariante INT,@idDetalle INT
AS
	INSERT INTO Produccion.detalleVarianteDetalle VALUES(@idVariante,@idDetalle)
	PRINT 'La variante fue agregada correctamente'
GO
--Tabla Produccion.estadoOrden
CREATE PROC agregarEstadoOrden
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
--Tabla Produccion.estadoSeguimiento
CREATE PROC agregarEstadoSeguimiento
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
--Tabla Produccion.flujoTrabajo
CREATE PROC agregarFlujoTrabajo
@idVariante INT
AS
	INSERT INTO Produccion.estadoSeguimiento VALUES(@idVariante)
	PRINT 'El flujo de trabajo fue asignado correctamente'
GO
--Tabla Produccion.metodologia
CREATE PROC agregarMetodologia
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
CREATE PROC agregarModulo
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
--Tabla Produccion.ordenDeVentaTalla
CREATE PROC agregarOrdenVentaTalla
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
--Tabla Produccion.ordenVenta
CREATE PROCEDURE agregarOrdenVenta
	@monto MONEY,@cantidad DECIMAL(18,2),@idFactura INT,@idEstilo INT,@idFlujo INT,
	@idColor INT,@idEstado INT
	AS
		IF NOT EXISTS(SELECT * FROM Produccion.ordenVenta WHERE monto = @monto AND cantidad = @cantidad AND idFactura = @idFactura  AND idEstilo = @idEstilo AND idFlujo = @idFlujo AND idColor = @idColor AND idEstado = @idEstado)
		BEGIN
			INSERT INTO Produccion.ordenVenta VALUES(@monto,@cantidad,@idFactura,@idEstilo,@idFlujo,@idColor,@idEstado)
			PRINT 'Orden Ingresada Correctamente'
		END
		ELSE
		BEGIN
			PRINT 'No se pudo ingresar la Orden revise los datos' 
		END
	GO
--Tabla Produccion.procesos
CREATE PROC agregarProcesos
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
--Tabla Produccion.seguimientoOrden
CREATE PROC agregarSeguimientoOrden
@idEstado INT,@idOrdenVenta INT,@idProceso INT
AS
	INSERT INTO Produccion.seguimientoOrden VALUES(@idEstado,@idOrdenVenta,@idProceso)
	PRINT 'Seguimiento de la Orden ingresado correctamente'
GO
--Tabla Produccion.tipoVariante
CREATE PROC agregarTipoVariante
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
--Tabla Producto.estilo
CREATE PROC agregarEstilo
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
--Tabla Producto.medida
CREATE PROC agregarMedida
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
--Tabla Producto.prenda
CREATE PROC agregarPrenda
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
--Tabla Producto.talla
CREATE PROC agregarTalla
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
--Tabla Producto.tallaUbicacion
CREATE PROC agregarUbicacion
@ubicacion VARCHAR(50)
AS
	IF NOT EXISTS(SELECT * FROM Producto.tallaUbicacion WHERE ubicacion = @ubicacion)
	BEGIN
		INSERT INTO Producto.tallaUbicacion VALUES(@ubicacion)
		PRINT 'La ubicaciond de la talla fue agregada correctamente'
	END
	ELSE
	BEGIN
		PRINT 'La ubicacion de la talla ya existe'
		ROLLBACK TRAN
	END
GO
-- Tabla Producto.tipoTalla
CREATE PROC agregarTipoTalla
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
--Tabla Venta.clientes
CREATE PROC agregarCliente
@nombre VARCHAR(35),@dui CHAR(10),@nit CHAR(14),@direccion VARCHAR(150),@telefono VARCHAR(9),
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
--Tabla Venta.factura
CREATE PROC agregarFactura
@requiredDate Date,@orderDate DATE,@finishedDate DATE,@shipmentDate DATE,@total MONEY,@descripcion VARCHAR(250),@idCliente INT
AS
	IF (DATEDIFF(DAY,@finishedDate,@shipmentDate) = 1)
	BEGIN
		IF(DATEDIFF(DAY,@shipmentDate,@requiredDate) = 14)
		BEGIN
			IF(@total > 0)
			BEGIN
				INSERT INTO Venta.factura VALUES(@requiredDate,@orderDate,@finishedDate,@shipmentDate,@total,@descripcion,@idCliente)
				PRINT 'Factura registrada correctamente'
			END
			ELSE
			BEGIN
				PRINT 'El total no debe ser negativo'
				ROLLBACK TRAN
			END
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
--Tabla Venta.tipoCliente
CREATE PROC agregarTipoCliente
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

-- Vistas
-- 1. Vista completa de los productos de inventario.CREATE VIEW productos AS	SELECT MT.nombre AS [Tipo de Producto], M.Descripcion AS [Producto] FROM Bodega.MateriaPrima M 	INNER JOIN Bodega.TipoMateriaPrima MT ON M.idTipoMateriaPrima = MT.idTipoMateriaPrima;-- 2. Vista completa de los trabajos en procesoCREATE VIEW trabajosProceso AS	SELECT O.cantidad AS [Cantidad], O.monto AS  [Monto ($)], C.nombre AS [Cliente]	FROM Produccion.OrdenVenta O INNER JOIN Produccion.estadoOrden E ON O.idEstado = E.idEstadoOrden	INNER JOIN Venta.Factura F ON O.idFactura = F.idFactura	INNER JOIN Venta.Clientes C ON F.idCliente	= C.idCliente	WHERE E.idEstadoOrden = 2; --Por ejemplo si en el id 2 es "proceso";-- 3. Vista de los trabajos que aún no han sido implementados.CREATE VIEW trabajosProceso AS	SELECT O.cantidad AS [Cantidad], O.monto AS  [Monto ($)], C.nombre AS [Cliente]	FROM Produccion.OrdenVenta O INNER JOIN Produccion.estadoOrden E ON O.idEstado = E.idEstadoOrden	INNER JOIN Venta.Factura F ON O.idFactura = F.idFactura	INNER JOIN Venta.Clientes C ON F.idCliente	= C.idCliente	WHERE E.idEstadoOrden = 1; --Por ejemplo si en el id 1 es "pendiente";-- 4. Vista de los productos que están en fase de desabastecimiento junto con los proveedores y sus
--    datos de contacto.CREATE VIEW productosNecesitados AS	SELECT MP.descripcion AS [Producto], P.nombre AS [Proveedor], P.telefono, P.correo	FROM Compra.compras C INNER JOIN Compra.estadoCompras EC ON C.idEstado = EC.idEstado	INNER JOIN Bodega.MateriaPrima MP ON C.idMateriaPrima = MP.idMateriaPrima INNER JOIN Compra.Proveedor P ON	MP.idProveedor = P.idProveedor WHERE EC.idEstado != 1; -- Donde 1 es 'comprado', los otros pueden ser 'urgente'etc.;-- 5. Vista de total piezas que se han trabajado por módulo, agrupadas por medio de su categoría.CREATE VIEW piezasModulo AS;-- 6. Vista de total de compras realizadas por clientes a lo largo de cada año.CREATE VIEW comprasCliente AS	SELECT COUNT(*), C.idCliente FROM Venta.Factura F INNER JOIN Venta.Clientes C ON F.idCliente = C.idCliente	GROUP BY F.idCliente; --Falta ser más descriptiva;-- 7. Vista de Trabajos y Sales Orders asignadas a cada módulo.-- 8. Vista de Telas (Todos los datos junto con el nombre del proveedor) en Inventario.-- 9. Vista de Hilos (Todos los datos junto con el nombre del proveedor) en inventario.-- 10. Vista de Cordones (Todos los datos junto con el nombre del proveedor) en inventario.-- 11. Vista de las Sales Order con categoría BLANKS.-- 12. Vista de las Sales Order con categoría SCREEN PRINTING.-- 13. Vista de las Sales Order con categoría Sublimation.-- 14.  Vista de las Sales Order que tienen un tiempo de retraso en la fecha de Finalización.