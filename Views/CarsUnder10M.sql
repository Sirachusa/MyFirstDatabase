CREATE OR ALTER VIEW [CarsUnder10M] 
	AS
		SELECT C.Manufacturer, C.[Type], C.Model, C.Motor, C.HP, C.ProductYear, C.FuelType, C.MotorType, C.ListPrice
		FROM dbo.Car C
		WHERE C.ListPrice < 10000000
GO
