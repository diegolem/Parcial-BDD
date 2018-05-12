-- Vistas
--1. Vista completa de los productos de inventario.
CREATE VIEW productos AS	
    SELECT 
        MT.nombre AS [Tipo de Producto], M.Descripcion AS [Producto] 
    FROM Bodega.MateriaPrima M 	
    INNER JOIN Bodega.TipoMateriaPrima MT ON M.idTipoMateriaPrima = MT.idTipoMateriaPrima;


-- 2. Vista completa de los trabajos en proceso.
CREATE VIEW trabajosProceso AS	
    SELECT 
        O.cantidad AS [Cantidad de prendas], Color.nombre AS [Color], O.monto AS  [Monto ($)], C.nombre AS [Cliente], F.idFactura AS [Factura (ID)]
    FROM Produccion.OrdenVenta O 
    INNER JOIN Produccion.estadoOrden E ON O.idEstado = E.idEstadoOrden	
    INNER JOIN Color ON O.idColor = Color.idColor
    INNER JOIN Venta.Factura F ON O.idFactura = F.idFactura	
    INNER JOIN Venta.Clientes C ON F.idCliente	= C.idCliente	
    WHERE E.idEstadoOrden = 1; --Por ejemplo si en el id 1 es "En proceso";


-- 3. Vista de los trabajos que aún no han sido implementados.
CREATE VIEW trabajosPendientes AS	
    SELECT 
        O.cantidad AS [Cantidad de prendas], Color.nombre AS [Color], O.monto AS  [Monto ($)], C.nombre AS [Cliente], F.idFactura AS [Factura (ID)]
    FROM Produccion.OrdenVenta O 
    INNER JOIN Produccion.estadoOrden E ON O.idEstado = E.idEstadoOrden	
    INNER JOIN Color ON O.idColor = Color.idColor
    INNER JOIN Venta.Factura F ON O.idFactura = F.idFactura	
    INNER JOIN Venta.Clientes C ON F.idCliente	= C.idCliente	
    WHERE E.idEstadoOrden = 3; --Por ejemplo si en el id 1 es "pendiente";


-- 4. Vista de los productos que están en fase de desabastecimiento junto con los proveedores y sus
--    datos de contacto.
CREATE VIEW productosNecesitados AS	
    SELECT 
        TMP.nombre AS [Tipo de Materia Prima], MP.descripcion AS [Producto], EC.nombre AS [Estado de Necesidad], P.nombre AS [Proveedor], P.telefono, P.correo
    FROM Compra.compras C 
    INNER JOIN Compra.estadoCompras EC ON C.idEstado = EC.idEstadoCompras	
    INNER JOIN Bodega.MateriaPrima MP ON C.idMateriaPrima = MP.idMateriaPrima
    INNER JOIN Bodega.tipoMateriaPrima TMP ON MP.idTipoMateriaPrima = TMP.idTipoMateriaPrima
    INNER JOIN Compra.Proveedor P ON	MP.idProveedor = P.idProveedor 
    WHERE EC.idEstadoCompras != 3; -- Donde 1 es 'Realizada', los otros pueden ser 'urgente'etc.


-- 5. Vista de total piezas que se han trabajado por módulo, agrupadas por medio de su categoría.
CREATE VIEW piezasModulo AS
    SELECT 
        P.nombre AS [Categoría], M.nombre AS [Módulo], SUM(OT.cantidad) AS [Cantidad] 
    FROM Produccion.ordenDeVentaTalla OT 
    INNER JOIN Produccion.modulo M ON OT.idModulo = M.idModulo
    INNER JOIN Producto.talla T ON OT.idTalla = T.idTalla 
    INNER JOIN Producto.prenda P ON P.idPrenda = T.idPrenda
    GROUP BY P.nombre, M.nombre;


