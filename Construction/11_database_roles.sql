-- FleetAdmin. Teljes jog� hozz�f�r�s.

USE [MyFleet]
CREATE ROLE [FleetOwner]
ALTER AUTHORIZATION ON SCHEMA::[db_owner] TO [FleetOwner]
GO

-- BulkAdmin. Az adatok naprak�szen tart�sa lesz a felel�ss�ge.

USE [MyFleet]
CREATE ROLE [BulkAdmin]
ALTER AUTHORIZATION ON SCHEMA::[db_datawriter] TO [BulkAdmin]
GO

-- SecAdmin. A felhaszn�l�k megfelel� jogait �ll�tgat� szem�ly.

USE [MyFleet]
CREATE ROLE [SecAdmin]
ALTER AUTHORIZATION ON SCHEMA::[db_accessadmin] TO [SecAdmin]
GO
