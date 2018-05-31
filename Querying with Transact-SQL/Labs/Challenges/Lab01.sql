					-- CHALLENGE 01 -- 
-- 1. Customers Details
SELECT * FROM SalesLT.Customer;

-- 2. Customers Name Data
SELECT Title, FirstName, MiddleName, LastName, suffix
FROM SalesLT.Customer;

-- 3. Customers Name and Phone Numbers
SELECT SalesPerson, Title + ' ' + LastName AS CustomerName, Phone
FROM SalesLT.Customer;

					-- CHALLENGE 02 --
-- 1. List of Customer Companies
SELECT CAST(CustomerID AS nvarchar(30)) + ': ' + CompanyName AS CustomerCompany
FROM SalesLT.Customer

-- 2. List of Sales Order and Revisions
SELECT 
	SalesOrderNumber + '(' + CONVERT(varchar(5), RevisionNumber) + ')' AS SalesOrderRevision, 
	CONVERT (nvarchar(30), OrderDate, 102) AS ANSIOrderDate
FROM SalesLT.SalesOrderHeader;

					-- CHALLENGE 03 -- 
-- 1. Customer Contact Names 
SELECT FirstName + ' ' + ISNULL(MiddleName, '') + LastName AS ConctactName
FROM SalesLT.Customer;

-- 2. Primary Contact Detail
UPDATE SalesLT.Customer
SET EmailAddress = NULL
WHERE CustomerID % 7 = 1;

SELECT CustomerID, EmailAddress, Phone, COALESCE(EmailAddress, Phone) AS PrimaryContact
FROM SalesLT.Customer;

-- 3. Shipping Status
UPDATE SalesLT.SalesOrderHeader
SET ShipDate = NULL
WHERE SalesOrderID > 71899;

SELECT SalesOrderID, ShipDate,
	CASE 
		WHEN ShipDate IS NULL THEN 'Awaiting Shipment'
		ELSE 'Shipped'
	END AS ShippingStatus
FROM SalesLT.SalesOrderHeader;


