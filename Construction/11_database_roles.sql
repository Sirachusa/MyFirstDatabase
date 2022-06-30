-- FleetAdmin. Teljes jogú hozzáférés.

USE [MyFleet]
CREATE ROLE [FleetOwner]
ALTER AUTHORIZATION ON SCHEMA::[db_owner] TO [FleetOwner]
GO

-- BulkAdmin. Az adatok naprakészen tartása lesz a felelõssége.

USE [MyFleet]
CREATE ROLE [BulkAdmin]
ALTER AUTHORIZATION ON SCHEMA::[db_datawriter] TO [BulkAdmin]
GO

-- SecAdmin. A felhasználók megfelelõ jogait állítgató személy.

USE [MyFleet]
CREATE ROLE [SecAdmin]
ALTER AUTHORIZATION ON SCHEMA::[db_accessadmin] TO [SecAdmin]
GO
