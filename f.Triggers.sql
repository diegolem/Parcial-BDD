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
            @idMateria INT,@transaccion varchar(20) = 'transact'; 
        BEGIN
            SELECT @verificarCantidad = cantidad FROM inserted
            SELECT @idMateria = idMateriaPrima FROM inserted
            --Ingreso de datos
            IF (@verificarCantidad < 0)
            BEGIN
				BEGIN TRAN @transaccion
                PRINT 'La cantidad no debe ser menor a 0'
                ROLLBACK TRAN @transaccion
            END
        END
	END
GO
	
--Verificar la modificacion de la cantidad
CREATE TRIGGER verificarComprasUpdate
	ON Compra.compras
	FOR UPDATE
	AS
	DECLARE @cantidad DECIMAL(18,2),@transaccion varchar(20) = 'transact'; 
	BEGIN
		IF UPDATE(cantidad)
		SELECT @cantidad = cantidad FROM inserted
		BEGIN
			IF(@cantidad < 0)
			BEGIN
				BEGIN TRAN @transaccion
				PRINT 'La cantidad no debe ser menor a 0'
				ROLLBACK TRAN @transaccion
			END
		END
	END
GO

--Verificar datos de Sales Order
CREATE TRIGGER verificarSalesOrderInsert ON Produccion.ordenVenta
FOR INSERT AS
	DECLARE @monto MONEY, @cantidad DECIMAL(18,2), @factura INT, @estilo INT, @flujo INT, @color INT, @estado INT,@transaccion varchar(20) = 'transact'; 
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
		BEGIN TRAN @transaccion
		PRINT 'La cantidad no debe ser menor a 0'
		ROLLBACK TRAN @transaccion
	END
	IF(@monto < 0)
	BEGIN
		BEGIN TRAN @transaccion
		PRINT 'El monto no puede ser menor que 0'
		ROLLBACK TRAN @transaccion
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
		@cantidad DECIMAL(18,2),@transaccion varchar(20) = 'transact'; 
	BEGIN
		IF UPDATE(monto)
		SELECT @monto = monto FROM inserted
		BEGIN
			IF(@monto < 0)
			BEGIN
			BEGIN TRAN @transaccion
				PRINT 'El monto no debe ser menor a 0'
				ROLLBACK TRAN @transaccion
			END
		END
		IF UPDATE(cantidad)
		BEGIN
			SELECT @cantidad = cantidad FROM inserted
			BEGIN
				IF(@cantidad < 0)
				BEGIN
					BEGIN TRAN @transaccion
					PRINT 'La cantidad no puede ser menor a 0'
					ROLLBACK TRAN @transaccion
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
CREATE TRIGGER actualizar_EstadoOrden
on Produccion.SeguimientoOrden
after update
as
	-- Informacion sobre la fila a modificar
	declare @id int, @id_orden int, @primer_proceso bit, @ultimo_proceso bit, @proceso_completado bit = 0, @completo varchar(25) = 'Finalizado',@transaccion varchar(20) = 'transact'; 
	
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
		BEGIN TRAN @transaccion
		RAISERROR(50019,21,1)
		ROLLBACK TRAN @transaccion
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
	DECLARE @tela decimal(18,2),@color int,@id int,@existencia decimal(18,2),@transaccion varchar(20) = 'transact'
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
				BEGIN TRAN @transaccion
				PRINT 'La cantidad de tela sobrepasa las existencias'
				ROLLBACK TRAN @transaccion
			END
		END
		ELSE
		BEGIN
			BEGIN TRAN @transaccion
			PRINT 'Porfavor revise el valor de la cantidad de Tela de la orden'
			ROLLBACK TRAN @transaccion
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
	AS DECLARE @fechaI DATE,@fechaD DATE,@id INT,@idR INT,@transaccion varchar(20) = 'transact'
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
				BEGIN TRAN @transaccion
				PRINT 'Le fecha modificada no puede ser menos a la que se tenia anteriormente'
				ROLLBACK TRAN @transaccion
			END
		END
	END
GO

/*
    Para el proceso de las compras, la cantidad de producto a comprar junto con el de bodega NO
    PUEDE sobrepasar el límite del Stock Máximo que Maneja la empresa (7500 YDS para la tela).
*/
--TRIGGER #5
CREATE TRIGGER StockMaximoCompras on Compra.compras
AFTER INSERT
AS 
	DECLARE @cantidadM DECIMAL(18,2),@compra decimal(18,2),@stockmax decimal(18,2), @idM int,@bodega decimal(18,2),@sumatoria decimal(18,2),@idEstado INT,@transaccion varchar(20) = 'transact'
	BEGIN
		SELECT @compra = cantidad FROM inserted
		SELECT @idM = idMateriaPrima FROM inserted
		SELECT @idEstado = idEstado FROM inserted
		SELECT @stockmax = stockMaximo FROM Bodega.MateriaPrima WHERE idMateriaPrima = @idM
		SELECT @bodega = existencia FROM Bodega.MateriaPrima WHERE idMateriaPrima = @idM
		SET @sumatoria = @compra + @bodega
		IF(@sumatoria > @stockmax)
		BEGIN
			BEGIN TRAN @transaccion
			PRINT 'La compra sobrepasa los valores del almacenamiento máximo'
			ROLLBACK TRAN @transaccion
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
CREATE TRIGGER comprobar_copatibilidadProcesosFlujo
on Produccion.detalleFlujoTrabajoProcesos
after insert, update
as
	-- Obtenemos el proceso a que hacemos mencion
	declare @id_proceso int, @id_variante int,@transaccion varchar(20) = 'transact'
	
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
			BEGIN TRAN @transaccion
			RAISERROR(50018,20,1)
			ROLLBACK TRAN @transaccion
		end
	end
go

/*
    Deberá verificarse también que por ejemplo, no sean asignados dos estampados en la misma
    zona a una misma Sales Order
*/
--Trigger #7
CREATE TRIGGER verificarEstampado ON Produccion.detalleVarianteDetalle
FOR INSERT
AS
	DECLARE @idVariante INT,@detalleID INT,@transaccion varchar(20) = 'transact'
	BEGIN
		SELECT @idVariante = idVariante FROM inserted
		SELECT @detalleID = idDetalle FROM inserted
		IF (SELECT COUNT(*) FROM Produccion.detalleVarianteDetalle WHERE idDetalle = @detalleID AND idVariante = @idVariante) > 1
		BEGIN
				BEGIN TRAN @transaccion
				PRINT 'Ya hay un estampado en esta ubicacion para esta orden'
				ROLLBACK TRAN @transaccion
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
	DECLARE @idCompartimiento CHAR(3),@idMateriaPrima INT,@transaccion varchar(20) = 'transact'
	SELECT @idCompartimiento = idCompartimiento FROM inserted
	IF(SELECT estado FROM Bodega.Compartimiento WHERE idCompartimiento = @idCompartimiento) = 0
	BEGIN
		PRINT 'El compartimiento esta disponible'
		UPDATE Bodega.Compartimiento SET estado = 2 WHERE idCompartimiento = @idCompartimiento
	END
	ELSE IF(SELECT estado FROM Bodega.Compartimiento WHERE idCompartimiento = @idCompartimiento) = 1
	BEGIN
		BEGIN TRAN @transaccion
		PRINT 'El compartimiento ya esta ocupado'
		ROLLBACK TRAN @transaccion
	END
GO