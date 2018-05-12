-- Funciones /////////////////////////////////////////////////////////////////////////////////////////////////
CREATE FUNCTION Produccion.getPiezasExtras(@piezas int) RETURNS INT
AS
BEGIN
	DECLARE @count INT = 0
    IF @piezas < 0
	BEGIN
		SET @count = 0
	END

	IF @piezas > 0 AND @piezas <= 20
	BEGIN
		SET @count = 1
	END

	IF @piezas > 20 AND @piezas <= 40
	BEGIN
		SET @count = 2
	END

	IF @piezas > 40 AND @piezas <= 60
	BEGIN
		SET @count = 3
	END

	IF @piezas > 60 AND @piezas <= 80
	BEGIN
		SET @count = 4
	END

	IF @piezas > 80
	BEGIN
		SET @count = 5
	END

	RETURN @count
END
GO

CREATE PROCEDURE Produccion.obtenerPiezasExtras @piezas INT
AS
	IF @piezas < 0
	BEGIN
		return 0
	END

	IF @piezas > 0 AND @piezas <= 20
	BEGIN
		return 1
	END

	IF @piezas > 20 AND @piezas <= 40
	BEGIN
		return 2
	END

	IF @piezas > 40 AND @piezas <= 60
	BEGIN
		return 3
	END

	IF @piezas > 60 AND @piezas <= 80
	BEGIN
		return 4
	END

	IF @piezas > 80
	BEGIN
		return 5
	END
GO


-- Procedimientos Almacenados ////////////////////////////////////////////////////////////////////////////

/*Como parte de la estrategia de seguridad de la base de datos, se busca que los procesos de inserción
y modificación de los datos sea manejado por los procedimientos almacenados para los cuales debe
tener que deben ser creados para TODAS LAS TABLAS que se crean en la base de datos*/

--PROCEDURE de INSERT para TODAS las tablas
--Tabla Produccion.departamento
CREATE PROC Produccion.agregarDepartamento
@nombre VARCHAR(100),@descripcion VARCHAR(250)
AS
DECLARE @transaccion varchar(20)
	iF NOT EXISTS(SELECT * FROM Produccion.departamento WHERE nombre = @nombre AND descripcion = @descripcion)
	BEGIN
		INSERT INTO Produccion.departamento VALUES(@nombre,@descripcion)
		PRINT 'Departamento ingresado correctamente'
	END
	ELSE
	BEGIN
		BEGIN TRAN @transaccion
		PRINT 'El departamento ya existe'
		ROLLBACK TRAN @transaccion
	END
GO

--Tabla Produccion.procesos
CREATE PROC Produccion.agregarProcesos
@nombre VARCHAR(30),@duracion INT,@idDepartamento INT
AS
	DECLARE @transaccion varchar(20) = 'transact'
	IF(@duracion > 0)
	BEGIN
		INSERT INTO Produccion.procesos VALUES(@nombre,@duracion,@idDepartamento)
		PRINT 'Proceso ingresado correctamente'
	END
	ELSE
	BEGIN
		BEGIN TRAN @transaccion
		PRINT 'La duracion del proceso no puede ser negativa'
		ROLLBACK TRAN @transaccion
	END
GO

--Tabla Venta.tipoCliente
CREATE PROC Venta.agregarTipoCliente
@nombre VARCHAR(25)
AS
	DECLARE @transaccion varchar(20) = 'transact'
	IF NOT EXISTS(SELECT * FROM Venta.tipoCliente WHERE nombre = @nombre)
	BEGIN
		INSERT INTO Venta.tipoCliente VALUES(@nombre)
		PRINT 'Tipo de cliente ingresado correctamente'
	END
	ELSE
	BEGIN
		BEGIN TRAN @transaccion
		PRINT 'El tipo de cliente ya existe'
		ROLLBACK TRAN @transaccion
	END
GO

--Tabla Venta.clientes
--En caso de ser Tipo: Persona
CREATE PROC Venta.agregarClientePersona
@nombre VARCHAR(35),@dui CHAR(10),@nit CHAR(17),@direccion VARCHAR(150),@telefono VARCHAR(9),
@correo VARCHAR(50),@idTipo INT
AS
DECLARE @transaccion varchar(20) = 'transact'
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
				BEGIN TRAN @transaccion
				PRINT 'ingrese un NIT valido 0000-000000-000-0'
				ROLLBACK TRAN @transaccion
			END
		END
		ELSE
		BEGIN
			BEGIN TRAN @transaccion
			PRINT 'Ingrese un formato de DUI valido 00000000-0'
			ROLLBACK TRAN @transaccion
		END
	END
	ELSE
	BEGIN
		BEGIN TRAN @transaccion
		PRINT 'El cliente ya esta registrado'
		ROLLBACK TRAN @transaccion
	END
GO

--En caso de ser Tipo: Empresa
CREATE PROC Venta.agregarClienteEmpresa
@nombre VARCHAR(35),@direccion VARCHAR(150),@telefono VARCHAR(9),
@correo VARCHAR(50),@idTipo INT
AS
	DECLARE @dui VARCHAR(10),@nit VARCHAR(14), @transaccion varchar(20) = 'transact'
	SET @dui = '-'
	SET @nit = '-'
	IF NOT EXISTS(SELECT * FROM Venta.clientes WHERE nombre = @nombre AND dui = @dui AND nit = @nit AND telefono = @telefono AND correo = @correo AND idTipo = @idTipo)
	BEGIN
		INSERT INTO Venta.clientes VALUES(@nombre,@dui,@nit,@direccion,@telefono,@correo,@idTipo)
		PRINT 'Cliente registrado correctamente'
	END
	ELSE
	BEGIN
		BEGIN TRAN @transaccion
		PRINT 'El cliente ya esta registrado'
		ROLLBACK TRAN @transaccion
	END
GO

