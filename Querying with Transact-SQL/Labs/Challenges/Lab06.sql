-- CHALLENGE 1 --
-- 1. List price higher than the average unit price
SELECT ProductID, Name, Listprice
FROM SalesLT.Product
WHERE Listprice > (SELECT AVG (UnitPrice) FROM SalesLT.SalesOrderDetail);

-- 2. List price of 100$ or more that have been sold for less than 100$
SELECT p.ProductID, Name, Listprice, UnitPrice
FROM SalesLT.Product AS p
JOIN SalesLT.SalesOrderDetail AS sod
ON p.ProductID = sod.ProductID
WHERE p.ProductID IN (
    SELECT ProductID FROM SalesLT.SalesOrderDetail
    WHERE Unitprice < 100 AND Listprice >= 100)
ORDER BY p.ProductID;

-- 3. Cost, list price, and average selling price for each product
SELECT ProductID, Name, StandardCost, Listprice, (SELECT AVG (UnitPrice) FROM SalesLT.SalesOrderDetail AS sod
                                                    WHERE p.ProductID = sod.ProductID) AS AverageSellingPrice
FROM SalesLT.Product AS p
ORDER BY p.ProductID;

-- 4. Products that have an average selling price that is lower than the cost
SELECT ProductID, Name, StandardCost, Listprice, 
    (SELECT AVG (UnitPrice) FROM SalesLT.SalesOrderDetail AS sod
     WHERE p.ProductID = sod.ProductID) AS AverageSellingPrice
FROM SalesLT.Product AS p
WHERE StandardCost > (SELECT AVG (UnitPrice) FROM SalesLT.SalesOrderDetail AS sod
     WHERE p.ProductID = sod.ProductID)
ORDER BY p.ProductID;

-- CHALLENGE 2 --
-- 1. customer information for all sales orders
SELECT SOH.SalesOrderID, SOH.CustomerID, CI.FirstName, CI.LastName, SOH.TotalDue
FROM SalesLT.SalesOrderHeader AS SOH
CROSS APPLY dbo.ufnGetCustomerInformation(SOH.CustomerID) AS CI
ORDER BY SOH.SalesOrderID;

-- 2. customer address information
SELECT CA.CustomerID, CI.FirstName, CI.LastName, A.AddressLine1, A.City
FROM SalesLT.Address AS A
JOIN SalesLT.CustomerAddress AS CA
ON A.AddressID = CA.AddressID
CROSS APPLY dbo.ufnGetCustomerInformation(CA.CustomerID) AS CI
ORDER BY CA.CustomerID;