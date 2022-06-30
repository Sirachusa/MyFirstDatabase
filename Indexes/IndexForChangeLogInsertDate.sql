-- Ha kíváncsiak vagyunk melyik napon történtek áremelkedések.

CREATE NONCLUSTERED INDEX [IX_CarPriceChangeLog_DayOfChanges] ON [dbo].[CarPriceChangeLog] (InsertDate)
GO
