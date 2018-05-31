-- CHALLENGE 1 --
-- 1. product model descriptions
SELECT P.ProductID, P.Name AS ProductName, v.Name AS ProductModel, v.Summary
FROM SalesLT.Product AS p
JOIN SalesLT.vProductModelCatalogDescription AS v
ON p.ProductModelID = v.ProductModelID;

-- 2. Create a table of distinct colors
DECLARE @colors AS TABLE (Color nvarchar(15));

INSERT INTO @Colors
SELECT DISTINCT Color FROM SalesLT.Product;

SELECT ProductID, Name, Color
FROM SalesLT.Product
WHERE Color IN (SELECT Color FROM @Colors);

-- 3. Product parent categories
SELECT C.ParentProductCategoryName AS ParentCategory,
       C.ProductCategoryName AS Category,
       P.ProductID, P.Name AS ProductName
FROM SalesLT.Product AS P
JOIN dbo.ufnGetAllCategories() AS C
ON P.ProductCategoryID = C.ProductCategoryID;

-- CHALLENGE 2 --
-- 1. Sales revenue by customer and contact (CTE + fácil de entender)
WITH CustomerSales(CompanyContact, SalesAmount) -- Está creando una tabla con dos variables (CompanyContact y SalesAmount)
AS
(SELECT CONCAT(c.CompanyName, CONCAT(' (' + c.FirstName + ' ', c.LastName + ')')), SOH.TotalDue
 FROM SalesLT.SalesOrderHeader AS SOH
 JOIN SalesLT.Customer AS c
 ON SOH.CustomerID = c.CustomerID) -- Este es el contenido de la tabla, la primera variable es el nombre y la segunda los ingresos totales
SELECT CompanyContact, SUM(SalesAmount) AS Revenue -- Selecciona las dos variables de la tabla, haciendo sumatorio de la segunda
FROM CustomerSales -- Nombre de la tabla creada
GROUP BY CompanyContact
ORDER BY CompanyContact;

--- Otra forma (Derived Table = al anterior)
SELECT CompanyContact, SUM(SalesAmount) AS Revenue
FROM
	(SELECT CONCAT(c.CompanyName, CONCAT(' (' + c.FirstName + ' ', c.LastName + ')')), SOH.TotalDue
	 FROM SalesLT.SalesOrderHeader AS SOH
	 JOIN SalesLT.Customer AS c
	 ON SOH.CustomerID = c.CustomerID) AS CustomerSales(CompanyContact, SalesAmount) -- Aquí crea la tabla a la que se nombra sobre la marcha. A diferencia del anterior, no se crea primero la tabla y luego le hace una llamada, sino que se hace todo de una vez.
GROUP BY CompanyContact
ORDER BY CompanyContact;

