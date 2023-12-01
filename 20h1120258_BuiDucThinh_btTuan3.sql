select  * from Production.Product
select * from Sales.SalesOrderDetail
select * from Sales.SalesOrderHeader
---------------------------------------------------------------------------------
--1
select p.[Name], p.ProductID from Production.Product p
inner join Sales.SalesOrderDetail s
on s.ProductID=p.ProductID
inner join Sales.SalesOrderHeader h
on s.SalesOrderID=h.SalesOrderID
where YEAR(h.OrderDate) =2013 and MONTH(h.OrderDate)=07
group by p.ProductID,p.[Name] having count(p.ProductID) >100

--2
select MAX(y.pro) as tong
from (select COUNT(p.ProductID) as pro from Production.Product p
inner join Sales.SalesOrderDetail d
on p.ProductID=d.ProductID
inner join Sales.SalesOrderHeader h
on h.SalesOrderID=d.SalesOrderID
where YEAR(h.OrderDate) =2013 and MONTH(h.OrderDate)=07
group by p.[Name], p.ProductID) y;
--3
select * from Sales.SalesOrderDetail
select * from Sales.SalesOrderHeader
select * from Sales.Store


select MAX(co.cus) cusID from (
	select o.SalesOrderID ,o.CustomerID ,COUNT(s.[Name]) as cus from Sales.SalesOrderHeader o
	inner join Sales.Store s
	on s.SalesPersonID=o.SalesPersonID
	group by o.CustomerID,o.SalesOrderID
) as co

--4
select *from Production.Product 
select * from Production.ProductModel 




select p.ProductID,p.[name] from Production.Product p 
WHERE exists 
(select m.ProductModelID,m.[name] from Production.ProductModel m
where m.[name] like ( 'Long-Sleeve Logo Jersey') )

select ProductID, Name
from Production.Product 
where ProductModelID in (select ProductModelID 
						 from Production.ProductModel
						 where Name like 'Long-Sleeve Logo Jersey%')

--5
select avg(p.ListPrice),m.ProductModelID from Production.ProductModel m
inner join Production.Product p
on p.ProductID=m.ProductModelID
group by m.ProductModelID 


--6
select * from Production.Product
select * from Sales.SalesOrderDetail

select p.ProductID,p.[Name] from Production.Product p
where p.ProductID  in (select o.ProductID from Sales.SalesOrderDetail o
									group by o.ProductID
									having sum(o.OrderQty) >5000)--tong so don dat hang
--7

select distinct ProductID, UnitPrice
from Sales.SalesOrderDetail
where UnitPrice>=all (select distinct UnitPrice
					 from Sales.SalesOrderDetail)
