-- Szerv�z esem�nyre, amikor meg kell n�zni, hogy milyen szerv�z fordul el� a leggyakrabban.

CREATE NONCLUSTERED INDEX [IX_ServiceEvent_ServiceName] ON [dbo].[ServiceEvent] (ServiceEventName)
GO