--Tabla Produccion.metodologia
CREATE PROC Produccion.agregarMetodologia
@nombre VARCHAR(100)
AS
DECLARE @transaccion varchar(20) = 'transact'
	IF NOT EXISTS(SELECT * FROM Produccion.metodologia WHERE nombre = @nombre)
	BEGIN
		INSERT INTO Produccion.metodologia VALUES(@nombre)
		PRINT 'La metodologia se ingreso correctamente'
	END
	ELSE
	BEGIN
		BEGIN TRAN @transaccion
		PRINT 'La metodologia ya existe'
		ROLLBACK TRAN @transaccion
	END
GO

--Tabla Produccion.modulo
CREATE PROC Produccion.agregarModulo
@nombre VARCHAR(60),@cantidadProduccion INT,@idMetodologia INT
AS
DECLARE @transaccion varchar(20) = 'transact'
	IF NOT EXISTS(SELECT * FROM Produccion.modulo WHERE nombre = @nombre AND cantidadProduccion = @cantidadProduccion AND idMetodologia = @idMetodologia)
	BEGIN
		INSERT INTO Produccion.modulo VALUES(@nombre,@cantidadProduccion,@idMetodologia)
		PRINT 'El modulo se ingreso correctamente'
	END
	ELSE
	BEGIN
		BEGIN TRAN @transaccion
		PRINT 'El modulo ya existe'
		ROLLBACK TRAN @transaccion
	END
GO

--Tabla Venta.factura
CREATE PROC Venta.agregarFactura
@requiredDate Date,@orderDate DATE,@finishedDate DATE,@shipmentDate DATE,@direccion VARCHAR(250),@idCliente INT
AS
DECLARE @total MONEY, @transaccion varchar(20) = 'transact'
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
			BEGIN TRAN @transaccion
			PRINT 'La fecha de envio debe ser dos semanas antes que la de requisicion'
			ROLLBACK TRAN @transaccion
		END
	END
	ELSE
	BEGIN
		BEGIN TRAN @transaccion
		PRINT 'La fecha de envio debe ser un dia mas que la de finalizacion'
		ROLLBACK TRAN @transaccion
	END
GO

--Tabla Produccion.tipoVariante
CREATE PROC Produccion.agregarTipoVariante
@nombre VARCHAR(25)
AS
DECLARE @transaccion varchar(20) = 'transact'
	IF NOT EXISTS(SELECT * FROM Produccion.tipoVariante WHERE nombre = @nombre)
	BEGIN
		INSERT INTO Produccion.tipoVariante VALUES(@nombre)
		PRINT 'Tipo de variante ingresada correctamente'
	END
	ELSE
	BEGIN
		BEGIN TRAN @transaccion
		PRINT 'El tipo de variante ya existe'
		ROLLBACK TRAN @transaccion
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
DECLARE @transaccion varchar(20) = 'transact'
	IF(@idVariante = 1)
	BEGIN
		BEGIN TRAN @transaccion
		PRINT 'La categoría Blanks no incluye ningun estampado ni sublimado'
		ROLLBACK TRAN @transaccion
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
DECLARE @transaccion varchar(20) = 'transact'
	IF NOT EXISTS(SELECT * FROM Produccion.detalleFlujoTrabajoProcesos WHERE idFLujo = @idFlujo AND idProceso = @idProceso)
	BEGIN
		INSERT INTO Produccion.detalleFlujoTrabajoProcesos VALUES(@idFlujo,@idProceso)
		PRINT 'Proceso asignado al flujo correctamente'
	END
	ELSE
	BEGIN
		BEGIN TRAN @transaccion
		PRINT 'El flujo con este proceso ya existe'
		ROLLBACK TRAN @transaccion
	END
GO

--Tabla Produccion.estadoSeguimiento
CREATE PROC Produccion.agregarEstadoSeguimiento
@nombre VARCHAR(25)
AS
DECLARE @transaccion varchar(20) = 'transact'
	IF NOT EXISTS(SELECT * FROM Produccion.estadoSeguimiento WHERE nombre = @nombre)
	BEGIN
		INSERT INTO Produccion.estadoSeguimiento VALUES(@nombre)
		PRINT 'El estado de seguimiento se ingreso correctamente'
	END
	ELSE
	BEGIN
		BEGIN TRAN @transaccion
		PRINT 'El estado de seguimiento ya existe'
		ROLLBACK TRAN @transaccion
	END
GO

--Tabla Produccion.estadoOrden
CREATE PROC Produccion.agregarEstadoOrden
@nombre VARCHAR(25)
AS
DECLARE @transaccion varchar(20) = 'transact'
	IF NOT EXISTS(SELECT * FROM Produccion.estadoOrden WHERE nombre = @nombre)
	BEGIN
		INSERT INTO Produccion.estadoOrden VALUES(@nombre)
		PRINT 'El estado de la orden se ingreso correctamente'
	END
	ELSE
	BEGIN
		BEGIN TRAN @transaccion
		PRINT 'El estado de la orden ya existe'
		ROLLBACK TRAN @transaccion
	END
GO

--Tabla Producto.prenda
CREATE PROC Producto.agregarPrenda
@nombre VARCHAR(100),@precio MONEY
AS
DECLARE @transaccion varchar(20) = 'transact'
	IF NOT EXISTS(SELECT * FROM Producto.prenda WHERE nombre = @nombre AND precio = @precio)
	BEGIN
		IF(@precio > 0)
		BEGIN
			INSERT INTO Producto.prenda VALUES(@nombre,@precio)
			PRINT 'La prenda se ingreso correctamente'
		END
		ELSE
		BEGIN
			BEGIN TRAN @transaccion
			PRINT 'El precio debe ser mayor que 0'
			ROLLBACK TRAN @transaccion
		END
	END
	ELSE
	BEGIN
		BEGIN TRAN @transaccion
		PRINT 'La prenda ya existe'
		ROLLBACK TRAN @transaccion
	END
GO

--Tabla Producto.estilo
CREATE PROC Producto.agregarEstilo
@codigo CHAR(5),@idPrenda INT
AS
DECLARE @transaccion varchar(20) = 'transact'
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
		BEGIN TRAN @transaccion
		PRINT 'El estilo ya existe'
		ROLLBACK TRAN @transaccion
	END
