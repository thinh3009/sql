--inner john
use SALES
use [sample]
create table product
(
	productID int primary key,
	productName nvarchar(50),
	unitPrice decimal,
	categoryID int,--"khoa ngoai" tham chieu den bang khac (giam du thua thong tin)
	suplierID int,
	unit nvarchar(50),
)
drop table product

select * from product
insert into product values (1,'durex',89000,1,1,'cai')
insert into product values (2,'oke',13000,1,2,'cai')
insert into product values (3,'sextoy',10000,1,3,'cai')
insert into product values (4,'ma tuy da',200000,2,5,'bi')
insert into product values (5,'thuoc lao',5000,2,6,'tep')
insert into product values (7,'thuoc lac',100.000,2,4,'vi')
insert into product values (8,'ma tuy tong hop',900.000,2,7,'bi')

create table category
(
	categoryID int,--khoa ngoai (dung de join giam thua thong tin)
	categoryName nvarchar(50),
)
insert into category values (1,'do choi')
insert into category values (2,'chat kich thich')
--hop nhat 2 bang co cung kieu du lieu (inner join)
select * from product inner join category 
on product.categoryID=category.categoryID--product.(dung de chon tranh truong hop trung bang)
select productID,productName,category.categoryName from product inner join category 
on product.categoryID=category.categoryID
---------------------------------------------------

select product.productID,
product.productName,
category.categoryName
from product inner join category
on product.categoryID=category.categoryID
--ki hieu
select p.productID,
p.productName,
c.categoryName
from product p inner join category c
on p.categoryID=c.categoryID--join 2 bang co chung du lieu
--hop nhieu bang
create table supllier
(
	supllierID int,
	supllierName nvarchar(50),
)
insert into supllier values(1,'my'),(2,'vietnam')
insert into supllier values (3,'tau khua')
delete from supllier where supllierID=1
select * from supllier
select p.productID,
p.productName,
c.categoryName,
s.supllierName,
s.supllierID,
p.unitPrice
from product p 
inner join category c
on p.categoryID=c.categoryID
inner join supllier s
on p.categoryID=s.supllierID
--outer join(left join,right join, full join)
--left
--product-->supplier
select p.productID,p.productName,s.supllierName,s.supllierID,p.unitPrice
from product p --product la bang left
--inner join category c
--on p.categoryID=c.categoryID
left join supllier s --supllier la bang right
on p.categoryID=s.supllierID
delete from product where productID=1
--right
select p.productID,
p.productName,
s.supllierName,
s.supllierID,
p.unitPrice
from product p --product la bang left
right join supllier s --supllier la bang right
on p.categoryID=s.supllierID
delete from product where categoryID=1
--full
select p.productID,
p.productName,
s.supllierName,
s.supllierID,
p.unitPrice
from product p --product la bang left
full join supllier s --supllier la bang right
on p.categoryID=s.supllierID
delete from product where categoryID=1

--transaction
use HOCSINH
create table valuetable
(
	id int,
)
--goi transaction
begin transaction
insert into valuetable values (1)
insert into valuetable values (2)
commit--dung commit gia tri moi dc dua vao bang
rollback--tra ve gia tri trc
drop table valuetable
select * from valuetable
--delete
select * from hocSinh
begin transaction 
delete hocSinh where ten='thinh'
rollback

--dat ten cho transaction
declare @trans varchar(20)
select @trans ='trans1'
begin transaction @trans
delete hocSinh where ten ='thinh'
commit transaction @trans --chap nhan trans
-------------------------------------------------
--save
begin transaction
save transaction trans1