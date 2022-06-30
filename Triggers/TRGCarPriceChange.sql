USE [MyFleet]
GO

-- Update Trigger, ha m�dos�tj�k a lista�rat , bele�rja a "ModifiedDate" t�bl�ba az aktu�lis id�t , plusz lenapl�zza a ChangeLog-ba a v�ltoz�st.

CREATE OR ALTER TRIGGER dbo.trgCarPriceChange ON dbo.Car FOR UPDATE
	AS
			IF @@NESTLEVEL = 1   -- h�tha �t van �ll�tva a rekurz�v trigger 'True'-ra
	BEGIN
		SET NOCOUNT ON;
			INSERT dbo.CarPriceChangeLog (CarID, OldPrice, NewPrice, DMLAction)
			SELECT I.CarID, D.ListPrice, I.ListPrice, 'UPDATE'
			FROM inserted I
			INNER JOIN deleted D ON i.CarID = D.CarID
			UPDATE dbo.Car
			SET ModifiedDate = SYSDATETIME()
			FROM inserted I
			INNER JOIN dbo.Car C ON I.CarID = C.CarID
	END
GO

-- Tesztel�s (sz�mottev� v�ltoztat�s n�lk�l)
UPDATE dbo.Car SET ListPrice *= 1 WHERE CarID = 1

SELECT * FROM dbo.CarPriceChangeLog