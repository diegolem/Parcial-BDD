USE CollegeCentralAmerica_LaLibertad

--Creacion de tablas
CREATE TABLE departamento(
    idDepartamento INT PRIMARY KEY IDENTITY(1,1) NOT NULL,
    nombre VARCHAR(100) NOT NULL,
    descripcion VARCHAR(250) NOT NULL 
)

CREATE TABLE procesos(
    idProceso INT PRIMARY KEY IDENTITY(1,1) NOT NULL,
    nombre VARCHAR(30) NOT NULL,
    duracion INT NOT NULL,
    idDepartamento INT FOREIGN KEY REFERENCES departamento(idDepartamento)
)

CREATE TABLE tipoCliente(
    idTipo INT PRIMARY KEY IDENTITY(1,1) NOT NULL,
    nombre VARCHAR(25) NOT NULL,
)

CREATE TABLE clientes(
    idCliente INT PRIMARY KEY IDENTITY(1,1) NOT NULL,
    nombre VARCHAR(35) NOT NULL,
    dui CHAR(10) NOT NULL,
    nit CHAR(17) NOT NULL,
    direccion VARCHAR(150) NOT NULL,
    telefono VARCHAR(9) NOT NULL,
    correo VARCHAR(50) NOT NULL,
    idTipo INT FOREIGN KEY REFERENCES tipoCliente(idTipo)
)

CREATE TABLE metodologia(
    idMetodologia INT PRIMARY KEY IDENTITY(1,1) NOT NULL,
    nombre VARCHAR(100) NOT NULL,
)

CREATE TABLE modulo(
    idModulo INT PRIMARY KEY IDENTITY(1,1) NOT NULL,
    nombre VARCHAR(60) NOT NULL,
    cantidadProduccion INT NOT NULL,
    idMetodologia INT FOREIGN KEY REFERENCES metodologia(idMetodologia)
)

CREATE TABLE factura(
    idFactura INT PRIMARY KEY IDENTITY(1,1) NOT NULL,
    requiredDate DATE NOT NULL,
    orderDate DATE NOT NULL,
    finishedDate DATE NOT NULL,
    shipmentDate DATE NOT NULL,
    total MONEY NULL,
    direccion VARCHAR(250) NOT NULL,
    idCliente INT FOREIGN KEY REFERENCES clientes(idCliente)
)

CREATE TABLE tipoVariante(
    idVariante INT PRIMARY KEY IDENTITY(1,1) NOT NULL,
    nombre VARCHAR(25) NOT NULL
)

CREATE TABLE detalles(
    idDetalle INT PRIMARY KEY IDENTITY(1,1) NOT NULL,
    descripcion VARCHAR(200) NOT NULL,
    precio MONEY NOT NULL,
    idProceso INT FOREIGN KEY REFERENCES procesos(idProceso)
)

CREATE TABLE detalleVarianteDetalle(
    idVariante INT FOREIGN KEY REFERENCES tipoVariante(idVariante),
    idDetalle INT FOREIGN KEY REFERENCES detalles(idDetalle)
)

CREATE TABLE flujoTrabajo(
    idFlujo INT PRIMARY KEY IDENTITY(1,1) NOT NULL,
    idVariante INT FOREIGN KEY REFERENCES tipoVariante(idVariante)
)
CREATE TABLE detalleFlujoTrabajoProcesos(
    idFlujo INT FOREIGN KEY REFERENCES flujoTrabajo(idFlujo),
    idProceso INT FOREIGN KEY REFERENCES procesos(idProceso)
)
CREATE TABLE estadoSeguimiento(
    idEstadoSeguimiento INT PRIMARY KEY IDENTITY(1,1) NOT NULL,
    nombre VARCHAR(25) NOT NULL
)
CREATE TABLE estadoOrden(
    idEstadoOrden INT PRIMARY KEY IDENTITY(1,1) NOT NULL,
    nombre VARCHAR(25) NOT NULL
)
CREATE TABLE prenda(
    idPrenda INT PRIMARY KEY IDENTITY(1,1) NOT NULL,
    nombre VARCHAR(100) NOT NULL,
    precio MONEY NOT NULL
)
CREATE TABLE estilo(
    idEstilo INT PRIMARY KEY IDENTITY(1,1) NOT NULL,
    codigo CHAR(5) NOT NULL,
    idPrenda INT FOREIGN KEY REFERENCES prenda(idPrenda)
)

