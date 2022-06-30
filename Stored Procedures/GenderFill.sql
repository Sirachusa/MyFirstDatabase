CREATE OR ALTER PROCEDURE dbo.GenderFill

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