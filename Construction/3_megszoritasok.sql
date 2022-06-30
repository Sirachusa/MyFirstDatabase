USE [MyFleet]

-- Az szállítási történet nem lehet jövõbeli idõpont, mert ez lényegében egy History tábla.
ALTER TABLE dbo.DeliveryEvent ADD CONSTRAINT CK_DeliveryEvent_DeliveryEventDate CHECK (DeliveryEventDate <=sysdatetime())

ALTER TABLE dbo.DeliveryEvent CHECK CONSTRAINT CK_DeliveryEvent_DeliveryEventDate
GO

-- A szállítási idõ nem lehet korábbi, mint maga a megrendelés.
ALTER TABLE dbo.Invoice ADD CONSTRAINT CK_Invoice_ShipDate CHECK (ShipDate <= OrderDate)

ALTER TABLE dbo.Invoice CHECK CONSTRAINT CK_Invoice_ShipDate
GO

-- Az e-mail címben szerepelnie kell @-nak és .-nak a megfelelõ sorrendben.
ALTER TABLE dbo.[Partner] ADD CONSTRAINT CK_Partner_Email CHECK (Email LIKE '%_@_%_._%' )

ALTER TABLE dbo.[Partner] CHECK CONSTRAINT CK_Partner_Email
GO

-- 18. életévét betöltötte-e már.
ALTER TABLE dbo.[Partner] ADD CONSTRAINT CK_Partner_BirthDate CHECK (DATEDIFF(year, BirthDate, GETDATE()) >= 18 )

ALTER TABLE dbo.[Partner] CHECK CONSTRAINT CK_Partner_BirthDate
GO

-- Ellenõrzi, hogy a Férfi vagy Nõ ( tudom nem túl PC, de így a legegyszerûbb.
ALTER TABLE dbo.DictFirstName ADD CONSTRAINT CK_DictFirstName_Gender CHECK (Gender=1 OR Gender=2)

ALTER TABLE dbo.DictFirstName CHECK CONSTRAINT CK_DictFirstName_Gender
GO

-- Az áfa kezdeti ideje nem lehet nagyobb, mint a lejárati ideje.
ALTER TABLE dbo.DictVAT ADD CONSTRAINT CK_DictVAT_Date CHECK (ToDate>FromDate)

ALTER TABLE dbo.DictVAT CHECK CONSTRAINT CK_DictVAT_Date
GO