GO

-- Tabla Producto.tipoTalla
CREATE PROC Producto.agregarTipoTalla
@nombre VARCHAR(40),@abreviacion char(4)
AS
DECLARE @transaccion varchar(20) = 'transact'
	IF NOT EXISTS(SELECT * FROM Producto.tipoTalla WHERE nombre = @nombre AND abreviacion = @abreviacion)
	BEGIN
		IF(@abreviacion IN ('2XS','XS','S','M','L','XL','2XL','3XL','4XL'))
		BEGIN
			INSERT INTO Producto.tipoTalla VALUES(@nombre,@abreviacion)
			PRINT 'Tipo de talla ingresada correctamente'
		END
		ELSE
		BEGIN
			BEGIN TRAN @transaccion
			PRINT 'Ingrese una talla valida'
			ROLLBACK TRAN @transaccion
		END
	END
	ELSE
	BEGIN
		BEGIN TRAN @transaccion
		PRINT 'El tipo de talla ya existe'
		ROLLBACK TRAN @transaccion
	END
GO

--Tabla Producto.tallaUbicacion
CREATE PROC Producto.agregarUbicacion
@ubicacion VARCHAR(50)
AS
DECLARE @transaccion varchar(20) = 'transact'
	IF NOT EXISTS(SELECT * FROM Producto.tallaUbicacion WHERE ubicacion = @ubicacion)
	BEGIN
		INSERT INTO Producto.tallaUbicacion VALUES(@ubicacion)
		PRINT 'La ubicacion de la talla fue agregada correctamente'
	END
	ELSE
	BEGIN
		BEGIN TRAN @transaccion
		PRINT 'La ubicacion de la talla ya existe'
		ROLLBACK TRAN @transaccion
	END
GO

--Tabla Producto.talla
CREATE PROC Producto.agregarTalla
@cantidadTela DECIMAL(18,2),@idTipoTalla INT,@idPrenda INT,@idEstilo INT
AS
DECLARE @transaccion varchar(20) = 'transact'
	IF NOT EXISTS(SELECT * FROM Producto.talla WHERE cantidadTela = @cantidadTela AND idTipoTalla = @idTipoTalla AND idPrenda = @idPrenda AND idEstilo = @idEstilo)
	BEGIN
		IF(@cantidadTela > 0)
		BEGIN
			INSERT INTO Producto.talla VALUES(@cantidadTela,@idTipoTalla,@idPrenda,@idEstilo)
			PRINT 'Talla agregada correctamente'
		END
		ELSE
		BEGIN
			BEGIN TRAN @transaccion
			PRINT 'La cantidad de tela no puede ser menor que 0'
			ROLLBACK TRAN @transaccion
		END
	END
	ELSE
	BEGIN
		BEGIN TRAN @transaccion
		PRINT 'La talla ya existe'
		ROLLBACK TRAN @transaccion
	END
GO

--Tabla Producto.medida
CREATE PROC Producto.agregarMedida
@dimension DECIMAL(18,2),@idTalla INT,@idUbicacion INT
AS
DECLARE @tra varchar(20) = 'transact'
	IF NOT EXISTS(SELECT * FROM Producto.medida WHERE dimension = @dimension AND idTalla = @idTalla AND idUbicacion = @idUbicacion)
	BEGIN
		IF(@dimension > 0)
		BEGIN
			INSERT INTO Producto.medida VALUES(@dimension,@idTalla,@idUbicacion)
			PRINT 'Medida ingresada correctamente'
		END
		ELSE
		BEGIN
			BEGIN TRAN @tra
			PRINT 'La dimension no puede ser menor que 0'
			ROLLBACK TRAN @tra
		END
	END
	ELSE
	BEGIN
		BEGIN TRAN @tra
		PRINT 'La medida ya existe'
		ROLLBACK TRAN @tra
	END
GO

--Tabla dbo.color
CREATE PROC agregarColor
@nombre VARCHAR(50)
AS
DECLARE @tra varchar(20) = 'transact'
	IF NOT EXISTS(SELECT * FROM dbo.color WHERE nombre = @nombre)
	BEGIN
		INSERT INTO dbo.color VALUES(@nombre)
		PRINT 'Color ingresado correctamente'
	END
	ELSE
	BEGIN
		BEGIN TRAN @tra
		PRINT 'El color ya existe'
		ROLLBACK TRAN @tra
	END
GO

--Tabla Produccion.ordenVenta
CREATE PROCEDURE Produccion.agregarOrdenVenta
	@idFactura INT,@idEstilo INT,@idFlujo INT,
	@idColor INT,@idEstado INT
AS
DECLARE @monto MONEY,@cantidad INT,@tra varchar(20) = 'transact'
	IF NOT EXISTS(SELECT * FROM Produccion.ordenVenta WHERE cantidad = @cantidad AND idFactura = @idFactura  AND idEstilo = @idEstilo AND idFlujo = @idFlujo AND idColor = @idColor AND idEstado = @idEstado)
	BEGIN
		SET @monto = 0.00
		SET @cantidad = 0
		INSERT INTO Produccion.ordenVenta VALUES(@monto,@cantidad,@idFactura,@idEstilo,@idFlujo,@idColor,@idEstado)
		PRINT 'Orden Ingresada Correctamente'
	END
	ELSE
	BEGIN
		BEGIN TRAN @tra
		PRINT 'No se pudo ingresar la Orden revise los datos' 
		ROLLBACK TRAN @tra
	END
GO

