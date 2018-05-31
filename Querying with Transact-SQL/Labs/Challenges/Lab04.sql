					-- CHALLENGE 1 --
-- 1. Billing address
SELECT c.CompanyName, a.AddressLine1, a.City, ca.AddressType AS 'Billing'
FROM SalesLT.Customer AS c
JOIN SalesLT.CustomerAddress AS ca
ON c.CustomerID = ca.CustomerID
JOIN SalesLT.Address AS a
ON ca.AddressID = a.AddressID
WHERE ca.AddressType = 'Main Office';

-- 2. Shipping Address
SELECT c.CompanyName, a.AddressLine1, a.City, ca.AddressType AS 'Billing'
FROM SalesLT.Customer AS c
JOIN SalesLT.CustomerAddress AS ca
ON c.CustomerID = ca.CustomerID
JOIN SalesLT.Address AS a
ON ca.AddressID = a.AddressID
WHERE ca.AddressType = 'Shipping';

-- 3. Combining two queries
SELECT c.CompanyName, a.AddressLine1, a.City, ca.AddressType AS 'Billing'
FROM SalesLT.Customer AS c
JOIN SalesLT.CustomerAddress AS ca
ON c.CustomerID = ca.CustomerID
JOIN SalesLT.Address AS a
ON ca.AddressID = a.AddressID
WHERE ca.AddressType = 'Main Office'
UNION ALL
SELECT c.CompanyName, a.AddressLine1, a.City, ca.AddressType AS 'Billing'
FROM SalesLT.Customer AS c
JOIN SalesLT.CustomerAddress AS ca
ON c.CustomerID = ca.CustomerID
JOIN SalesLT.Address AS a
ON ca.AddressID = a.AddressID
WHERE ca.AddressType = 'Shipping'
ORDER BY c.CompanyName, ca.AddressType;


					-- CHALLENGE 2 -- 
-- 1. Customer with only a main office
SELECT c.CompanyName
FROM SalesLT.Customer AS c
JOIN SalesLT.CustomerAddress AS ca
ON c.CustomerID = ca.CustomerID
WHERE ca.AddressType = 'Main Office'
EXCEPT
SELECT c.CompanyName
FROM SalesLT.Customer AS c
JOIN SalesLT.CustomerAddress AS ca
ON c.CustomerID = ca.CustomerID
WHERE ca.AddressType = 'Shipping'
ORDER BY c.CompanyName;

-- 2. Customer with both main office and shipping
SELECT c.CompanyName
FROM SalesLT.Customer AS c
JOIN SalesLT.CustomerAddress AS ca
ON c.CustomerID = ca.CustomerID
WHERE ca.AddressType = 'Main Office'
INTERSECT
SELECT c.CompanyName
FROM SalesLT.Customer AS c
JOIN SalesLT.CustomerAddress AS ca
ON c.CustomerID = ca.CustomerID
WHERE ca.AddressType = 'Shipping'
ORDER BY c.CompanyName;


