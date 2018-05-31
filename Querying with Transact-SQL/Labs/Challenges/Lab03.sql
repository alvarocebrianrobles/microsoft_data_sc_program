				-- CHALLENGE 1 --
-- 1. Customer Orders
SELECT c.CompanyName, oh.SalesOrderID, oh.TotalDue
FROM SalesLT.Customer AS c
JOIN SalesLT.SalesOrderHeader AS oh
ON c.CustomerID = oh.CustomerID;

-- 2. Customer Orders with address
SELECT c.CompanyName, oh.SalesOrderID, oh.TotalDue, ca.AddressType, a.AddressLine1, ISNULL (a.AddressLine2, '') AS AddressLine2, a.City, a.StateProvince, a.PostalCode, a.CountryRegion
FROM SalesLT.Customer AS c
JOIN SalesLT.SalesOrderHeader AS oh
ON c.CustomerID = oh.CustomerID
JOIN SalesLT.CustomerAddress AS ca
ON ca.CustomerID = c.CustomerID 
JOIN SalesLT.Address AS a
ON ca.AddressID = a.AddressID;

				-- CHALLENGE 2 --
-- 1. Customers and their orders
SELECT c.CompanyName, c.FirstName, c.LastName, oh.SalesOrderID, oh.TotalDue
FROM SalesLT.Customer AS c 
LEFT JOIN SalesLT.SalesOrderHeader AS oh
ON c.CustomerID = oh.CustomerID
ORDER BY oh.SalesOrderID DESC;

-- 2. Customer with no address
SELECT c.CustomerID, c.FirstName, c.LastName, c.Phone
FROM SalesLT.Customer AS c 
LEFT JOIN SalesLT.CustomerAddress AS ca 
ON c.CustomerID = ca.CustomerID
LEFT JOIN SalesLT.Address AS a 
ON a.AddressID = ca.AddressID
WHERE ca.AddressID IS NULL;

-- 3. Customers and products without orders
SELECT c.CustomerID, p.ProductID, od.SalesOrderID
FROM SalesLT.SalesOrderDetail AS od
FULL JOIN SalesLT.SalesOrderHeader AS oh
ON od.SalesOrderID = oh.SalesOrderID
FULL JOIN SalesLT.Customer AS c
ON c.CustomerID = oh.CustomerID
FULL JOIN SalesLT.Product AS p
ON p.ProductID = od.ProductID
WHERE od.SalesOrderID IS NULL
ORDER BY ProductID, CustomerID;
