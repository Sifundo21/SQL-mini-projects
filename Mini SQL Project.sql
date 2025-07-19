 --Determining Bin Turn Over Rate, 
 --Average Price Mark-up & Correlation between the Two--


--Phase 1 Product Inventory Daily turn over rate--
SELECT *
FROM Production.ProductInventory

SELECT 
ProductID,
COUNT(*) AS  'Movement Count',
COUNT(DISTINCT CAST(MODIFIEDDATE AS date)) AS 'Active Days',
COUNT(*)*1.0/COUNT(DISTINCT CAST(MODIFIEDDATE AS date)) as 'Daily Turn Over Rate'
FROM
Production.ProductInventory
GROUP BY
ProductID 
ORDER BY
[Active Days] DESC

--Phase 2 Determining the average mark-up per Product--
SELECT*
FROM Production.Product

SELECT
ProductId,
DaystoManufacture,
AVG(ListPrice) as AvgListPrice,
AVG(StandardCost) as AvgStandardCost,
Avg(ListPrice)-Avg(StandardCost) as ' Avg Mark up'
FROM
Production.Product
GROUP BY 
ProductID,
DaysToManufacture
Order By
ProductID

--Phase 3 Product Bin movement via Mark-up Flanctuation--
SELECT
ppI.ProductID,
PP.Name,
COUNT(*) AS  'Movement Count',
COUNT(DISTINCT CAST(ppi.ModifiedDate AS date)) AS 'Active Days',
COUNT(*)*1.0/COUNT(DISTINCT CAST(ppi.ModifiedDate AS date)) as 'Daily Turn Over Rate',
Avg(pp.ListPrice)-Avg(pp.StandardCost)as 'Avg Mark-up'
FROM
Production.ProductInventory as PPI
JOIN
Production.Product as PP on PPI.ProductID=PP.ProductID
Group By 
PPI.ProductID,
PP.Name
Having
Avg(pp.ListPrice)-Avg(pp.StandardCost)>0