--Tabla Produccion.ordenDeVentaTalla
CREATE PROC Produccion.agregarOrdenVentaTalla
@cantidad INT,@cantidadTela DECIMAL(18,2),@idTalla INT,@idModulo INT,@idOrdenVenta INT
AS
DECLARE @cantidadExtra INT,@tra varchar(20) = 'transact'
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
DECLARE @tra varchar(20) = 'transact'
	IF NOT EXISTS(SELECT * FROM Bodega.tipoUnidadMedidas WHERE idTipoUnidad = @idTipoUnidad AND nombre = @nombre)
	BEGIN
		IF (@idTipoUnidad IN('YDS','GAL','LTR','UDS'))
			BEGIN
				INSERT INTO Bodega.tipoUnidadMedidas VALUES(@idTipoUnidad,@nombre)
				PRINT 'Tipo de Materia Prima ingresada correctamente'
			END
			ELSE
			BEGIN
				BEGIN TRAN @tra
				PRINT 'La unidad de medida no es válida'
				ROLLBACK TRAN @tra
			END
	END
	ELSE
	BEGIN
		BEGIN TRAN @tra
		PRINT 'Esta unidad de medida ya existe'
		ROLLBACK TRAN @tra
	END
GO

--Tabla Bodega.tipoMateriaPrima
CREATE PROC Bodega.agregarTipoMateriaPrima
@nombre VARCHAR(60),@idMedicion CHAR(6)
AS
DECLARE @tra varchar(20) = 'transact'
	IF NOT EXISTS(SELECT * FROM Bodega.tipoMateriaPrima WHERE nombre = @nombre AND idMedicion = @idMedicion)
	BEGIN
		IF (@idMedicion IN('YDS','GAL','LTR','UDS'))
			BEGIN
				INSERT INTO Bodega.tipoMateriaPrima VALUES(@nombre,@idMedicion)
				PRINT 'Tipo de Materia Prima ingresada correctamente'
			END
			ELSE
			BEGIN
				BEGIN TRAN @tra
				PRINT 'La unidad de medida no es válida'
				ROLLBACK TRAN @tra
			END
	END
	ELSE
	BEGIN
		BEGIN TRAN @tra
		PRINT 'El tipo de materia prima ya existe'
		ROLLBACK TRAN @tra
	END
GO

--Tabla Bodega.estante
CREATE PROCEDURE Bodega.agregarEstante
@estante char(1)
AS
DECLARE @tra varchar(20) = 'transact'
	IF NOT EXISTS(SELECT * FROM Bodega.estante WHERE idEstante = @estante)
	BEGIN
		IF (@estante LIKE '%[A-H]%')
		BEGIN
			INSERT INTO Bodega.estante VALUES(@estante)
			PRINT 'Estante ingresado correctamente'
		END
		ELSE
		BEGIN
			BEGIN TRAN @tra
			PRINT 'La letra del estante debe estar entre A-H'
			ROLLBACK TRAN @tra
		END
	END
	ELSE
	BEGIN
		BEGIN TRAN @tra
		PRINT 'El estante ya existe'
		ROLLBACK TRAN @tra
	END
GO

--Tabla Bodega.Nivel
CREATE PROC Bodega.agregarNivel
@nivel INT
AS
DECLARE @tra varchar(20) = 'transact'
	IF NOT EXISTS(SELECT * FROM Bodega.nivel WHERE nivel = @nivel)
	BEGIN
		IF(@nivel > 0 AND @nivel < 9)
        BEGIN
            INSERT INTO Bodega.nivel VALUES(@nivel)
		    PRINT 'Nivel ingresado correctamente'
        END
        ELSE
        BEGIN
			BEGIN TRAN @tra
            PRINT 'El nivel debe estar entre 1-8'
            ROLLBACK TRAN @tra
        END
	END
	ELSE
	BEGIN
		BEGIN TRAN @tra
		PRINT 'El nivel ya existe'
		ROLLBACK TRAN @tra
	END
GO

--Tabla Bodega.Columna
CREATE PROCEDURE Bodega.agregarColumna
@columna INT
AS
DECLARE @tra varchar(20) = 'transact'
	IF NOT EXISTS(SELECT * FROM Bodega.columna WHERE columna = @columna)
	BEGIN
		IF(@columna > 0 AND @columna < 10)
		BEGIN
			INSERT INTO Bodega.columna VALUES(@columna)
			PRINT 'Columna Ingresada correctamente'
		END
		ELSE
		BEGIN
			BEGIN TRAN @tra
			PRINT 'El valor de la columna debe estar entre 1-9'
			ROLLBACK TRAN @tra
		END
	END
	ELSE
	BEGIN
		BEGIN TRAN @tra
		PRINT 'Esta columna ya existe'
		ROLLBACK TRAN @tra
	END
GO

--Tabla Bodega.Compartimiento
CREATE PROCEDURE Bodega.agregarCompartimiento
@idCompartimiento CHAR(3),@estado TINYINT
AS
DECLARE @idEstante CHAR(1),@idNivel INT,@idColumna INT, @tra varchar(20) = 'transact'
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
					BEGIN TRAN @tra
					PRINT 'el estado no puede ser negativo'
					ROLLBACK TRAN @tra
				END
		END
		ELSE
		BEGIN
			BEGIN TRAN @tra
			PRINT 'el valor del Compartimiento es inválido'
			ROLLBACK TRAN @tra
		END
	END
	ELSE
	BEGIN
		BEGIN TRAN @tra
		PRINT 'Este compartimiento ya existe'
		ROLLBACK TRAN @tra
	END
GO

--Tabla Compra.Proveedor
CREATE PROC Compra.agregarProveedor
@nombre VARCHAR(100),@direccion VARCHAR(200),@telefono CHAR(9),@correo VARCHAR(50)
AS
DECLARE @tra varchar(20) = 'transact'
	IF NOT EXISTS (SELECT * FROM Compra.Proveedor WHERE nombre = @nombre AND direccion = @direccion AND telefono = @telefono AND correo = @correo)
	BEGIN
		INSERT INTO Compra.Proveedor VALUES(@nombre,@direccion,@telefono,@correo)
		PRINT 'Proveedor ingresado Correctamente'
	END
	ELSE
	BEGIN
		BEGIN TRAN @tra
		PRINT 'El proveedor ya existe'
		ROLLBACK TRAN @tra
	END
GO