-- 6. Vista de total de compras realizadas por clientes a lo largo de cada año.
CREATE VIEW comprasCliente AS	
    SELECT 
        TC.nombre AS [Tipo De Cliente], C.nombre AS [Nombre], COUNT(*) AS [N° de Compras], DATEPART(yyyy, F.orderDate) AS [Año]
    FROM Venta.Factura F 
    INNER JOIN Venta.Clientes C ON F.idCliente = C.idCliente
    INNER JOIN Venta.tipoCliente TC ON C.idTipo = TC.idTipo
    GROUP BY TC.nombre, C.nombre, DATEPART(yyyy, F.orderDate);


-- 7. Vista de Trabajos y Sales Orders asignadas a cada módulo.
CREATE VIEW ordenModulos AS
    SELECT 
        M.idModulo, M.nombre, COUNT(*) AS [Ordenes Asignadas] FROM Produccion.ordenVenta OV
    INNER JOIN Produccion.ordenDeVentaTalla OVT ON OV.idOrdenVenta = OVT.idOrdenVentaTalla
    INNER JOIN Produccion.modulo M ON OVT.idModulo = M.idModulo
    GROUP BY M.idModulo, M.nombre;


-- 8. Vista de Telas (Todos los datos junto con el nombre del proveedor) en Inventario.
CREATE VIEW telasMateriaPrima AS
    SELECT 
        mp.descripcion AS [Descripción], mp.existencia AS [Existencias], mp.stockMaximo AS [Stock Máximo], mp.idCompartimiento AS [Compartimiento], pr.nombre AS [Proveedor]
    FROM Bodega.MateriaPrima AS mp 
    INNER JOIN Bodega.tipoMateriaPrima AS tmp
    ON tmp.idTipoMateriaPrima = mp.idTipoMateriaPrima 
    INNER JOIN Compra.Proveedor AS pr
    ON pr.idProveedor = mp.idProveedor 
    WHERE tmp.nombre = 'Tela';


-- 9. Vista de Hilos (Todos los datos junto con el nombre del proveedor) en inventario.
CREATE VIEW hilosMateriaPrima AS
    SELECT 
        mp.descripcion AS [Descripción], mp.existencia AS [Existencias], mp.stockMaximo AS [Stock Máximo], mp.idCompartimiento AS [Compartimiento], pr.nombre AS [Proveedor]
    FROM Bodega.MateriaPrima AS mp 
    INNER JOIN Bodega.tipoMateriaPrima AS tmp
    ON tmp.idTipoMateriaPrima = mp.idTipoMateriaPrima 
    INNER JOIN Compra.Proveedor AS pr
    ON pr.idProveedor = mp.idProveedor 
    WHERE tmp.nombre = 'Hilo';


-- 10. Vista de Cordones (Todos los datos junto con el nombre del proveedor) en inventario.
CREATE VIEW cordonerMateriaPrima AS
    SELECT 
        mp.descripcion AS [Descripción], mp.existencia AS [Existencias], mp.stockMaximo AS [Stock Máximo], mp.idCompartimiento AS [Compartimiento], pr.nombre AS [Proveedor]
    FROM Bodega.MateriaPrima AS mp 
    INNER JOIN Bodega.tipoMateriaPrima AS tmp
    ON tmp.idTipoMateriaPrima = mp.idTipoMateriaPrima 
    INNER JOIN Compra.Proveedor AS pr
    ON pr.idProveedor = mp.idProveedor 
    WHERE tmp.nombre = 'Cordones';


-- 11. Vista de las Sales Order con categoría BLANKS.
CREATE VIEW ordenesBlanks AS
    SELECT 
        fa.idFactura AS [N° de Factura],
        pa.nombre as [Prenda],
        eo.codigo AS [Código de estilo],
        odv.cantidad AS [Cantidad de la orden],
        odv.monto AS [Monto de la orden],
        clr.nombre AS [Color]
    FROM Produccion.ordenVenta AS odv
    INNER JOIN Produccion.flujoTrabajo AS fto ON fto.idFlujo = odv.idFlujo
    INNER JOIN Produccion.tipoVariante AS tve ON tve.idVariante = fto.idVariante
    INNER JOIN color AS clr ON clr.idColor = odv.idColor
    INNER JOIN Producto.estilo AS eo ON eo.idEstilo = odv.idEstilo
    INNER JOIN Producto.prenda AS pa ON pa.idPrenda = eo.idPrenda
    INNER JOIN Venta.factura AS fa ON fa.idFactura = odv.idFactura
    WHERE tve.nombre = 'BLANKS';


