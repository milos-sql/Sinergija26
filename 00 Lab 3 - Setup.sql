/****************************************************************************/
/*                       SQL Server Tuning Challenge                        */
/*                                                                          */
/****************************************************************************/
/*                              Lab 3 - Setup                               */
/****************************************************************************/
USE Lab3;
GO

/*  Workload  */
CREATE OR ALTER PROCEDURE dbo.Workload0
AS
BEGIN
	SELECT * FROM dbo.Orders WHERE ABS(CustomerId) = 688;
	
	SELECT TOP 10 * FROM dbo.Orders ORDER BY Id + 1 + 2;
	
	DECLARE @now DATETIME =  GETDATE();
	SELECT * FROM dbo.Events e
	INNER JOIN dbo.Orders o ON o.Id = e.Id
	WHERE EventDate >= @now;

	DECLARE @CustId INT = 726564;
	SELECT 
		Id,
		CustomerId,
		DATEADD(day, 7, OrderDate) AS ShipDate,
		YEAR(OrderDate) AS OrderYear,
		dbo.MyScalarFunctionToGetYear(OrderDate) AS OrderYear2,
		CAST(Amount AS DECIMAL(10,2)) AS Amount,
		Other,
		CASE WHEN Status = 1 THEN 'OK' ELSE 'Not OK' END AS StatusMessage
	FROM dbo.Orders 
	WHERE Custid = @CustId;
 
 
	DECLARE @current INT = 10000, @size INT = 10;
	SELECT * FROM dbo.Orders WHERE CustomerId >= @current 
	AND CustomerId < @current + @size;
	 
	SELECT c.CustomerId, c.CustomerName, o.Id, o.OrderDate, o.Amount 
	FROM dbo.Customers c
	INNER JOIN dbo.Orders o ON c.CustomerId = o.CustId
	WHERE c.CustomerId = CAST('688' AS INT);

	SELECT * FROM Orders WHERE Status IN (0, 3);

	SELECT * FROM dbo.Orders
	WHERE Other COLLATE SQL_Latin1_General_CP1_CS_AS = 'abc';

	DECLARE @d DATE = '2022-06-29 00:00:00.000';
	SELECT * FROM Orders
	WHERE ISNULL(DeliveryDate,'99991231') = ISNULL(@d ,'99991231');

END
GO

/*  ensure we are under SQL Server 2019  */
ALTER DATABASE CURRENT SET COMPATIBILITY_LEVEL = 150;
GO