CREATE TABLE tipoTalla(
    idTipoTalla INT PRIMARY KEY IDENTITY(1,1) NOT NULL,
    nombre VARCHAR(40) NOT NULL,
    abreviacion CHAR(4) NOT NULL
)
CREATE TABLE tallaUbicacion(
    idUbicacion INT PRIMARY KEY IDENTITY(1,1) NOT NULL,
    ubicacion VARCHAR(50) NOT NULL
)

CREATE TABLE talla(
    idTalla INT PRIMARY KEY IDENTITY(1,1) NOT NULL,
    cantidadTela DECIMAL(18, 2) NOT NULL,
    idTipoTalla INT FOREIGN KEY REFERENCES tipoTalla(idTipoTalla),
    idPrenda INT FOREIGN KEY REFERENCES prenda(idPrenda),
    idEstilo INT FOREIGN KEY REFERENCES estilo(idEstilo)
)

CREATE TABLE medida(
    idMedida INT PRIMARY KEY IDENTITY(1,1) NOT NULL,
    dimension DECIMAL(18,2) NOT NULL,
    idTalla INT FOREIGN KEY REFERENCES talla(idTalla),
    idUbicacion INT FOREIGN KEY REFERENCES tallaUbicacion(idUbicacion)
)

CREATE TABLE color(
    idColor INT PRIMARY KEY IDENTITY(1,1) NOT NULL,
    nombre VARCHAR(50) NOT NULL
)

CREATE TABLE ordenVenta(
    idOrdenVenta INT PRIMARY KEY IDENTITY(1,1) NOT NULL,
    monto MONEY NOT NULL,
    cantidad INT NOT NULL,
    idFactura INT FOREIGN KEY REFERENCES factura(idFactura),
    idEstilo INT FOREIGN KEY REFERENCES estilo(idEstilo),
    idFlujo INT FOREIGN KEY REFERENCES flujoTrabajo(idFlujo),
    idColor INT FOREIGN KEY REFERENCES color(idColor),
    idEstado INT FOREIGN KEY REFERENCES estadoOrden(idEstadoOrden)
)


CREATE TABLE ordenDeVentaTalla(
    idOrdenVentaTalla INT PRIMARY KEY IDENTITY(1,1) NOT NULL,
    cantidad INT NOT NULL,
    cantidadExtra INT NOT NULL,
    cantidadTela DECIMAL(18,2) NOT NULL,
    idTalla INT FOREIGN KEY REFERENCES talla(idTalla),
    idModulo INT FOREIGN KEY REFERENCES modulo(idModulo),
    idOrdenVenta INT FOREIGN KEY REFERENCES ordenVenta(idOrdenVenta)
)

CREATE TABLE seguimientoOrden(
    idSeguimiento INT PRIMARY KEY IDENTITY(1,1) NOT NULL,
    idEstado INT FOREIGN KEY REFERENCES estadoSeguimiento(idEstadoSeguimiento),
    idOrdenVenta INT FOREIGN KEY REFERENCES ordenVenta(idOrdenVenta),
    idProceso INT FOREIGN KEY REFERENCES procesos(idProceso)
)
CREATE TABLE tipoUnidadMedidas(
    idTipoUnidad CHAR(6) PRIMARY KEY NOT NULL,
    nombre VARCHAR(60) NOT NULL
)

CREATE TABLE tipoMateriaPrima(
    idTipoMateriaPrima INT PRIMARY KEY IDENTITY(1,1) NOT NULL,
    nombre VARCHAR(60) NOT NULL,
    idMedicion CHAR(6) FOREIGN KEY REFERENCES tipoUnidadMedidas(idTipoUnidad)
)

CREATE TABLE estante(
    idEstante CHAR(1) PRIMARY KEY NOT NULL
)
CREATE TABLE nivel(
    idNivel INT PRIMARY KEY IDENTITY(1,1) NOT NULL,
    nivel INT NOT NULL
)
CREATE TABLE columna(
    idColumna INT PRIMARY KEY IDENTITY(1,1) NOT NULL,
    columna INT NOT NULL
)

