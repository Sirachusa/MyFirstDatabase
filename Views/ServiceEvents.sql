-- 1.) Az �sszes szerv�z esem�ny lek�rdez�se

CREATE OR ALTER VIEW [ServiceEvents] 
	AS
		SELECT C.Manufacturer, C.[Type], C.Model, SP.ServPointName, SP.ServPointPhone, ST.ServTypeName
		FROM dbo.ServiceEvent SE
		INNER JOIN dbo.Car C ON C.CarID = SE.CarID
		INNER JOIN dbo.ServPoint SP ON SP.ServPointID = SE.ServPointID
		INNER JOIN dbo.DictServType ST ON ST.ServTypeID = SE.ServTypeID
GO