--Tabla Bodega.MateriaPrima
CREATE PROCEDURE Bodega.agregarMateriaPrima
@descripcion varchar(200),@existencia decimal(18,2),@stockMaximo decimal(18,2),@idTipoMateriaPrima INT,
@idCompartimiento CHAR(3),@idColor INT,@idProveedor INT
AS
DECLARE @tra varchar(20) = 'transact'
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
					BEGIN TRAN @tra
					PRINT 'Verifique el codigo del compartimiento'
					ROLLBACK TRAN @tra
				END
			END
			ELSE
			BEGIN
				BEGIN TRAN @tra
				PRINT 'Porfavor verifique los valores del stockMaximo'
				ROLLBACK TRAN @tra
			END
		END
		ELSE
		BEGIN
			BEGIN TRAN @tra
			PRINT 'La existencia no puede ser negativa'
			ROLLBACK TRAN @tra
		END
	END
	ELSE
	BEGIN
		BEGIN TRAN @tra
		PRINT 'Este material ya existe'
		ROLLBACK TRAN @tra
	END
GO

--Tabla Compra.estadoCompras
CREATE PROC Compra.agregarEstadoCompras
@nombre VARCHAR(25)
AS
DECLARE @tra varchar(20) = 'transact'
	IF NOT EXISTS(SELECT * FROM Compra.estadoCompras WHERE nombre = @nombre)
	BEGIN
		INSERT INTO Compra.estadoCompras VALUES(@nombre)
		PRINT 'Estado de compra ingresado correctamente'
	END
	ELSE
	BEGIN
		BEGIN TRAN @tra
		PRINT 'El estado de Compras ya existe'
		ROLLBACK TRAN @tra
	END
GO

--Tabla Compra.compras
CREATE PROCEDURE Compra.agregarCompra
@cantidad DECIMAL(18,2),@idEstado INT,@idMateriaPrima INT
AS
DECLARE @tra varchar(20) = 'transact'
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
			BEGIN TRAN @tra
			PRINT 'la cantidad no puede ser menor a 0'
			ROLLBACK TRAN @tra
		END
	END
	ELSE
	BEGIN
		BEGIN TRAN @tra
		PRINT 'La compra ya existe'
		ROLLBACK TRAN @tra
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
DECLARE @tra varchar(20) = 'transact'
	IF EXISTS(SELECT * FROM Produccion.departamento WHERE idDepartamento = @idDepartamento)
	BEGIN
		iF NOT EXISTS(SELECT * FROM Produccion.departamento WHERE nombre = @nombre AND descripcion = @descripcion AND idDepartamento != @idDepartamento)
		BEGIN
			UPDATE Produccion.departamento SET nombre = @nombre, descripcion = @descripcion WHERE idDepartamento = @idDepartamento
			PRINT 'Departamento se modifico correctamente'
		END
		ELSE
		BEGIN
			BEGIN TRAN @tra
			PRINT 'El departamento ya existe'
			ROLLBACK TRAN @tra
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
DECLARE @tra varchar(20) = 'transact'
	IF EXISTS(SELECT * FROM Produccion.procesos WHERE idProceso = @idProceso)
	BEGIN
		IF(@duracion > 0)
		BEGIN
			UPDATE Produccion.procesos SET nombre = @nombre, duracion = @duracion, idDepartamento = @idDepartamento WHERE idProceso = @idProceso
			PRINT 'Proceso se ha actualizado correctamente'
		END
		ELSE
		BEGIN
			BEGIN TRAN @tra
			PRINT 'La duracion del proceso no puede ser negativa'
			ROLLBACK TRAN @tra
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
DECLARE @tra varchar(20) = 'transact'
	IF EXISTS(SELECT * FROM Venta.tipoCliente WHERE idTipo = @idTipo)
	BEGIN
		IF NOT EXISTS(SELECT * FROM Venta.tipoCliente WHERE nombre = @nombre AND idTipo != @idTipo	)
		BEGIN
			UPDATE Venta.tipoCliente SET nombre = @nombre WHERE idTipo = @idTipo
			PRINT 'Tipo de cliente se actualizo correctamente'
		END
		ELSE
		BEGIN
			BEGIN TRAN @tra
			PRINT 'El tipo de cliente ya existe'
			ROLLBACK TRAN @tra
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
@nombre VARCHAR(35),@dui CHAR(10),@nit CHAR(17),@direccion VARCHAR(150),@telefono VARCHAR(9),
@correo VARCHAR(50),@idTipo INT, @idCliente int
AS
DECLARE @tra varchar(20) = 'transact'
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
				BEGIN TRAN @tra
				PRINT 'ingrese un NIT valido 0000-000000-000-0'
				ROLLBACK TRAN @tra
			END
		END
		ELSE
		BEGIN
			BEGIN TRAN @tra
			PRINT 'Ingrese un formato de DUI valido 00000000-0'
			ROLLBACK TRAN @tra
		END
	END
	ELSE
	BEGIN
		BEGIN TRAN @tra
		PRINT 'El cliente no existe'
		ROLLBACK TRAN @tra
	END
GO

--En caso de ser Tipo: Empresa
CREATE PROC Venta.modificarClienteEmpresa
@nombre VARCHAR(35),@direccion VARCHAR(150),@telefono VARCHAR(9),
@correo VARCHAR(50),@idTipo INT, @idCliente int
AS
DECLARE @tra varchar(20) = 'transact'
	IF EXISTS(SELECT * FROM Venta.clientes WHERE idCliente = @idCliente)
	BEGIN
		UPDATE Venta.clientes SET nombre = @nombre,direccion = @direccion, telefono = @telefono, correo = @correo, idTipo = @idTipo WHERE idCliente = @idCliente
				PRINT 'Cliente ha sido modificado exitosamente'
	END
	ELSE
	BEGIN
		BEGIN TRAN @tra
		PRINT 'El cliente no existe'
		ROLLBACK TRAN @tra
	END
GO