CREATE TABLE Compartimiento(
    idCompartimiento CHAR(3) PRIMARY KEY NOT NULL,
    estado tinyint NOT NULL,
    idEstante CHAR(1) FOREIGN KEY REFERENCES estante(idEstante),
    idNivel INT FOREIGN KEY REFERENCES nivel(idNivel),
    idColumna INT FOREIGN KEY REFERENCES columna(idColumna)
)

CREATE TABLE Proveedor(
    idProveedor INT PRIMARY KEY IDENTITY(1,1) NOT NULL,
    nombre VARCHAR(100) NOT NULL,
    direccion VARCHAR(200) NOT NULL,
    telefono CHAR(9) NOT NULL,
    correo VARCHAR(50) NOT NULL
)

CREATE TABLE MateriaPrima(
    idMateriaPrima INT PRIMARY KEY IDENTITY(1,1) NOT NULL,
    descripcion VARCHAR(200) NOT NULL,
    existencia DECIMAL(18,2) NOT NULL,
    stockMaximo DECIMAL(18,2) NOT NULL,
    idTipoMateriaPrima INT FOREIGN KEY REFERENCES tipoMateriaPrima(idTipoMateriaPrima),
    idCompartimiento CHAR(3) FOREIGN KEY REFERENCES compartimiento(idCompartimiento) NOT NULL,
    idColor INT FOREIGN KEY REFERENCES color(idColor),
    idProveedor INT FOREIGN KEY REFERENCES proveedor(idProveedor)
)

CREATE TABLE estadoCompras(
    idEstadoCompras INT PRIMARY KEY IDENTITY(1,1) NOT NULL,
    nombre VARCHAR(25) NOT NULL
)

CREATE TABLE compras(
    idCompras INT PRIMARY KEY IDENTITY(1,1) NOT NULL,
    cantidad DECIMAL(18,2) NOT NULL,
    idEstado INT FOREIGN KEY REFERENCES estadoCompras(idEstadoCompras),
    idMateriaPrima INT FOREIGN KEY REFERENCES materiaPrima(idMateriaPrima)
)

 --En la tabla procesos, la duración debe ser mayor a 0 y menor a 28
ALTER TABLE procesos
    ADD CONSTRAINT chkduracion
    CHECK ((duracion > 0 ) AND (duracion < 28)) 
 --En cada campo donde posea teléfono que siga formato (XXXXXXX ó XXXX-XXX).
 
 --El campo código en Estilo debe ser: [A-Z]{2}[0-9]{3}, ademas debe ser unico
ALTER TABLE [estilo] ADD CONSTRAINT chkCodigoEstilo CHECK (codigo LIKE '%[A-Z][A-Z][0-9][0-9][0-9]%')

ALTER TABLE estilo ADD CONSTRAINT uCodigo UNIQUE (codigo)
	
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
    CHECK (nombre NOT LIKE '%[^a-z ]%');

ALTER TABLE tipoCliente
    ADD CONSTRAINT CHK_tipocliente_nombre
    CHECK (nombre NOT LIKE '%[^a-z ]%');

ALTER TABLE metodologia
    ADD CONSTRAINT CHK_metodologia_nombre
    CHECK (nombre NOT LIKE '%[^a-z ]%');

ALTER TABLE estadoOrden
    ADD CONSTRAINT CHK_estadoOrden_nombre
    CHECK (nombre NOT LIKE '%[^a-z ]%');

ALTER TABLE tipoVariante
    ADD CONSTRAINT CHK_tipoVariante_nombre
    CHECK (nombre NOT LIKE '%[^a-z ]%');

ALTER TABLE estadoCompras
    ADD CONSTRAINT CHK_estadoCompras_nombre
    CHECK (nombre NOT LIKE  '%[^a-z ]%');

ALTER TABLE estadoSeguimiento
    ADD CONSTRAINT CHK_estadoSeguimiento_nombre
    CHECK (nombre NOT LIKE '%[^a-z ]%');
