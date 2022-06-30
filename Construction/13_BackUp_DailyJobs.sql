-- Teljes mentés.
BACKUP DATABASE [MyFleet] TO  DISK = N'C:\Program Files\Microsoft SQL Server\MSSQL15.MSSQLSERVER\MSSQL\Backup\MyFleet.bak' WITH NOFORMAT, NOINIT,  NAME = N'FullBackUp', SKIP, NOREWIND, NOUNLOAD,  STATS = 10
GO
declare @backupSetId as int
select @backupSetId = position from msdb..backupset where database_name=N'MyFleet' and backup_set_id=(select max(backup_set_id) from msdb..backupset where database_name=N'MyFleet' )
if @backupSetId is null begin raiserror(N'Verify failed. Backup information for database ''MyFleet'' not found.', 16, 1) end
RESTORE VERIFYONLY FROM  DISK = N'C:\Program Files\Microsoft SQL Server\MSSQL15.MSSQLSERVER\MSSQL\Backup\MyFleet.bak' WITH  FILE = @backupSetId,  NOUNLOAD,  NOREWIND
GO

-- Differenciális mentés.
BACKUP DATABASE [MyFleet] TO  DISK = N'C:\Program Files\Microsoft SQL Server\MSSQL15.MSSQLSERVER\MSSQL\Backup\MyFleet.bak' WITH  DIFFERENTIAL , NOFORMAT, NOINIT,  NAME = N'DifferentialBackUp', SKIP, NOREWIND, NOUNLOAD,  STATS = 10
GO
declare @backupSetId as int
select @backupSetId = position from msdb..backupset where database_name=N'MyFleet' and backup_set_id=(select max(backup_set_id) from msdb..backupset where database_name=N'MyFleet' )
if @backupSetId is null begin raiserror(N'Verify failed. Backup information for database ''MyFleet'' not found.', 16, 1) end
RESTORE VERIFYONLY FROM  DISK = N'C:\Program Files\Microsoft SQL Server\MSSQL15.MSSQLSERVER\MSSQL\Backup\MyFleet.bak' WITH  FILE = @backupSetId,  NOUNLOAD,  NOREWIND
GO

-- Log mentés.
BACKUP LOG [MyFleet] TO  DISK = N'C:\Program Files\Microsoft SQL Server\MSSQL15.MSSQLSERVER\MSSQL\Backup\MyFleet.bak' WITH NOFORMAT, NOINIT,  NAME = N'TransactionLogBackUp', SKIP, NOREWIND, NOUNLOAD,  STATS = 10
GO
declare @backupSetId as int
select @backupSetId = position from msdb..backupset where database_name=N'MyFleet' and backup_set_id=(select max(backup_set_id) from msdb..backupset where database_name=N'MyFleet' )
if @backupSetId is null begin raiserror(N'Verify failed. Backup information for database ''MyFleet'' not found.', 16, 1) end
RESTORE VERIFYONLY FROM  DISK = N'C:\Program Files\Microsoft SQL Server\MSSQL15.MSSQLSERVER\MSSQL\Backup\MyFleet.bak' WITH  FILE = @backupSetId,  NOUNLOAD,  NOREWIND
GO


---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
 
-- Job-ok létrehozása.

-- 1.) Napi teljes mentés, hajnali 2-kor.
DECLARE @jobId BINARY(16)
EXEC  msdb.dbo.sp_add_job @job_name=N'DailyBackUp', 
		@enabled=1, 
		@notify_level_eventlog=0, 
		@notify_level_email=2, 
		@notify_level_page=2, 
		@delete_level=0, 
		@category_name=N'[Uncategorized (Local)]', 
		@owner_login_name=N'DESKTOP-OTN3E3M\DSCenter', @job_id = @jobId OUTPUT
select @jobId
GO
EXEC msdb.dbo.sp_add_jobserver @job_name=N'DailyBackUp', @server_name = N'DESKTOP-OTN3E3M'
GO
USE [msdb]
GO
EXEC msdb.dbo.sp_add_jobstep @job_name=N'DailyBackUp', @step_name=N'FullDaily', 
		@step_id=1, 
		@cmdexec_success_code=0, 
		@on_success_action=1, 
		@on_fail_action=2, 
		@retry_attempts=0, 
		@retry_interval=0, 
		@os_run_priority=0, @subsystem=N'TSQL', 
		@command=N'BACKUP DATABASE [MyFleet] TO  DISK = N''C:\Program Files\Microsoft SQL Server\MSSQL15.MSSQLSERVER\MSSQL\Backup\MyFleet.bak'' WITH NOFORMAT, NOINIT,  NAME = N''FullBackUp'', SKIP, NOREWIND, NOUNLOAD,  STATS = 10
