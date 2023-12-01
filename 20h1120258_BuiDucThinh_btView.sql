use AdventureWorks2017
--cau1
create view vw_products 
as
select p.ProductID, p.[Name], p.Color, p.Size,p.Style,p.StandardCost,c.EndDate,c.StartDate from Production.Product p 
inner join Production.ProductCostHistory c
on p.ProductID=c.ProductID

--select view
select * from vw_products
--huy view
drop view vw_products
--cau2
alter view list_product_view 
as
select p.ProductID,p.[Name], countofOrderID= count(*),Subtotal=sum([OrderQty]*[UnitPrice]) 
from Production.Product p 
inner join Sales.SalesOrderDetail d on p.ProductID=d.ProductID
inner join Sales.SalesOrderHeader h on h.SalesOrderID = d.SalesOrderID
where datepart(q, [OrderDate])=1 and YEAR([OrderDate])=2014
group by p.[ProductID], p.[Name] 
having sum([OrderQty]*[UnitPrice])>10000 and count(*)>500
--select view
select * from list_product_view
--drop view
drop view list_product_view
--cau3
create view list_Product_VIEW 
as 
select p.ProductID,p.[Name],sumoforderID=sum(d.OrderQty),YEAR(p.SellEndDate) as nam from Production.Product p
inner join Sales.SalesOrderDetail d on p.ProductID=d.ProductID
inner join Sales.SalesOrderHeader h on h.SalesOrderID=d.SalesOrderID
where p.[Name] like 'bike%' or p.[name] like 'sport%'
group by YEAR(p.SellEndDate),p.ProductID,p.Name
having SUM(d.OrderQty)>50
drop view list_Product_VIEW

select * from list_Product_VIEW 
select * from Production.Product
select * from Sales.SalesOrderDetail
select * from Sales.SalesOrderHeader
--cau4
create view view_Department as

select hrd.DepartmentID, hrd.Name, hrd.GroupName

from [HumanResources].[Department] as hrd

where GroupName='Manufacturing' or GroupName='Quality Assurance'

WITH CHECK OPTION
go
-- Kiểm tra kết quả
select * from view_Department
-- huỷ view
drop view view_Department
go
-- a. Chèn thêm một phòng ban mới thuộc nhóm không thuộc hai nhóm
-- “Manufacturing” và “Quality Assurance” thông qua view vừa tạo. Có
-- chèn được không? Giải thích.

insert view_Department values( 'nhan su', 'a')
-- không chèn được vì thuộc tính with check option kiểm tra không cho chèn
select *from [HumanResources].[Department]
-- b. Chèn thêm một phòng mới thuộc nhóm “Manufacturing” và một
-- phòng thuộc nhóm “Quality Assurance”.
insert view_Department values( 'nhan su', 'Manufacturing'),
                            ('nhan su 2', 'Quality Assurance')
-- chèn thành công
-- c. Dùng câu lệnh Select xem kết quả trong bảng Department.
select *from [HumanResources].[Department]

use DA
select * from ChiTietDatHang
select * from DonDatHang 

insert into ChiTietDatHang(MaDH,TenSp,SL) values (126,'thuoc la',5)
select d.MaDH from DonDatHang d inner join ChiTietDatHang c on d.MaDH=c.MaDH
c