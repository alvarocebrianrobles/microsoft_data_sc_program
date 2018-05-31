-- CHALLENGE 1 --
-- 1. Instert a product
INSERT INTO SalesLT.Product (Name, ProductNumber, StandardCost, ListPrice, ProductCategoryID, SellStartDate)
VALUES ('LED Lights', 'LT-L123', 2.56, 12.99, 37, DATEADD(mi, 0, GETDATE()));

SELECT SCOPE_IDENTITY();

SELECT * FROM SalesLT.Product
WHERE ProductID = SCOPE_IDENTITY();

-- 2. Insert a new category with two products
INSERT INTO SalesLT.ProductCategory (ParentProductCategoryID, Name)
VALUES
(4, 'Bells and Horns');

INSERT INTO SalesLT.Product (Name, ProductNumber, StandardCost, ListPrice, ProductCategoryID, SellStartDate)
VALUES
('Bicycle Bell', 'BB-RING', 2.47, 4.99, IDENT_CURRENT('SalesLT.ProductCategory'), GETDATE()),
('Bicycle Horn', 'BH-PARP', 1.29, 3.75, IDENT_CURRENT('SalesLT.ProductCategory'), GETDATE());

SELECT c.Name AS Category, p.Name AS Product
FROM SalesLT.Product AS p
JOIN SalesLT.ProductCategory AS c ON p.ProductCategoryID = c.ProductCategoryID
WHERE p.ProductCategoryID = IDENT_CURRENT('SalesLT.ProductCategory');

-- CHALLENGE 2 --
-- 1. Update product prices
UPDATE SalesLT.Product 
SET ListPrice = ListPrice * 1.1
WHERE ProductCategoryID = (SELECT ProductCategoryID FROM SalesLT.ProductCategory WHERE Name = 'Bells and Horns');

-- 2. Discontinue products
UPDATE SalesLT.Product
SET DiscontinuedDate = GETDATE()
WHERE ProductCategoryID = 37
AND ProductNumber <> 'LT-L123'; 

-- CHALLENGE 3 --
-- 1. Delete a product category and its products
DELETE FROM SalesLT.Product
WHERE ProductCategoryID =
	(SELECT ProductCategoryID FROM SalesLT.ProductCategory WHERE Name = 'Bells and Horns');

DELETE FROM SalesLT.ProductCategory
WHERE ProductCategoryID =
	(SELECT ProductCategoryID FROM SalesLT.ProductCategory WHERE Name = 'Bells and Horns');
