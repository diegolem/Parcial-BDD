--Respaldo de la BDD /////////////////////////////////////////////////////////////////////////////////////

--Backup de la BDD
CREATE PROCEDURE CrearBackupFULL
AS
	BACKUP DATABASE CollegeCentralAmerica_LaLibertad TO DISK = 'C:\Backup\Proyecto-FULL.bak' --Backup FULL
	WITH INIT;
GO

EXEC CrearBackupFULL

CREATE PROCEDURE CrearBackup -- Backuo Diferencial
AS
    DECLARE @fecha DATE
    DECLARE @name VARCHAR(100)

    SET @fecha = GETDATE()
    SET @name  = 'C:\Backup\Proyecto-'+CONVERT(VARCHAR(MAX),@fecha, 105)+'.bak'

    BACKUP DATABASE CollegeCentralAmerica_LaLibertad TO DISK = @name
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
		@active_start_time = 000000
	;

	-- Agregando el trabajo al servidor
	EXEC dbo.sp_add_jobserver
		@job_name = 'BackupProyectoBDDFinal',
		@server_name = @@Servername
	;
;
EXEC CreandoJob;