--Tabla Produccion.metodologia
CREATE PROC Produccion.modificarMetodologia
@nombre VARCHAR(100), @idMetodologia int
AS
DECLARE @tra varchar(20) = 'transact'
	IF EXISTS(SELECT * FROM Produccion.metodologia WHERE idMetodologia = @idMetodologia)
	BEGIN
		IF NOT EXISTS(SELECT * FROM Produccion.metodologia WHERE nombre = @nombre AND idMetodologia != @idMetodologia)
		BEGIN
			UPDATE Produccion.metodologia SET nombre = @nombre WHERE idMetodologia = @idMetodologia
			PRINT 'La metodologia se modificado correctamente'
		END
		ELSE
		BEGIN
			BEGIN TRAN @tra
			PRINT 'La metodologia ya existe'
			ROLLBACK TRAN @tra
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
DECLARE @tra varchar(20) = 'transact'
	IF EXISTS(SELECT * FROM Produccion.modulo WHERE idModulo = @idModulo)
	BEGIN
		IF NOT EXISTS(SELECT * FROM Produccion.modulo WHERE nombre = @nombre AND cantidadProduccion = @cantidadProduccion AND idMetodologia = @idMetodologia and idModulo != @idModulo)
		BEGIN
			UPDATE Produccion.modulo SET nombre = @nombre, cantidadProduccion = @cantidadProduccion, idMetodologia = @idMetodologia WHERE idModulo = @idModulo
			PRINT 'El modulo se modificado correctamente'
		END
		ELSE
		BEGIN
			BEGIN TRAN @tra
			PRINT 'El modulo ya existe'
			ROLLBACK TRAN @tra
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
DECLARE @tra varchar(20) = 'transact'
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
				BEGIN TRAN @tra
				PRINT 'La fecha de envio debe ser dos semanas antes que la de requisicion'
				ROLLBACK TRAN @tra
			END
		END
		ELSE
		BEGIN
			BEGIN TRAN @tra
			PRINT 'La fecha de envio debe ser un dia mas que la de finalizacion'
			ROLLBACK TRAN @tra
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
DECLARE @tra varchar(20) = 'transact'
	IF EXISTS(SELECT * FROM Produccion.tipoVariante WHERE idVariante = @idVariante)
	BEGIN
		IF NOT EXISTS(SELECT * FROM Produccion.tipoVariante WHERE nombre = @nombre AND idVariante != @idVariante)
		BEGIN
			UPDATE Produccion.tipoVariante SET nombre = @nombre WHERE idVariante = @idVariante
			PRINT 'Tipo de variante se ha modificado correctamente'
		END
		ELSE
		BEGIN
			BEGIN TRAN @tra
			PRINT 'El tipo de variante ya existe'
			ROLLBACK TRAN @tra
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
DECLARE @tra varchar(20) = 'transact'
	IF EXISTS (SELECT * FROM Produccion.detalleFlujoTrabajoProcesos WHERE idFLujo = @idFlujo)
	BEGIN
		IF NOT EXISTS(SELECT * FROM Produccion.detalleFlujoTrabajoProcesos WHERE idFLujo = @idFlujo AND idProceso = @idNuevoProceso)
		BEGIN
			UPDATE Produccion.detalleFlujoTrabajoProcesos SET idProceso = @idProceso WHERE idFLujo = @idFlujo AND idProceso = @idProceso
			PRINT 'Se ha resignado el proceso al flujo correctamente'
		END
		ELSE
		BEGIN
			BEGIN TRAN @tra
			PRINT 'El flujo con este proceso ya existe'
			ROLLBACK TRAN @tra
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
DECLARE @tra varchar(20) = 'transact'
	IF EXISTS(SELECT * FROM Produccion.estadoSeguimiento WHERE idEstadoSeguimiento = @idEstadoSeguimiento)
	BEGIN
		IF NOT EXISTS(SELECT * FROM Produccion.estadoSeguimiento WHERE nombre = @nombre AND idEstadoSeguimiento != @idEstadoSeguimiento)
		BEGIN
			UPDATE Produccion.estadoSeguimiento SET nombre = @nombre WHERE idEstadoSeguimiento = @idEstadoSeguimiento
			PRINT 'El estado de seguimiento se actualizado correctamente'
		END
		ELSE
		BEGIN
			BEGIN TRAN @tra
			PRINT 'El estado de seguimiento ya existe'
			ROLLBACK TRAN @tra
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
DECLARE @tra varchar(20) = 'transact'
	IF EXISTS(SELECT * FROM Produccion.estadoOrden WHERE idEstadoOrden = @idEstadoOrden)
	BEGIN
		IF NOT EXISTS(SELECT * FROM Produccion.estadoOrden WHERE nombre = @nombre AND idEstadoOrden != @idEstadoOrden)
		BEGIN
			UPDATE Produccion.estadoOrden SET nombre = @nombre WHERE idEstadoOrden = @idEstadoOrden
			PRINT 'El estado de la orden se ha modificado correctamente'
		END
		ELSE
		BEGIN
			BEGIN TRAN @tra
			PRINT 'El estado de la orden ya existe'
			ROLLBACK TRAN @tra
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
DECLARE @tra varchar(20) = 'transact'
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
				BEGIN TRAN @tra
				PRINT 'El precio debe ser mayor que 0'
				ROLLBACK TRAN @tra
			END
		END
		ELSE
		BEGIN
			BEGIN TRAN @tra
			PRINT 'La prenda ya existe'
			ROLLBACK TRAN @tra
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
DECLARE @tra varchar(20) = 'transact'
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
			BEGIN TRAN @tra
			PRINT 'El estilo ya existe'
			ROLLBACK TRAN @tra
		END
	END
GO