GO
declare @backupSetId as int
select @backupSetId = position from msdb..backupset where database_name=N''MyFleet'' and backup_set_id=(select max(backup_set_id) from msdb..backupset where database_name=N''MyFleet'' )
if @backupSetId is null begin raiserror(N''Verify failed. Backup information for database ''''MyFleet'''' not found.'', 16, 1) end
RESTORE VERIFYONLY FROM  DISK = N''C:\Program Files\Microsoft SQL Server\MSSQL15.MSSQLSERVER\MSSQL\Backup\MyFleet.bak'' WITH  FILE = @backupSetId,  NOUNLOAD,  NOREWIND
GO', 
		@database_name=N'MyFleet', 
		@flags=0
GO
USE [msdb]
GO
EXEC msdb.dbo.sp_update_job @job_name=N'DailyBackUp', 
		@enabled=1, 
		@start_step_id=1, 
		@notify_level_eventlog=0, 
		@notify_level_email=2, 
		@notify_level_page=2, 
		@delete_level=0, 
		@description=N'', 
		@category_name=N'[Uncategorized (Local)]', 
		@owner_login_name=N'DESKTOP-OTN3E3M\DSCenter', 
		@notify_email_operator_name=N'', 
		@notify_page_operator_name=N''
GO
USE [msdb]
GO
DECLARE @schedule_id int
EXEC msdb.dbo.sp_add_jobschedule @job_name=N'DailyBackUp', @name=N'DailyBackup', 
		@enabled=1, 
		@freq_type=4, 
		@freq_interval=1, 
		@freq_subday_type=1, 
		@freq_subday_interval=0, 
		@freq_relative_interval=0, 
		@freq_recurrence_factor=1, 
		@active_start_date=20220626, 
		@active_end_date=99991231, 
		@active_start_time=20000, 
		@active_end_time=235959, @schedule_id = @schedule_id OUTPUT
select @schedule_id
GO

-- Differenciális mentés 6 és 22 között, 2 óránként.

DECLARE @jobId BINARY(16)
EXEC  msdb.dbo.sp_add_job @job_name=N'Differential_2H', 
		@enabled=1, 
		@notify_level_eventlog=0, 
		@notify_level_email=2, 
		@notify_level_page=2, 
		@delete_level=0, 
		@category_name=N'[Uncategorized (Local)]', 
		@owner_login_name=N'DESKTOP-OTN3E3M\DSCenter', @job_id = @jobId OUTPUT
select @jobId
GO
EXEC msdb.dbo.sp_add_jobserver @job_name=N'Differential_2H', @server_name = N'DESKTOP-OTN3E3M'
GO
USE [msdb]
GO
EXEC msdb.dbo.sp_add_jobstep @job_name=N'Differential_2H', @step_name=N'Differential_2H', 
		@step_id=1, 
		@cmdexec_success_code=0, 
		@on_success_action=1, 
		@on_fail_action=2, 
		@retry_attempts=0, 
		@retry_interval=0, 
		@os_run_priority=0, @subsystem=N'TSQL', 
		@command=N'BACKUP DATABASE [MyFleet] TO  DISK = N''C:\Program Files\Microsoft SQL Server\MSSQL15.MSSQLSERVER\MSSQL\Backup\MyFleet.bak'' WITH  DIFFERENTIAL , NOFORMAT, NOINIT,  NAME = N''DifferentialBackUp'', SKIP, NOREWIND, NOUNLOAD,  STATS = 10
GO
declare @backupSetId as int
select @backupSetId = position from msdb..backupset where database_name=N''MyFleet'' and backup_set_id=(select max(backup_set_id) from msdb..backupset where database_name=N''MyFleet'' )
if @backupSetId is null begin raiserror(N''Verify failed. Backup information for database ''''MyFleet'''' not found.'', 16, 1) end
RESTORE VERIFYONLY FROM  DISK = N''C:\Program Files\Microsoft SQL Server\MSSQL15.MSSQLSERVER\MSSQL\Backup\MyFleet.bak'' WITH  FILE = @backupSetId,  NOUNLOAD,  NOREWIND
GO', 
		@database_name=N'MyFleet', 
		@flags=0
GO
USE [msdb]
GO
EXEC msdb.dbo.sp_update_job @job_name=N'Differential_2H', 
		@enabled=1, 
		@start_step_id=1, 
		@notify_level_eventlog=0, 
		@notify_level_email=2, 
		@notify_level_page=2, 
		@delete_level=0, 
		@description=N'', 
		@category_name=N'[Uncategorized (Local)]', 
		@owner_login_name=N'DESKTOP-OTN3E3M\DSCenter', 
		@notify_email_operator_name=N'', 
		@notify_page_operator_name=N''
GO
USE [msdb]
GO
DECLARE @schedule_id int
EXEC msdb.dbo.sp_add_jobschedule @job_name=N'Differential_2H', @name=N'Differential', 
		@enabled=1, 
		@freq_type=4, 
		@freq_interval=1, 
		@freq_subday_type=8, 
		@freq_subday_interval=2, 
		@freq_relative_interval=0, 
		@freq_recurrence_factor=1, 
		@active_start_date=20220626, 
		@active_end_date=99991231, 
		@active_start_time=60000, 
		@active_end_time=220000, @schedule_id = @schedule_id OUTPUT
select @schedule_id
GO

-- Log mentés 30 percenként.

DECLARE @jobId BINARY(16)
EXEC  msdb.dbo.sp_add_job @job_name=N'LogBackUp', 
		@enabled=1, 
		@notify_level_eventlog=0, 
		@notify_level_email=2, 
		@notify_level_page=2, 
		@delete_level=0, 
		@category_name=N'[Uncategorized (Local)]', 
		@owner_login_name=N'DESKTOP-OTN3E3M\DSCenter', @job_id = @jobId OUTPUT
select @jobId
GO
EXEC msdb.dbo.sp_add_jobserver @job_name=N'LogBackUp', @server_name = N'DESKTOP-OTN3E3M'
GO
USE [msdb]
GO
EXEC msdb.dbo.sp_add_jobstep @job_name=N'LogBackUp', @step_name=N'15min_log', 
		@step_id=1, 
		@cmdexec_success_code=0, 
		@on_success_action=1, 
		@on_fail_action=2, 
		@retry_attempts=0, 
		@retry_interval=0, 
		@os_run_priority=0, @subsystem=N'TSQL', 
		@command=N'BACKUP LOG [MyFleet] TO  DISK = N''C:\Program Files\Microsoft SQL Server\MSSQL15.MSSQLSERVER\MSSQL\Backup\MyFleet.bak'' WITH NOFORMAT, NOINIT,  NAME = N''TransactionLogBackUp'', SKIP, NOREWIND, NOUNLOAD,  STATS = 10
GO
declare @backupSetId as int
select @backupSetId = position from msdb..backupset where database_name=N''MyFleet'' and backup_set_id=(select max(backup_set_id) from msdb..backupset where database_name=N''MyFleet'' )
if @backupSetId is null begin raiserror(N''Verify failed. Backup information for database ''''MyFleet'''' not found.'', 16, 1) end
RESTORE VERIFYONLY FROM  DISK = N''C:\Program Files\Microsoft SQL Server\MSSQL15.MSSQLSERVER\MSSQL\Backup\MyFleet.bak'' WITH  FILE = @backupSetId,  NOUNLOAD,  NOREWIND
GO
', 
		@database_name=N'MyFleet', 
		@flags=0
GO
USE [msdb]
GO
EXEC msdb.dbo.sp_update_job @job_name=N'LogBackUp', 
		@enabled=1, 
		@start_step_id=1, 
		@notify_level_eventlog=0, 
		@notify_level_email=2, 
		@notify_level_page=2, 
		@delete_level=0, 
		@description=N'', 
		@category_name=N'[Uncategorized (Local)]', 
		@owner_login_name=N'DESKTOP-OTN3E3M\DSCenter', 
		@notify_email_operator_name=N'', 
		@notify_page_operator_name=N''
GO
USE [msdb]
GO
DECLARE @schedule_id int
EXEC msdb.dbo.sp_add_jobschedule @job_name=N'LogBackUp', @name=N'15min_log_backup', 
		@enabled=1, 
		@freq_type=4, 
		@freq_interval=1, 
		@freq_subday_type=4, 
		@freq_subday_interval=30, 
		@freq_relative_interval=0, 
		@freq_recurrence_factor=1, 
		@active_start_date=20220626, 
		@active_end_date=99991231, 
		@active_start_time=60000, 
		@active_end_time=220000, @schedule_id = @schedule_id OUTPUT
select @schedule_id
GO