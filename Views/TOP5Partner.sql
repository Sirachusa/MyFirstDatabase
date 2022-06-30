-- Kikeresi a legtöbbet vásárolt partnereket és kiírja az adataikat, hogy fel lehessen velük venni a kapcsolatot, esetleg ajándékot küldeni nekik.

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
