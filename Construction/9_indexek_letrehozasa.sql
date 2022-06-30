-- Indexek.
USE [MyFleet]
-- Gy�rt�ra, ha valaki kocsit keres.

CREATE NONCLUSTERED INDEX [IX_Car_Manufacturer] ON [dbo].[Car] (Manufacturer)
GO

-- V�rosra, ha valaki lek�rdezni, melyik v�rosban van a legt�bb partner.

CREATE NONCLUSTERED INDEX [IX_Partner_City] ON [dbo].[Partner] (City)
GO

-- Szerv�z esem�nyre, amikor meg kell n�zni, hogy milyen szerv�z fordul el� a leggyakrabban.

CREATE NONCLUSTERED INDEX [IX_ServiceEvent_ServiceName] ON [dbo].[ServiceEvent] (ServiceEventName)
GO

-- Ha k�v�ncsiak vagyunk melyik napon t�rt�ntek �remelked�sek.

CREATE NONCLUSTERED INDEX [IX_CarPriceChangeLog_DayOfChanges] ON [dbo].[CarPriceChangeLog] (InsertDate)
GO

-- Filteres index a kre�lt view-hoz

CREATE NONCLUSTERED INDEX [IXF_ForCarsUnder10mView] ON [dbo].[Car] (ListPrice, MotorType)
		WHERE ListPrice < 10000000 AND MotorType = 'hybrid'
GO