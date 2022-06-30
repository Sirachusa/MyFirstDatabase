USE [MyFleet]

-- Az sz�ll�t�si t�rt�net nem lehet j�v�beli id�pont, mert ez l�nyeg�ben egy History t�bla.
ALTER TABLE dbo.DeliveryEvent ADD CONSTRAINT CK_DeliveryEvent_DeliveryEventDate CHECK (DeliveryEventDate <=sysdatetime())

ALTER TABLE dbo.DeliveryEvent CHECK CONSTRAINT CK_DeliveryEvent_DeliveryEventDate
GO

-- A sz�ll�t�si id� nem lehet kor�bbi, mint maga a megrendel�s.
ALTER TABLE dbo.Invoice ADD CONSTRAINT CK_Invoice_ShipDate CHECK (ShipDate <= OrderDate)

ALTER TABLE dbo.Invoice CHECK CONSTRAINT CK_Invoice_ShipDate
GO

-- Az e-mail c�mben szerepelnie kell @-nak �s .-nak a megfelel� sorrendben.
ALTER TABLE dbo.[Partner] ADD CONSTRAINT CK_Partner_Email CHECK (Email LIKE '%_@_%_._%' )

ALTER TABLE dbo.[Partner] CHECK CONSTRAINT CK_Partner_Email
GO

-- 18. �let�v�t bet�lt�tte-e m�r.
ALTER TABLE dbo.[Partner] ADD CONSTRAINT CK_Partner_BirthDate CHECK (DATEDIFF(year, BirthDate, GETDATE()) >= 18 )

ALTER TABLE dbo.[Partner] CHECK CONSTRAINT CK_Partner_BirthDate
GO

-- Ellen�rzi, hogy a F�rfi vagy N� ( tudom nem t�l PC, de �gy a legegyszer�bb.
ALTER TABLE dbo.DictFirstName ADD CONSTRAINT CK_DictFirstName_Gender CHECK (Gender=1 OR Gender=2)

ALTER TABLE dbo.DictFirstName CHECK CONSTRAINT CK_DictFirstName_Gender
GO

-- Az �fa kezdeti ideje nem lehet nagyobb, mint a lej�rati ideje.
ALTER TABLE dbo.DictVAT ADD CONSTRAINT CK_DictVAT_Date CHECK (ToDate>FromDate)

ALTER TABLE dbo.DictVAT CHECK CONSTRAINT CK_DictVAT_Date
GO