-- Tabla Producto.tipoTalla
CREATE PROC Producto.modificarTipoTalla
@nombre VARCHAR(40),@abreviacion char(4), @idTipoTalla int
AS
DECLARE @tra varchar(20) = 'transact'
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
				BEGIN TRAN @tra
				PRINT 'Ingrese una talla valida'
				ROLLBACK TRAN @tra
			END
		END
		ELSE
		BEGIN
			BEGIN TRAN @tra
			PRINT 'El tipo de talla ya existe'
			ROLLBACK TRAN @tra
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
DECLARE @tra varchar(20) = 'transact'
	IF EXISTS (SELECT * FROM Producto.tallaUbicacion WHERE idUbicacion = @idUbicacion)
	BEGIN
		IF NOT EXISTS(SELECT * FROM Producto.tallaUbicacion WHERE ubicacion = @ubicacion AND idUbicacion != @idUbicacion)
		BEGIN
			UPDATE Producto.tallaUbicacion SET ubicacion = @ubicacion WHERE idUbicacion = @idUbicacion
			PRINT 'La ubicacion de la talla se ha modificado correctamente'
		END
		ELSE
		BEGIN
			BEGIN TRAN @tra
			PRINT 'La ubicacion de la talla ya existe'
			ROLLBACK TRAN @tra
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
DECLARE @tra varchar(20) = 'transact'
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
				BEGIN TRAN @tra
				PRINT 'La cantidad de tela no puede ser menor que 0'
				ROLLBACK TRAN @tra
			END
		END
		ELSE
		BEGIN
			BEGIN TRAN @tra
			PRINT 'La talla ya existe'
			ROLLBACK TRAN @tra
		END
	END
GO

--Tabla Producto.medida
CREATE PROC Producto.modificarMedida
@dimension DECIMAL(18,2),@idTalla INT,@idUbicacion INT, @idMedida int
AS
DECLARE @tra varchar(20) = 'transact'
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
				BEGIN TRAN @tra
				PRINT 'La dimension no puede ser menor que 0'
				ROLLBACK TRAN @tra
			END
		END
		ELSE
		BEGIN
			BEGIN TRAN @tra
			PRINT 'La medida ya existe'
			ROLLBACK TRAN @tra
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
DECLARE @tra varchar(20) = 'transact'
	IF EXISTS(SELECT * FROM dbo.color WHERE idColor = @idColor)
	BEGIN
		IF NOT EXISTS(SELECT * FROM dbo.color WHERE nombre = @nombre AND idColor != @idColor)
		BEGIN
			UPDATE dbo.color SET nombre = @nombre WHERE idColor = @idColor
			PRINT 'Color se ha actualizado correctamente'
		END
		ELSE
		BEGIN
			BEGIN TRAN @tra
			PRINT 'El color ya existe'
			ROLLBACK TRAN @tra
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
DECLARE @tra varchar(20) = 'transact'
	IF EXISTS(SELECT * FROM Produccion.ordenVenta WHERE idOrdenVenta = @idOrdenVenta)
	BEGIN
		IF NOT EXISTS(SELECT * FROM Produccion.ordenVenta WHERE idFactura = @idFactura  AND idEstilo = @idEstilo AND idFlujo = @idFlujo AND idColor = @idColor AND idEstado = @idEstado AND idOrdenVenta != @idOrdenVenta)
		BEGIN
			UPDATE Produccion.ordenVenta SET idFactura = @idFactura, idEstilo = @idEstilo, idFlujo = @idFlujo, idColor = @idColor, idEstado = @idEstado WHERE idOrdenVenta = @idOrdenVenta
			PRINT 'Orden Modificada Correctamente'
		END
		ELSE
		BEGIN
			BEGIN TRAN @tra
			PRINT 'No se pudo ingresar la Orden revise los datos' 
            ROLLBACK TRAN @tra
        END
	END
	ELSE
	BEGIN
		BEGIN TRAN @tra
		PRINT 'No existe la orden de venta'
        ROLLBACK TRAN @tra
	END
GO

--Tabla Produccion.ordenDeVentaTalla
CREATE PROC Produccion.modificarOrdenVentaTalla
@cantidad INT,@cantidadTela DECIMAL(18,2),@idTalla INT,@idModulo INT,@idOrdenVenta INT, @idOrdenVentaTalla INT
AS
DECLARE @tra varchar(20) = 'transact'
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
DECLARE @tra varchar(20) = 'transact'
	IF EXISTS(SELECT * FROM Bodega.tipoUnidadMedidas WHERE idTipoUnidad = @idTipoUnidad)
	BEGIN
		IF (@idTipoUnidad IN('YDS','GAL','LTR','UDS'))
		BEGIN
			UPDATE Bodega.tipoUnidadMedidas SET  nombre = @nombre WHERE idTipoUnidad = @idTipoUnidad
			PRINT 'Tipo de Materia Prima se ha modificado exitosamente'
		END
		ELSE
		BEGIN
			BEGIN TRAN @tra
			PRINT 'La unidad de medida no es válida'
			ROLLBACK TRAN @tra
		END
	END
	ELSE
	BEGIN
		BEGIN TRAN @tra
		PRINT 'Esta unidad de medida no existe'
		ROLLBACK TRAN @tra
	END
GO

--Tabla Bodega.tipoMateriaPrima
CREATE PROC Bodega.modificarTipoMateriaPrima @nombre VARCHAR(60),@idMedicion CHAR(6), @idTipoMateriaPrima int -- Tipo Materia Prima
AS
DECLARE @tra varchar(20) = 'transact'
	IF EXISTS(SELECT * FROM Bodega.tipoMateriaPrima WHERE idTipoMateriaPrima = @idTipoMateriaPrima)
	BEGIN
		IF (@idMedicion IN('YDS','GAL','LTR','UDS'))
		BEGIN
			UPDATE Bodega.tipoMateriaPrima SET nombre = @nombre, idMedicion = @idMedicion WHERE idTipoMateriaPrima = @idTipoMateriaPrima
			PRINT 'Tipo de Materia Prima modificada correctamente'
		END
		ELSE
		BEGIN
			BEGIN TRAN @tra
			PRINT 'La unidad de medida no es válida'
			ROLLBACK TRAN @tra
		END
	END
	ELSE
	BEGIN
		BEGIN TRAN @tra
		print 'El tipo de materia a modificar no existe'
		ROLLBACK TRAN @tra
	END
GO

