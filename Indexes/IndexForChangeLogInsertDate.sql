-- Ha k�v�ncsiak vagyunk melyik napon t�rt�ntek �remelked�sek.

CREATE NONCLUSTERED INDEX [IX_CarPriceChangeLog_DayOfChanges] ON [dbo].[CarPriceChangeLog] (InsertDate)
GO
