					-- CHALLENGE 1 --	
-- 1. List of cities
SELECT DISTINCT City, StateProvince
FROM SalesLT.Address;

-- 2. Heaviest Products
SELECT TOP 10 PERCENT Name, Weight
FROM SalesLT.Product
ORDER BY Weight DESC;

-- 3. 100 Heaviest Products without heaviest 10
SELECT Name, Weight
FROM SalesLT.Product
ORDER BY Weight DESC
OFFSET 10 ROWS FETCH FIRST 100 ROWS ONLY;

					-- CHALLENGE 2 --
-- 1. Product detail for product model 1
SELECT Name, Color, Size, ProductModelID
FROM SalesLT.Product
WHERE ProductModelID = 1;

-- 2. Filter products by color and size [HAY UNA SOLUCIÓN MÁS SIMPLE. Ver solución Lab02]
SELECT ProductNumber, Name, Color, Size
FROM SalesLT.Product
WHERE (Color = 'black' OR Color = 'red' OR Color = 'white') AND (Size = 'S' OR Size = 'M');

-- 3.[SalesLT].[Product].[SellEndDate] Filter products by product number
SELECT ProductNumber, Name, ListPrice
FROM SalesLT.Product 
WHERE ProductNumber LIKE 'BK%';

-- 4. Specific products by product number 
SELECT ProductNumber, Name, ListPrice
FROM SalesLT.Product 
WHERE ProductNumber LIKE 'BK_[^R]%-[0-9][0-9]';

