-- Szervíz eseményre, amikor meg kell nézni, hogy milyen szervíz fordul elõ a leggyakrabban.

CREATE NONCLUSTERED INDEX [IX_ServiceEvent_ServiceName] ON [dbo].[ServiceEvent] (ServiceEventName)
GO
