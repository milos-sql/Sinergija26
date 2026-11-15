/****************************************************************************/
/*                       SQL Server Tuning Challenge                        */
/*                                                                          */
/****************************************************************************/
/*                              Lab 1 - Setup                               */
/****************************************************************************/
USE Lab;
GO

/*  stored proc for searching orders */
CREATE OR ALTER PROCEDURE dbo.GetOrders
@CustomerId INT = NULL, @OrderDate DATETIME = NULL
AS
BEGIN
    SELECT   TOP (10) *
    FROM     dbo.Orders
    WHERE    (CustomerId = @CustomerId OR @CustomerId IS NULL)
             AND (OrderDate = @OrderDate OR @OrderDate IS NULL)
    ORDER BY Amount DESC
END
GO

/*  Workload  */
CREATE OR ALTER PROCEDURE dbo.Workload1
AS
BEGIN
	EXEC dbo.GetOrders 567, NULL;
	EXEC dbo.GetOrders 456, NULL;
	EXEC dbo.GetOrders 123, NULL;
	EXEC dbo.GetOrders 9, NULL;
	EXEC dbo.GetOrders NULL,'20200401';
	EXEC dbo.GetOrders NULL,'20180401';
	EXEC dbo.GetOrders NULL,'20191111';
	EXEC dbo.GetOrders NULL,'20240401';
	EXEC dbo.GetOrders NULL, NULL;

	EXEC sp_recompile 'GetOrders';
	EXEC dbo.GetOrders NULL,'20200401';
	EXEC dbo.GetOrders NULL,'20180401';
	EXEC dbo.GetOrders NULL,'20191111';
	EXEC dbo.GetOrders NULL,'20240401';
	EXEC dbo.GetOrders 567, NULL;
	EXEC dbo.GetOrders 456, NULL;
	EXEC dbo.GetOrders 123, NULL;
	EXEC dbo.GetOrders 3456, NULL;

	EXEC sp_recompile 'GetOrders';
	EXEC dbo.GetOrders NULL,'20200401';
	EXEC dbo.GetOrders NULL,'20180401';
	EXEC dbo.GetOrders NULL,'20191111';
	EXEC dbo.GetOrders NULL,'20240401';
	EXEC dbo.GetOrders 567, NULL;
	EXEC dbo.GetOrders 456, NULL;
	EXEC dbo.GetOrders 123, NULL;
	EXEC dbo.GetOrders 3456, NULL;
END
GO

/*  ensure we are under SQL Server 2019  */
ALTER DATABASE CURRENT SET COMPATIBILITY_LEVEL = 150;
GO

