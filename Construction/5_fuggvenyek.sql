USE [MyFleet]

-- Függvények 

-- 1. függvény : Automatikusan kiválasztja a partner nemét. (GenderDetect)

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE OR ALTER   FUNCTION [dbo].[GenderDetect]
	(@S varchar(100))
RETURNS tinyint
AS
BEGIN
	DECLARE @Gender tinyint
	IF @S = 'René' SET @Gender = 1
	ELSE IF @S IN ('Antigoné', 'Ariadné', 'Aténé', 'ené', 'Dafné', 'Röné') SET @Gender = 2
	ELSE IF RIGHT(@S,3) = 'éné'
		SELECT @Gender = 2 FROM DictFirstName WHERE FirstName = LEFT(@S,LEN(@S)-3)+'e' AND Gender = 1
	ELSE IF RIGHT(@S,3) = 'áné'
		SELECT @Gender = 2 FROM DictFirstName WHERE FirstName = LEFT(@S,LEN(@S)-3)+'a' AND Gender = 1
	ELSE IF RIGHT(@S,2) = 'né'
		SELECT @Gender = 2 FROM DictFirstName WHERE FirstName = LEFT(@S,LEN(@S)-2) AND Gender = 1
	ELSE 
		SELECT @Gender = Gender FROM DictFirstName WHERE FirstName = @S
	RETURN @Gender
END
GO
-- 2. függvény: Leírja magyar megfelelõséggel a számokat betûkkel.

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE OR ALTER FUNCTION [dbo].[Number3] (@N smallint) RETURNS varchar(1000) AS
		BEGIN
			IF @N = 0 RETURN NULL
			DECLARE @H varchar(50) = CHOOSE(@N/100,'egy', 'kettõ', 'három', 'négy', 
				'öt', 'hat', 'hét', 'nyolc', 'kilenc') + 'száz'
			DECLARE @T varchar(50) = CHOOSE((@N-@N/100*100)/10,'tíz', 'húsz', 'harminc', 
				'negyven', 'ötven', 'hatvan', 'hetven', 'nyolcvan', 'kilencven')
			DECLARE @E varchar(50) = CHOOSE(@N % 10,'egy', 'kettõ', 'három', 'négy', 
				'öt', 'hat', 'hét', 'nyolc', 'kilenc')
			IF @T = 'tíz' AND @E IS NOT NULL SET @T = 'tizen'
			ELSE IF @T = 'húsz' AND @E IS NOT NULL SET @T = 'huszon'
			RETURN ISNULL(@H,'') + ISNULL(@T,'') + ISNULL(@E,'')
		END
GO
-- 3. függvény: Figyelve a magyar helyesírásra , "kimondja" az ezer feletti összegeket.

CREATE   FUNCTION [dbo].[SayIt](@N int) RETURNS varchar(1000)	AS
		BEGIN
			DECLARE @NM smallint, @NK smallint, @NE smallint, @EM varchar(1000), 
				@EK varchar(1000), @EE varchar(1000), @E varchar(1000)
			IF @N = 0 RETURN 'Nulla'
			SET @NM = @N/1000000
			SET @NK = (@N - @NM*1000000)/1000
			SET @NE = @N - @NM*1000000 - @NK*1000
			SET @EM = ISNULL(dbo.Number3(@NM) + 'millió','')
			SET @EK = ISNULL(dbo.Number3(@NK) + 'ezer','')
			SET @EE = ISNULL(dbo.Number3(@NE),'')
			SET @E = @EM + IIF(@EM<>'' AND @EK<>'','-','') + @EK + 
				IIF(@N>2000 AND @EE<>'','-','') + @EE
			RETURN UPPER(LEFT(@E,1)) + SUBSTRING(@E,2,1000)
		END	
		GO