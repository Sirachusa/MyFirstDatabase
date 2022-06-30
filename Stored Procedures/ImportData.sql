CREATE OR ALTER PROCEDURE dbo.DataImport

	@path varchar(100) = NULL,
	@toTable varchar(30) = NULL,
	@codePage varchar(10) = 65001,	-- vagy NULL, kliens esetén
	@firstRow varchar(10) = 2,		-- vagy NULL, kliens esetén
	@fieldTerm varchar(3) = ';',	-- vagy NULL, kliens esetén
	@rowTerm varchar(3) = '\n'		-- vagy NULL, kliens esetén

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