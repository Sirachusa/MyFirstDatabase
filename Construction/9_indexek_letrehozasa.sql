-- Indexek.
USE [MyFleet]
-- Gyártóra, ha valaki kocsit keres.

CREATE NONCLUSTERED INDEX [IX_Car_Manufacturer] ON [dbo].[Car] (Manufacturer)
GO

-- Városra, ha valaki lekérdezni, melyik városban van a legtöbb partner.

CREATE NONCLUSTERED INDEX [IX_Partner_City] ON [dbo].[Partner] (City)
GO

-- Szervíz eseményre, amikor meg kell nézni, hogy milyen szervíz fordul elõ a leggyakrabban.

CREATE NONCLUSTERED INDEX [IX_ServiceEvent_ServiceName] ON [dbo].[ServiceEvent] (ServiceEventName)
GO

-- Ha kíváncsiak vagyunk melyik napon történtek áremelkedések.

CREATE NONCLUSTERED INDEX [IX_CarPriceChangeLog_DayOfChanges] ON [dbo].[CarPriceChangeLog] (InsertDate)
GO

-- Filteres index a kreált view-hoz

CREATE NONCLUSTERED INDEX [IXF_ForCarsUnder10mView] ON [dbo].[Car] (ListPrice, MotorType)
		WHERE ListPrice < 10000000 AND MotorType = 'hybrid'
GO