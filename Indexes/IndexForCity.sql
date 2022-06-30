-- Városra, ha valaki lekérdezni, melyik városban van a legtöbb partner.

CREATE NONCLUSTERED INDEX [IX_Partner_City] ON [dbo].[Partner] (City)
GO
