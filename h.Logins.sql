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
DROP USER FernandaValle
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