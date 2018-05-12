USE master;
GO

IF EXISTS(SELECT * FROM sys.databases WHERE name='CollegeCentralAmerica_LaLibertad')
DROP DATABASE CollegeCentralAmerica_LaLibertad

--Creacion de la BDD
CREATE DATABASE CollegeCentralAmerica_LaLibertad