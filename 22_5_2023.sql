use master
alter database AdventureWorks2019 set recovery full
--1
backup database AdventureWorks2019
to disk = 'C:\Program Files\Microsoft SQL Server\MSSQL16.SQLEXPRESS\MSSQL\Backup\adv2019back.bak'
with format;
go
--2
restore database AdventureWorks2019
from disk = 'C:\Program Files\Microsoft SQL Server\MSSQL16.SQLEXPRESS\MSSQL\Backup\adv2019back.bak'
with file =1, replace, recovery
go

--3
create view v_product
as
	select p.Name,p.ListPrice,p.ProductID from Production.Product p
select * from v_product

begin transaction;
declare @TongSP int, @TongBike Int

select @TongSP= sum(p.ListPrice) from v_product p

select @TongBike = sum(v.ListPrice) from v_product v
where v.Name like '%bike%'

if (@TongBike > @TongSP * 0.6)
	begin 
		update v_product
			set ListPrice = 15
			where Name like '%bike%'
		print N' da giam tat ca mat hang bike ve 15$'
		commit
	end
else
	begin
		print N'tong gia tri cua mat hang xe dap < tong gia tri tat ca mat hang'
		print N'khong giam gia mat hang bike'
		rollback
	end
go

--4
backup database AdventureWorks2019
to disk = 'C:\Program Files\Microsoft SQL Server\MSSQL16.SQLEXPRESS\MSSQL\Backup\adv2019back2.bak'
with differential

backup log AdventureWorks2019
to disk = 'C:\Program Files\Microsoft SQL Server\MSSQL16.SQLEXPRESS\MSSQL\Backup\adv2019back3.bak'

--5
use AdventureWorks2019

BACKUP LOG AdventureWorks2019 TO DISK = 'C:\Program Files\Microsoft SQL Server\MSSQL16.SQLEXPRESS\MSSQL\Backup\adv2019back4.bak';

--6
--full backup
BACKUP DATABASE AdventureWorks2008R2
TO DISK = 'C:\Program Files\Microsoft SQL Server\MSSQL16.SQLEXPRESS\MSSQL\Backup\adv2008.bak'
WITH INIT
GO
--them du lieu
select * from Person.PersonPhone where BusinessEntityID = 10000
INSERT INTO Person.PersonPhone VALUES (10000,'123-456- 7890',1,GETDATE())
--differential backup
backup database AdventureWorks2008R2
to disk = 'C:\Program Files\Microsoft SQL Server\MSSQL16.SQLEXPRESS\MSSQL\Backup\adv2008.bak' 
with differential
-- c. Chú ý giờ hệ thống của máy.  Đợi 1 phút sau, xóa bảng Sales.ShoppingCartItem
truncate table Sales.ShoppingCartItem
--7
USE master   
GO  
DROP DATABASE AdventureWorks2019;  
GO  
--8
--a.Như lúc ban đầu (trước câu 3) thì phải restore thế nào? 
restore database AdventureWorks2019
from disk = 'C:\Program Files\Microsoft SQL Server\MSSQL16.SQLEXPRESS\MSSQL\Backup\adv2019back.bak'
select * from AdventureWorks2019
--b.Ở tình trạng giá xe đạp đã được cập nhật và bảng Person.EmailAddress vẫn còn nguyên chưa bị xóa (trước câu 5) thì cần phải restore thế nào?
restore database AdventureWorks2019
from disk = 'C:\Program Files\Microsoft SQL Server\MSSQL16.SQLEXPRESS\MSSQL\Backup\adv2019back2.bak'
with norecovery
--c.Đến thời điểm đã được chú ý trong câu 6c thì thực hiện việc restore lại CSDL AdventureWorks2019 ra sao?
restore log AdventureWorks2008R2 from 
DISK = 'C:\Program Files\Microsoft SQL Server\MSSQL16.SQLEXPRESS\MSSQL\Backup\adv2019back.bak'	
With Standby 


