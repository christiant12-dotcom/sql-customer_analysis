WITH order_table AS

(
SELECT TOP (1000) 
		DATENAME(YEAR,[OrderDate]) AS 'Year'
		,s.[SalesOrderID]
		,p.[ProductID]
       ,p.[Name]
      ,CAST([OrderDate] AS DATE) AS OrderDate
	  ,CAST([DueDate] AS DATE) AS DueDate
	  ,CAST([ShipDate] AS DATE) AS ShipDate
      ,[SalesOrderNumber]
      ,[PurchaseOrderNumber]
      ,[AccountNumber]
      ,s.[CustomerID]
	  ,c.[CompanyName]
      ,[ShipToAddressID]
      ,[BillToAddressID]
	  ,a.CountryRegion
      ,Coalesce([CreditCardApprovalCode],'Unknown') AS 'CreditCardApprovalCode'
	  ,d.OrderQty
	  ,d.UnitPrice
	  ,d.UnitPriceDiscount
	  ,(d.OrderQty*d.UnitPrice) AS Cost
	  ,LineTotal
      ,ROUND([SubTotal],2) AS SubTotal
      ,ROUND([TaxAmt],2) AS TaxAmt
      ,ROUND([Freight],2) AS Freight
      ,ROUND([TotalDue],2) AS TotalDue
  FROM [AdventureWorksLT2012].[SalesLT].[SalesOrderHeader] s
  LEFT JOIN AdventureWorksLT2012.SalesLT.Customer c
  ON s.CustomerID = c.CustomerID
  LEFT JOIN AdventureWorksLT2012.SalesLT.SalesOrderDetail d
  ON s.SalesOrderID = d.SalesOrderID
  LEFT JOIN AdventureWorksLT2012.SalesLT.Product p
  ON d.ProductID = p.ProductID
  LEFT JOIN AdventureWorksLT2012.[SalesLT].[CustomerAddress] ca
  ON c.CustomerID = ca.CustomerID
  LEFT JOIN AdventureWorksLT2012.[SalesLT].[Address] a
  ON ca.AddressID = a.AddressID
  
)
SELECT * FROM order_table