-- 12. Vista de las Sales Order con categoría SCREEN PRINTING.
CREATE VIEW ordenesScreenPrinting AS
    SELECT 
        fa.idFactura AS [N° de Factura],pa.nombre as [Prenda], eo.codigo AS [Código de estilo],odv.cantidad AS [Cantidad de la orden], odv.monto AS [Monto de la orden], clr.nombre AS [Color]
    FROM Produccion.ordenVenta AS odv
    INNER JOIN Produccion.flujoTrabajo AS fto ON fto.idFlujo = odv.idFlujo
    INNER JOIN Produccion.tipoVariante AS tve ON tve.idVariante = fto.idVariante
    INNER JOIN color AS clr ON clr.idColor = odv.idColor
    INNER JOIN Producto.estilo AS eo ON eo.idEstilo = odv.idEstilo
    INNER JOIN Producto.prenda AS pa ON pa.idPrenda = eo.idPrenda
    INNER JOIN Venta.factura AS fa ON fa.idFactura = odv.idFactura
    WHERE tve.nombre = 'SCREEN PRINTING';


-- 13. Vista de las Sales Order con categoría Sublimation.
CREATE VIEW ordenesSublimation AS
    SELECT 
        fa.idFactura AS [N° de Factura],
        pa.nombre as [Prenda],
        eo.codigo AS [Código de estilo],
        odv.cantidad AS [Cantidad de la orden],
        odv.monto AS [Monto de la orden],
        clr.nombre AS [Color]
    FROM Produccion.ordenVenta AS odv
    INNER JOIN Produccion.flujoTrabajo AS fto ON fto.idFlujo = odv.idFlujo
    INNER JOIN Produccion.tipoVariante AS tve ON tve.idVariante = fto.idVariante
    INNER JOIN color AS clr ON clr.idColor = odv.idColor
    INNER JOIN Producto.estilo AS eo ON eo.idEstilo = odv.idEstilo
    INNER JOIN Producto.prenda AS pa ON pa.idPrenda = eo.idPrenda
    INNER JOIN Venta.factura AS fa ON fa.idFactura = odv.idFactura
    WHERE tve.nombre = 'Sublimation';

    
-- 14.  Vista de las Sales Order que tienen un tiempo de retraso en la fecha de Finalización.
CREATE VIEW ordenesConRetraso AS
    SELECT
        fa.idFactura AS [N° de Factura],
        pa.nombre as [Prenda],
        eo.codigo AS [Código de estilo],
        odv.cantidad AS [Cantidad de la orden],
        odv.monto AS [Monto de la orden],
        clr.nombre AS [Color]
    FROM Produccion.ordenVenta AS odv
    INNER JOIN Produccion.estadoOrden AS estadoO ON estadoO.idEstadoOrden = odv.idEstado
    INNER JOIN Venta.factura AS fa ON fa.idFactura = odv.idFactura
    INNER JOIN Produccion.flujoTrabajo AS fto ON fto.idFlujo = odv.idFlujo
    INNER JOIN Produccion.tipoVariante AS tve ON tve.idVariante = fto.idVariante
    INNER JOIN color AS clr ON clr.idColor = odv.idColor
    INNER JOIN Producto.estilo AS eo ON eo.idEstilo = odv.idEstilo
    INNER JOIN Producto.prenda AS pa ON pa.idPrenda = eo.idPrenda
    WHERE DATEDIFF(DAY, CURRENT_TIMESTAMP, fa.finishedDate) <= -1 AND estadoO.idEstadoOrden = 1;
