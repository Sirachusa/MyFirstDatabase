USE [MyFleet]
GO

-- 1.) Indexek újraépítése

CREATE OR ALTER PROCEDURE dbo.AllIndexRebuild
AS
	DECLARE curTable CURSOR FOR SELECT name FROM sys.tables
	DECLARE @name varchar(200), @S varchar(1000)
	OPEN curTable
	FETCH NEXT FROM curTable INTO @name
	WHILE @@FETCH_STATUS = 0
		BEGIN
			SET @S = 'ALTER INDEX ALL ON ' + @name + ' REBUILD'
			EXEC (@S)
			FETCH NEXT FROM curTable INTO @name
		END
	CLOSE curTable
	DEALLOCATE curTable

GO

-- 2.) Autó keresõ

CREATE OR ALTER PROCEDURE [dbo].[CarSearch]
		@Manufacturer varchar(30) = NULL, 
		@Type varchar (30) = NULL,
		@HP smallint = NULL,
		@HP2 smallint = NULL,
		@MotorType varchar(20) = NULL,
		@FuelType varchar(20) = NULL,
		@ListPrice int = NULL,
		@ListPrice2 int = NULL
AS

	SET NOCOUNT ON;

	DECLARE @Search table (Manufacturer varchar(30), [Type] varchar(30), HP smallint,
						MotorType varchar(20), FuelType varchar(20), Listprice int)

IF @Manufacturer IS NOT NULL
	INSERT @Search
	SELECT C.Manufacturer, C.Type, C.HP, C.MotorType, C.FuelType, C.ListPrice
	FROM dbo.Car C
	WHERE C.Manufacturer = @Manufacturer

ELSE IF @Type IS NOT NULL
	INSERT @Search
	SELECT C.Manufacturer, C.Type, C.HP, C.MotorType, C.FuelType, C.ListPrice
	FROM dbo.Car C
	WHERE C.Type = @Type

ELSE IF @HP IS NOT NULL
	INSERT @Search
	SELECT C.Manufacturer, C.Type, C.HP, C.MotorType, C.FuelType, C.ListPrice
	FROM dbo.Car C
	WHERE C.HP BETWEEN @HP AND @HP2

ELSE IF @FuelType IS NOT NULL
	INSERT @Search
	SELECT C.Manufacturer, C.Type, C.HP, C.MotorType, C.FuelType, C.ListPrice
	FROM dbo.Car C
	WHERE C.FuelType = @FuelType

ELSE IF @ListPrice IS NOT NULL AND @ListPrice2 IS NOT NULL
	INSERT @Search
	SELECT C.Manufacturer, C.Type, C.HP, C.MotorType, C.FuelType, C.ListPrice
	FROM dbo.Car C
	WHERE C.ListPrice BETWEEN @ListPrice AND @ListPrice2

ELSE IF @ListPrice IS NOT NULL AND @ListPrice IS NULL AND @ListPrice >= @ListPrice2
	INSERT @Search
	SELECT C.Manufacturer, C.Type, C.HP, C.MotorType, C.FuelType, C.ListPrice
	FROM dbo.Car C
	WHERE C.ListPrice < @ListPrice 

ELSE IF @ListPrice2 IS NOT NULL AND @ListPrice IS NULL AND @ListPrice2 >= @ListPrice
	INSERT @Search
	SELECT C.Manufacturer, C.Type, C.HP, C.MotorType, C.FuelType, C.ListPrice
	FROM dbo.Car C
	WHERE C.ListPrice < @ListPrice2 

ELSE 
	SELECT 'Nem adtál meg egyetlen értéket sem, kérlek pótold' AS 'Hibaüzenet'
GO


-- Ez forintra átalakított lenne, de valamiért a 10 millió alatti összegeket nagyobbnak tekinti rendezésnél,
-- mint a 10 millió felettieket.
/*
SELECT	S.Manufacturer, S.Type, S.HP, S.MotorType, S.FuelType,
		FORMAT(S.ListPrice, 'c', 'hu' ) ListPrice
FROM @Search S
ORDER BY 6
GO
*/


--  Tesztelés
/*
SELECT	S.Manufacturer, S.Type, S.HP, S.MotorType, S.FuelType, S.ListPrice
FROM @Search S
ORDER BY 6
GO
*/

/*

-- Tesztelés
EXEC dbo.carsearch @Manufacturer = toyota
EXEC dbo.carsearch 
*/


GO
-- 3.) GenderFill: Feltölti a Gender oszlopot, a megfelelõ értékkel, név alapján

CREATE OR ALTER PROCEDURE [dbo].[GenderFill]

AS

BEGIN
DROP TABLE IF EXISTS #Gend

SELECT Partner.PartnerID, dbo.GenderDetect(Partner.Firstname) Gender
INTO ##Gend
FROM dbo.Partner

UPDATE dbo.Partner	
	SET dbo.Partner.Gender = ##Gend.Gender
	FROM ##Gend
	WHERE dbo.Partner.PartnerID = ##Gend.PartnerID
END
GO

-- Teszt
EXEC dbo.GenderFill
GO

-- 4.) Adatok betöltése

CREATE OR ALTER PROCEDURE dbo.DataImport

	@path varchar(100) = NULL,
	@toTable varchar(30) = NULL,
	@codePage varchar(10) = 65001,	-- vagy NULL, kliens esetén
	@firstRow varchar(10) = 2,		-- vagy NULL, kliens esetén
	@fieldTerm varchar(3) = ';',	-- vagy NULL, kliens esetén
	@rowTerm varchar(3) = '\n'		-- vagy NULL, kliens esetén

AS

BEGIN
    SET NOCOUNT ON 
    IF OBJECT_ID(@toTable, 'U') IS NOT NULL
            BEGIN
                DECLARE @command varchar(300)
                SET @command = 'BULK INSERT ' + @toTable + ' FROM ''' + @path + '''
                WITH (
                    CODEPAGE = '+@codePage + ',
                    FIRSTROW = '+@firstRow + ',
                    FIELDTERMINATOR = ''' + @fieldTerm + ''',
                    ROWTERMINATOR = ''' + @rowTerm + '''
                    )'
                EXEC (@command)
            END
    ELSE RETURN 'THE TABLE DOES NOT EXISTS'
END
GO