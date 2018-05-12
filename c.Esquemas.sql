--Creaccion de Esquemas
CREATE SCHEMA Venta;
CREATE SCHEMA Compra;
CREATE SCHEMA Produccion;
CREATE SCHEMA Bodega;
CREATE SCHEMA Producto;

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