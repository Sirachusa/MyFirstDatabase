USE [MyFleet]
GO

-- Update Trigger, ha módosítják a listaárat , beleírja a "ModifiedDate" táblába az aktuális idõt , plusz lenaplózza a ChangeLog-ba a változást.

CREATE OR ALTER TRIGGER dbo.trgCarPriceChange ON dbo.Car FOR UPDATE
	AS
			IF @@NESTLEVEL = 1   -- hátha át van állítva a rekurzív trigger 'True'-ra
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

-- Tesztelés (számottevõ változtatás nélkül)
UPDATE dbo.Car SET ListPrice *= 1 WHERE CarID = 1

SELECT * FROM dbo.CarPriceChangeLog