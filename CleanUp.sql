USE Lab;
GO
DECLARE @SQL NVARCHAR(MAX) = N'';

SELECT @SQL +=
    N'DROP PROCEDURE IF EXISTS '
    + QUOTENAME(SCHEMA_NAME(schema_id))
    + N'.' + QUOTENAME(name) + N';'
    + CHAR(13) + CHAR(10)
FROM sys.procedures
WHERE is_ms_shipped = 0;

PRINT @SQL;

-- Execute
--EXEC sys.sp_executesql @SQL;