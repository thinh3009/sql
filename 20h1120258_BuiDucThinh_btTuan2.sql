use AdventureWorks2019
--1
select * from Sales.SalesOrderHeader
SELECT o.SalesOrderID, o.OrderDate, 
SUM(d.OrderQty * d.UnitPrice) AS SubTotal
FROM Sales.SalesOrderHeader o
JOIN Sales.SalesOrderDetail d 
ON o.SalesOrderID = d.SalesOrderID
WHERE YEAR(o.OrderDate) = 2008 AND MONTH(o.OrderDate)  = 6
GROUP BY o.SalesOrderID, o.OrderDate
HAVING SUM(d.OrderQty * d.UnitPrice) > 70000;


--2
Select c.TerritoryID, Count(c.CustomerID) AS CountOfCust, 
SUM(d.OrderQty * d.UnitPrice) AS SubTotal
from Sales.SalesTerritory t
Join Sales.Customer c on c.TerritoryID = t.TerritoryID
join Sales.SalesOrderHeader o on o.CustomerID = c.CustomerID
join Sales.SalesOrderDetail d ON d.SalesOrderID = o.SalesOrderID
Where t.CountryRegionCode = 'US'
GROUP BY c.TerritoryID


--3
select * from Sales.SalesOrderDetail
--select Sales.SalesOrderDetail.CarrierTrackingNumber from Sales.SalesOrderDetail
--where Sales.SalesOrderDetail.CarrierTrackingNumber like'4BD%'
select
SUM(OrderQty*UnitPrice) as SubTotal,
CarrierTrackingNumber,
SalesOrderID
from Sales.SalesOrderDetail 
where CarrierTrackingNumber like '4BD%'
group by CarrierTrackingNumber, SalesOrderID
--4
select * from Production.Product
select
p.ProductID,
p.[Name],
avg(p.ListPrice) as AverageOfQty
from Sales.SalesOrderDetail o
inner join Production.Product p
on p.ProductID=o.ProductID
where o.UnitPrice<25
group by p.ProductID,p.[Name]
having AVG(o.OrderQty) >5
--5
select JobTitle, count(BusinessEntityID) as CountofPerson
from HumanResources.Employee 
group by JobTitle
having COUNT(BusinessEntityID) > 20

--6
select v.BusinessEntityID, 
v.Name, 
ProductID, 
 SUM(OrderQty) as sumofQty, 
SUM(OrderQty * UnitPrice) as SubTotal 
from Purchasing.Vendor v 
join Purchasing.PurchaseOrderHeader h 
on h.VendorID = v.BusinessEntityID
join Purchasing.PurchaseOrderDetail d on h.PurchaseOrderID = d.PurchaseOrderID
where v.[Name] like '%Bicycles'
group by v.BusinessEntityID, v.Name, ProductID
having SUM(OrderQty * UnitPrice) > 800000	

--7
select p.ProductID, p.[Name], 
COUNT(o.SalesOrderID) as countofOrderID, 
sum(OrderQty * UnitPrice)  as Subtotal
from Production.Product p
join Sales.SalesOrderDetail o 
on p.ProductID = o.ProductID
join sales.SalesOrderHeader h 
on h.SalesOrderID = o.SalesOrderID
where Datepart(q, OrderDate) =1 and YEAR(OrderDate) = 2008
group by p.ProductID, p.[Name]
having sum(OrderQty * UnitPrice) > 10000 and COUNT(o.SalesOrderID) > 500


