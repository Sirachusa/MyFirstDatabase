USE [MyFleet]
GO

-- Indexek újraépítése

CREATE OR ALTER PROCEDURE dbo.AllIndexRebuild
AS
	DECLARE curTable CURSOR FOR SELECT name FROM sys.tables
	DECLARE @name varchar(200), @S varchar(1000)
	OPEN curTable
	FETCH NEXT FROM curTable INTO @name
	WHILE @@FETCH_STATUS = 0
		BEGIN
			SET @S = 'ALTER INDEX ALL ON ' + @name + ' REBUILD'
			EXEC (@S)
			FETCH NEXT FROM curTable INTO @name
		END
	CLOSE curTable
	DEALLOCATE curTable

GO