--Tabla Bodega.estante
CREATE PROCEDURE Bodega.modificarEstante @nuevo_estante char(1), @estante char(1) -- Estante
AS
DECLARE @tra varchar(20) = 'transact'
	IF NOT EXISTS(SELECT * FROM Bodega.estante WHERE idEstante = @nuevo_estante and idEstante != @estante)
	BEGIN
		IF (@nuevo_estante LIKE '%[A-H]%' AND @estante LIKE '%[A-H]%')
		BEGIN
			UPDATE Bodega.estante SET idEstante = @nuevo_estante WHERE idEstante = @estante
			PRINT 'Estante modificado correctamente'
		END
		ELSE
		BEGIN
			BEGIN TRAN @tra
			PRINT 'La letra del estante debe estar entre A-H'
			ROLLBACK TRAN @tra
		END
	END
	ELSE
	BEGIN
		BEGIN TRAN @tra
		PRINT 'El estante ya existe'
		ROLLBACK TRAN @tra
	END
GO

--Tabla Bodega.Nivel
CREATE PROC Bodega.modificarNivel @nivel INT, @idNivel INT -- Tabla Nivel
AS
DECLARE @tra varchar(20) = 'transact'
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
				BEGIN TRAN @tra
                PRINT 'El nivel debe estar entre 1-8'
                ROLLBACK TRAN @tra
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
DECLARE @tra varchar(20) = 'transact'
	IF NOT EXISTS(SELECT * FROM Bodega.columna WHERE columna = @columna and idColumna != @idColumna)
	BEGIN
		IF(@columna > 0 AND @columna < 10)
		BEGIN
			UPDATE Bodega.columna SET columna = @columna WHERE idColumna = @idColumna
			PRINT 'La columna se ha modificado exitosamente'
		END
		ELSE
		BEGIN
			BEGIN TRAN @tra
			PRINT 'El valor de la columna debe estar entre 1-9'
			ROLLBACK TRAN @tra
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
DECLARE @tra varchar(20) = 'transact'
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
				BEGIN TRAN @tra
				PRINT 'el Estante debe ser una letra entre A-H'
				ROLLBACK TRAN @tra
			END
		END
		ELSE
		BEGIN
			BEGIN TRAN @tra
			PRINT 'el estado no puede ser negativo'
			ROLLBACK TRAN @tra
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
DECLARE @tra varchar(20) = 'transact'
	IF EXISTS(SELECT * FROM Compra.Proveedor WHERE idProveedor = @idProveedor)
	BEGIN
		IF NOT EXISTS (SELECT * FROM Compra.Proveedor WHERE nombre = @nombre AND direccion = @direccion AND telefono = @telefono AND correo = @correo AND idProveedor != @idProveedor)
		BEGIN
			UPDATE Compra.Proveedor SET nombre = @nombre, direccion = @direccion, telefono = @telefono, correo = @correo WHERE idProveedor = @idProveedor
			PRINT 'Proveedor se ha modificado Correctamente'
		END
		ELSE
		BEGIN
			BEGIN TRAN @tra
			PRINT 'El proveedor ya existe'
			ROLLBACK TRAN @tra
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
DECLARE @tra varchar(20) = 'transact'
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
						BEGIN TRAN @tra
						PRINT 'Verifique el codigo del compartimiento'
						ROLLBACK TRAN @tra
					END
				END
				ELSE
				BEGIN
					BEGIN TRAN @tra
					PRINT 'Porfavor verifique los valores del stockMaximo'
					ROLLBACK TRAN @tra
				END
			END
			ELSE
			BEGIN
				BEGIN TRAN @tra
				PRINT 'La existencia no puede ser negativa'
				ROLLBACK TRAN @tra
			END
		END
		ELSE
		BEGIN
			BEGIN TRAN @tra
			PRINT 'Este material ya existe'
			ROLLBACK TRAN @tra
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
DECLARE @tra varchar(20) = 'transact'
	IF EXISTS (SELECT * FROM Compra.estadoCompras WHERE idEstadoCompras = @idEstadoCompras)
	BEGIN 
		IF NOT EXISTS(SELECT * FROM Compra.estadoCompras WHERE nombre = @nombre AND idEstadoCompras != @idEstadoCompras)
		BEGIN
			UPDATE Compra.estadoCompras SET nombre = @nombre WHERE idEstadoCompras != @idEstadoCompras
			PRINT 'Estado de compra se ha actualizado de forma correcta'
		END
		ELSE
		BEGIN
			BEGIN TRAN @tra
			PRINT 'El estado de Compras ya existe'
			ROLLBACK TRAN @tra
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
DECLARE @tra varchar(20) = 'transact'
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
			BEGIN TRAN @tra
			PRINT 'La compra ya existe'
			ROLLBACK TRAN @tra
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

/*
	Por otro lado dado que el procedimiento anterior solamente se encargará de verificar si una Sales Order
	tiene disponibilidad de ser puesta a producción, la empresa necesita que se automatice el proceso de
	asignación a los módulos de producción, por lo que, se pide que cree un procedimiento almacenado
	que tenga la capacidad de realizar este proceso de forma correcta TENIENDO EN CUENTA TODAS
	LAS CONSIDERACIONES QUE SE HAN ESPECIFICADO ANTERIORMENTE EN ESTE PROCESO.
*/

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

/*
De la misma forma, se solicita que se cree un procedimiento almacenado que se encargue de generar
	un reporte de facturación para cada una de las Facturas generadas especificando todos los ítems que
	se tienen dentro de ella, el reporte debe ser generado con la siguiente estructura propuesta: 
*/

--Factura.jpg
create type db_factura AS TABLE(nombre varchar(100), cantidad int, cantidadExtra int, precioUnitario decimal(18, 2), descripcion varchar(255), precioTotal decimal(18, 2));  
GO

/*declare @json varchar(max)
exec Produccion.crearReporte @idFactura = 1, @JSON = @json output
select @json
select * from Produccion.ordenVenta
*/

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
			select @JSON =  '{ "Error":"La factura no posee pedidos" }'
		END
	END
	ELSE
	BEGIN
		select @JSON =  '{ "Error":"El registro no existe" }'
	END

	return 1
go