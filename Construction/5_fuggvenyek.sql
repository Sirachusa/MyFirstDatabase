USE [MyFleet]

-- F�ggv�nyek 

-- 1. f�ggv�ny : Automatikusan kiv�lasztja a partner nem�t. (GenderDetect)

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
	IF @S = 'Ren�' SET @Gender = 1
	ELSE IF @S IN ('Antigon�', 'Ariadn�', 'At�n�', 'en�', 'Dafn�', 'R�n�') SET @Gender = 2
	ELSE IF RIGHT(@S,3) = '�n�'
		SELECT @Gender = 2 FROM DictFirstName WHERE FirstName = LEFT(@S,LEN(@S)-3)+'e' AND Gender = 1
	ELSE IF RIGHT(@S,3) = '�n�'
		SELECT @Gender = 2 FROM DictFirstName WHERE FirstName = LEFT(@S,LEN(@S)-3)+'a' AND Gender = 1
	ELSE IF RIGHT(@S,2) = 'n�'
		SELECT @Gender = 2 FROM DictFirstName WHERE FirstName = LEFT(@S,LEN(@S)-2) AND Gender = 1
	ELSE 
		SELECT @Gender = Gender FROM DictFirstName WHERE FirstName = @S
	RETURN @Gender
END
GO
-- 2. f�ggv�ny: Le�rja magyar megfelel�s�ggel a sz�mokat bet�kkel.

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE OR ALTER FUNCTION [dbo].[Number3] (@N smallint) RETURNS varchar(1000) AS
		BEGIN
			IF @N = 0 RETURN NULL
			DECLARE @H varchar(50) = CHOOSE(@N/100,'egy', 'kett�', 'h�rom', 'n�gy', 
				'�t', 'hat', 'h�t', 'nyolc', 'kilenc') + 'sz�z'
			DECLARE @T varchar(50) = CHOOSE((@N-@N/100*100)/10,'t�z', 'h�sz', 'harminc', 
				'negyven', '�tven', 'hatvan', 'hetven', 'nyolcvan', 'kilencven')
			DECLARE @E varchar(50) = CHOOSE(@N % 10,'egy', 'kett�', 'h�rom', 'n�gy', 
				'�t', 'hat', 'h�t', 'nyolc', 'kilenc')
			IF @T = 't�z' AND @E IS NOT NULL SET @T = 'tizen'
			ELSE IF @T = 'h�sz' AND @E IS NOT NULL SET @T = 'huszon'
			RETURN ISNULL(@H,'') + ISNULL(@T,'') + ISNULL(@E,'')
		END
GO
-- 3. f�ggv�ny: Figyelve a magyar helyes�r�sra , "kimondja" az ezer feletti �sszegeket.

CREATE   FUNCTION [dbo].[SayIt](@N int) RETURNS varchar(1000)	AS
		BEGIN
			DECLARE @NM smallint, @NK smallint, @NE smallint, @EM varchar(1000), 
				@EK varchar(1000), @EE varchar(1000), @E varchar(1000)
			IF @N = 0 RETURN 'Nulla'
			SET @NM = @N/1000000
			SET @NK = (@N - @NM*1000000)/1000
			SET @NE = @N - @NM*1000000 - @NK*1000
			SET @EM = ISNULL(dbo.Number3(@NM) + 'milli�','')
			SET @EK = ISNULL(dbo.Number3(@NK) + 'ezer','')
			SET @EE = ISNULL(dbo.Number3(@NE),'')
			SET @E = @EM + IIF(@EM<>'' AND @EK<>'','-','') + @EK + 
				IIF(@N>2000 AND @EE<>'','-','') + @EE
			RETURN UPPER(LEFT(@E,1)) + SUBSTRING(@E,2,1000)
		END	
		GO