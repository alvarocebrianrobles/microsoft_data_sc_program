						-- CHALLENGE 1 --
-- 1. Product information (Se puede hacer mejor con el ROUND en vez de LEFT)
SELECT ProductID, UPPER (Name) ProducName, LEFT (Weight, 4) AS ApproxWeight
FROM SalesLT.Product;

-- 2. Year and month in which products were first sold
SELECT ProductID, 
	UPPER(Name) ProducName, 
	ROUND(Weight, 0) AS ApproxWeight,
	YEAR(SellStartDate) SellStartYear,
	DATENAME(mm, SellStartDate) SellStartMonth
FROM SalesLT.Product;

-- 3. Product type from product number
SELECT ProductID, 
	UPPER(Name) ProducName, 
	ROUND(Weight, 0) AS ApproxWeight,
	YEAR(SellStartDate) SellStartYear,
	DATENAME(mm, SellStartDate) SellStartMonth,
	LEFT(ProductNumber, 2) ProductType
FROM SalesLT.Product;

-- 4. Only products with numeric size
SELECT ProductID, 
	UPPER(Name) ProducName, 
	ROUND(Weight, 0) AS ApproxWeight,
	YEAR(SellStartDate) SellStartYear,
	DATENAME(mm, SellStartDate) SellStartMonth,
	LEFT(ProductNumber, 2) ProductType,
	Size
FROM SalesLT.Product
WHERE ISNUMERIC(Size)=1;

					-- CHALLENGE 2 --
-- 1. Company ranked by sales
SELECT c.CompanyName, soh.TotalDue, RANK () OVER (ORDER BY TotalDue DESC) RankByRevenue
FROM SalesLT.SalesOrderHeader AS soh
JOIN SalesLT.Customer AS c
ON c.CustomerID = soh.CustomerID;


					-- CHALLENGE 3 --
-- 1. Total sales by product
SELECT p.Name AS ProductName, SUM(sod.LineTotal) SumTotal
FROM SalesLT.SalesOrderDetail AS sod
JOIN SalesLT.Product AS p
ON p.ProductID=sod.ProductID
GROUP BY p.Name
ORDER BY SumTotal ASC;

-- 2. Filtering products cost>1000$
SELECT p.Name AS ProductName, SUM(sod.LineTotal) SumTotal
FROM SalesLT.SalesOrderDetail AS sod
JOIN SalesLT.Product AS p
ON p.ProductID=sod.ProductID
WHERE p.ListPrice>1000
GROUP BY p.Name
ORDER BY SumTotal ASC;


-- 3. Filtering products groups by total > 20000
SELECT p.Name AS ProductName, SUM(sod.LineTotal) SumTotal
FROM SalesLT.SalesOrderDetail AS sod
JOIN SalesLT.Product AS p
ON p.ProductID=sod.ProductID
GROUP BY p.Name
HAVING SUM(sod.LineTotal) > 20000;
ORDER BY SumTotal ASC;


