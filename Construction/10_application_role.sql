USE [MyFleet]
GO
-- Role létrehozása.
CREATE APPLICATION ROLE [PowerBI] WITH DEFAULT_SCHEMA = [dbo], PASSWORD = N'Pa55w.rd'
GO

-- Engedélyek: Select a view-okra és Deny update-ra, insert-re és delete-re.
GRANT SELECT ON [dbo].[CarsUnder10M] TO [PowerBI]
GO
DENY DELETE ON [dbo].[CarsUnder10M] TO [PowerBI]
GO
DENY INSERT ON [dbo].[CarsUnder10M] TO [PowerBI]
GO
DENY UPDATE ON [dbo].[CarsUnder10M] TO [PowerBI]
GO
GRANT SELECT ON [dbo].[TOP5Partner] TO [PowerBI]
GO
DENY DELETE ON [dbo].[TOP5Partner] TO [PowerBI]
GO
DENY INSERT ON [dbo].[TOP5Partner] TO [PowerBI]
GO
DENY UPDATE ON [dbo].[TOP5Partner] TO [PowerBI]
GO
GRANT SELECT ON [dbo].[ServiceEvents] TO [PowerBI]
GO
DENY DELETE ON [dbo].[ServiceEvents] TO [PowerBI]
GO
DENY INSERT ON [dbo].[ServiceEvents] TO [PowerBI]
GO
DENY UPDATE ON [dbo].[ServiceEvents] TO [PowerBI]
GO
