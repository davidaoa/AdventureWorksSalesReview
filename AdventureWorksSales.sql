USE AdventureWorks2017

/* ANNUAL SALES REVIEW */

SELECT *
FROM Sales.SalesOrderDetail

/*
There are over 60,000 sale orders that do not have tracking numbers. It can be concluded that these sales were most likely bought/picked up in store and not 
ordered online or shipped to the buyers' address.
I'll need to create separate tables to distinguish the orders that were ordered vs bought in store
*/


SELECT *
INTO Sales.SalesDelivery
FROM Sales.SalesOrderDetail
	WHERE CarrierTrackingNumber IS NULL

SELECT *
INTO Sales.SalesInStore
FROM Sales.SalesOrderDetail
	WHERE CarrierTrackingNumber IS NOT NULL

SELECT *
FROM Sales.SalesDelivery

/* 
How many products were sold online compared to bought in store and what were their sales totals? 
*/

SELECT COUNT(*)
FROM Sales.SalesDelivery

SELECT COUNT(*)
FROM Sales.SalesInStore

SELECT SUM(LineTotal) AS TotalDelSales
FROM Sales.SalesDelivery

SELECT SUM(LineTotal) AS TotalStoreSales
FROM Sales.SalesInStore

SELECT SUM(LineTotal)
FROM Sales.SalesOrderDetail

/*
60,398 products were sold through delivery totaling $29,358,677.22 and 60,919 were sold in store totaling $80,487,704.18. 
The total amount of sales for the year was $109,846,381.40.
*/

/*
AdventureWorks wants to know which territories performed the best this year and which ones were the worst?
How much did they bring in?
*/

SELECT *
FROM Sales.SalesTerritory
ORDER BY SalesYTD DESC

/*
Southwest US (Territory ID = 4) was the best performing territory bringing in $10,510,853.87 which is about 195% higher than their total sales 
from the previous year. Northeast US (TerritoryID = 2) had the least sales YTD with approximately $2,402,176.85, a 66% significant decrease from 
their sales from the previous year.
*/


/* What was the most sold product for the year */


SELECT *
FROM Sales.SalesOrderDetail


SELECT DISTINCT(ProductID)
FROM Sales.SalesOrderDetail

SELECT ProductID, COUNT (ProductID) AS ProdOrderCt
FROM Sales.SalesOrderDetail
GROUP BY ProductID
ORDER BY ProdOrderCt DESC

SELECT *
FROM Production.Product
WHERE ProductID = 870


SELECT salord.ProductID, prod.Name, salord.UnitPrice, prod.ListPrice, salord.OrderQty, salord.LineTotal, prod.StandardCost
INTO Profit_Margin
FROM Sales.SalesOrderDetail salord
FULL OUTER JOIN Production.Product prod
ON salord.ProductID = prod.ProductID

SELECT SUM(OrderQty) AS TotalOrders870
FROM Profit_Margin
WHERE ProductID = 870
GROUP BY ProductID

SELECT *
FROM Profit_Margin
WHERE ProductID = 870


/*
Out of the different products sold, the most sold product for the year was Water Bottle - 30 oz (Product ID = 870) with 6,815 units sold. 
*/

/* 
What was the worst performing product for the year?
*/

SELECT ProductID, COUNT (ProductID) AS ProdOrderCt
FROM Sales.SalesOrderDetail
GROUP BY ProductID
ORDER BY ProdOrderCt 


SELECT SUM(OrderQty)
FROM Profit_Margin
WHERE ProductID = 897

SELECT *
FROM Profit_Margin
WHERE ProductID = 897



/*
The product with the least number of sales was the LL Touring Frame (Product ID = 897) with only 4 units sold for the entire year. 
It's price of $333.42 is most likely a factor even though it's cost per unit is $199.85, it's stock level is 500. Therefore it would probably be 
a good idea to discontinue it in order to avoid losing more money.
*/