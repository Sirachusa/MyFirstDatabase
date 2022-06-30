CREATE OR ALTER PROCEDURE dbo.DataImport

	@path varchar(100) = NULL,
	@toTable varchar(30) = NULL,
	@codePage varchar(10) = 65001,	-- vagy NULL, kliens eset�n
	@firstRow varchar(10) = 2,		-- vagy NULL, kliens eset�n
	@fieldTerm varchar(3) = ';',	-- vagy NULL, kliens eset�n
	@rowTerm varchar(3) = '\n'		-- vagy NULL, kliens eset�n

AS

BEGIN
    SET NOCOUNT ON 
    IF OBJECT_ID(@toTable, 'U') IS NOT NULL
            BEGIN
                DECLARE @command varchar(300)
                SET @command = 'BULK INSERT ' + @toTable + ' FROM ''' + @path + '''
                WITH (
                    CODEPAGE = '+@codePage + ',
                    FIRSTROW = '+@firstRow + ',
                    FIELDTERMINATOR = ''' + @fieldTerm + ''',
                    ROWTERMINATOR = ''' + @rowTerm + '''
                    )'
                EXEC (@command)
            END
    ELSE RETURN 'THE TABLE DOES NOT EXISTS'
END
GO