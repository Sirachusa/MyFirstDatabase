USE [MyFleet]

-- 1.) Az összes szervíz esemény lekérdezése
GO
CREATE OR ALTER VIEW [ServiceEvents] 
	AS
		SELECT C.Manufacturer, C.[Type], C.Model, SP.ServPointName, SP.ServPointPhone, ST.ServTypeName
		FROM dbo.ServiceEvent SE
		INNER JOIN dbo.Car C ON C.CarID = SE.CarID
		INNER JOIN dbo.ServPoint SP ON SP.ServPointID = SE.ServPointID
		INNER JOIN dbo.DictServType ST ON ST.ServTypeID = SE.ServTypeID
GO
-- 2.) 10 millió forint alatti autók lekérdezése

CREATE OR ALTER VIEW [CarsUnder10M] 
	AS
		SELECT C.Manufacturer, C.Model, C.Motor, C.HP, C.ProductYear, C.FuelType, C.MotorType, C.ListPrice
		FROM dbo.Car C
		WHERE C.ListPrice < 10000000
GO

-- 3.) A legtöbbet rendelt 5 partner, részletesen

CREATE OR ALTER VIEW [TOP5Partner]
	AS
		WITH X AS (	
			SELECT TOP 5 PO.PartnerID, COUNT(1) OrdersQty, MAX(PO.PartnerOrderID)PartnerOrderID
			FROM dbo.PartnerOrder PO
			GROUP BY PO.PartnerID
			ORDER BY 2 DESC )

	SELECT	P.PartnerID, 
			X.OrdersQty, 
			MAX(CONCAT(P.LastName, ' ', P.FirstName)) PartnerName, 
			MIN(P.BirthDate) BirthDate, 
			MIN(P.City) City, 
			MIN(P.Phone) PhoneNumber, 
			MIN(P.Email) 'E-mail'
	FROM X
	INNER JOIN dbo.PartnerOrder PO ON PO.PartnerOrderID = X.PartnerOrderID
	INNER JOIN dbo.[Partner] P ON P.PartnerID = X.PartnerID
	GROUP BY P.PartnerID, X.OrdersQty
