SET NOCOUNT ON;
USE Lab;
/* 
    Ensure the Discard results after execution option is checked
*/
DECLARE @StartTime DATETIME2(7) = SYSDATETIME();
DECLARE @ElapsedMs BIGINT;
DECLARE @Message NVARCHAR(200);

EXEC dbo.Workload1;

SET @ElapsedMs = DATEDIFF_BIG(MICROSECOND, @StartTime, SYSDATETIME()) / 1000;

SET @Message = CONCAT(
    N'Workload elapsed time: ',
    @ElapsedMs,
    N' ms (',
    CAST(@ElapsedMs / 1000.0 AS DECIMAL(12,3)),
    N' seconds)'
);
RAISERROR(N'%s', 0, 1, @Message) WITH NOWAIT;