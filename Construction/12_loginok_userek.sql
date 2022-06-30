-- Database Owner. Teljes jog� hozz�f�r�s.

USE [master]
CREATE LOGIN [DBFleetOwner] WITH PASSWORD=N'Pa55w.rd', DEFAULT_DATABASE=[MyFleet], CHECK_EXPIRATION=OFF, CHECK_POLICY=OFF
ALTER SERVER ROLE [sysadmin] ADD MEMBER [DBFleetOwner]
GO

USE [MyFleet]
CREATE USER [DBFleetOwner] FOR LOGIN [DBFleetOwner]
ALTER ROLE [db_owner] ADD MEMBER [DBFleetOwner]
GO
ALTER ROLE [FleetOwner] ADD MEMBER [DBFleetOwner]
GO

-- DataAdmin. Az adatok karbantart�s��rt felel�s szem�ly.

USE [master]
CREATE LOGIN [DBDataAdmin] WITH PASSWORD=N'Pa55w.rd', DEFAULT_DATABASE=[MyFleet], CHECK_EXPIRATION=OFF, CHECK_POLICY=OFF
ALTER SERVER ROLE [bulkadmin] ADD MEMBER [DBDataAdmin]
GO

USE [MyFleet]
CREATE USER [DBDataAdmin] FOR LOGIN [DBDataAdmin] 
ALTER ROLE [db_datawriter] ADD MEMBER [DBDataAdmin]
GO
ALTER ROLE [BulkAdmin] ADD MEMBER [DBDataAdmin]
GO

-- SecurityAdmin. Az �j/t�voz� alkalmazottak jogainak megad�s��rt/elv�tel��rt felel�s szem�ly.

USE [master]
CREATE LOGIN [DBSecAdmin] WITH PASSWORD=N'Pa55w.rd', DEFAULT_DATABASE=[MyFleet], CHECK_EXPIRATION=OFF, CHECK_POLICY=OFF
ALTER SERVER ROLE [securityadmin] ADD MEMBER [DBSecAdmin]
GO

USE [MyFleet]
CREATE USER [DBSecAdmin] FOR LOGIN [DBSecAdmin]
ALTER ROLE [db_securityadmin] ADD MEMBER [DBSecAdmin]
GO
ALTER ROLE [SecAdmin] ADD MEMBER [DBSecAdmin]
GO
