CREATE OR ALTER PROCEDURE [dbo].[CarSearch]
		@Manufacturer varchar(30) = NULL, 
		@Type varchar (30) = NULL,
		@HP smallint = NULL,
		@HP2 smallint = NULL,
		@FuelType varchar(20) = NULL,
		@ListPrice int = NULL,
		@ListPrice2 int = NULL
AS

	SET NOCOUNT ON;

	DECLARE @Search table (Manufacturer varchar(30), [Type] varchar(30), HP smallint,
						FuelType varchar(20), Listprice int)

IF @Manufacturer IS NOT NULL
	INSERT @Search
	SELECT C.Manufacturer, C.Type, C.HP, C.FuelType, C.ListPrice
	FROM dbo.Car C
	WHERE C.Manufacturer = @Manufacturer

ELSE IF @Type IS NOT NULL
	INSERT @Search
	SELECT C.Manufacturer, C.Type, C.HP, C.FuelType, C.ListPrice
	FROM dbo.Car C
	WHERE C.Type = @Type

ELSE IF @HP IS NOT NULL
	INSERT @Search
	SELECT C.Manufacturer, C.Type, C.HP, C.FuelType, C.ListPrice
	FROM dbo.Car C
	WHERE C.HP BETWEEN @HP AND @HP2

ELSE IF @FuelType IS NOT NULL
	INSERT @Search
	SELECT C.Manufacturer, C.Type, C.HP, C.FuelType, C.ListPrice
	FROM dbo.Car C
	WHERE C.FuelType = @FuelType

ELSE IF @ListPrice IS NOT NULL AND @ListPrice2 IS NOT NULL
	INSERT @Search
	SELECT C.Manufacturer, C.Type, C.HP, C.FuelType, C.ListPrice
	FROM dbo.Car C
	WHERE C.ListPrice BETWEEN @ListPrice AND @ListPrice2

ELSE IF @ListPrice IS NOT NULL AND @ListPrice IS NULL AND @ListPrice >= @ListPrice2
	INSERT @Search
	SELECT C.Manufacturer, C.Type, C.HP, C.FuelType, C.ListPrice
	FROM dbo.Car C
	WHERE C.ListPrice < @ListPrice 

ELSE IF @ListPrice2 IS NOT NULL AND @ListPrice IS NULL AND @ListPrice2 >= @ListPrice
	INSERT @Search
	SELECT C.Manufacturer, C.Type, C.HP, C.FuelType, C.ListPrice
	FROM dbo.Car C
	WHERE C.ListPrice < @ListPrice2 

ELSE 
	SELECT 'Nem adtál meg egyetlen értéket sem, kérlek pótold' AS 'Hibaüzenet'
/*
SELECT	S.Manufacturer, S.Type, S.HP, S.FuelType, 
		FORMAT(S.ListPrice, 'c', 'hu' ) ListPrice
FROM @Search S
ORDER BY 5
GO
*/
SELECT	S.Manufacturer, S.Type, S.HP, S.FuelType, 
		S.ListPrice
FROM @Search S
ORDER BY 5
GO