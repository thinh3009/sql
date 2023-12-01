--cross join: du lieu bang A nhan voi tat ca du lieu trong bang B(tich de cac)
create table ThucPham
(
	soLuong int,
	TenSP nvarchar(100),
	PhanLoai nvarchar(50),
	NgayNhap date,
)
insert into ThucPham values (2,'com','thuc pham','2022-09-30')
insert into ThucPham values (4,'rau cai','rau xanh','2022-09-29')
insert into ThucPham values (5,'ca ro phi','hai san','2002-08-23')
insert into ThucPham values (2,'bun','thuc pham','2022-02-02')

create table LoaiHang
(
	madon int,
	kho nvarchar(50),
)
insert into LoaiHang values (3009,'tp.hcm')
insert into LoaiHang values (3010,'hanoi')
insert into LoaiHang values (3011,'danang')
drop table LoaiHang

select * from ThucPham cross join LoaiHang
-----------------------------------------------------------------------------------------
--group by
create table category
(
	categoryID int,
	categoryName nvarchar(50)
)
insert into category values (111,'thuc pham')
insert into category values (112,'hai san')
insert into category values (113,'do dien tu')
insert into category values (114,'do gia dung')

create table product
(
	productID int,
	productName nvarchar(50),
	unitPrice int,
	categoryID int
)
insert into product values (1,'card man hinh',2000000,113)
insert into product values (2,'tom',3000,112)
insert into product values (3,'cua',10000,112)
insert into product values (4,'lo vi song',3000000,114)
insert into product values (5,'tu lanh',21000000,114)
insert into product values (6,'banh mi',20000,111)
insert into product values (7,'com',25000,111)
insert into product values (8,'cpu',1000000,113)
insert into product values (9,'pho',35000,111)
insert into product values (10,'main board',5000000,113)
insert into product values (11,'man hinh',2000000,NULL)
	
select product.productName, count(product.categoryID) as soLuong 
from product
group by productName
order by product.productName
--group by with join
create table warehouse
(
	warehouseID nvarchar(50),
	warehouseADD nvarchar(50),
	categoryID int
)
insert into warehouse values ('2HC','tp.ho chi minh',111)
insert into warehouse values ('4DN','da nang',112)
insert into warehouse values ('2HN','ha noi',113)
insert into warehouse values ('1CT','can tho',114)
--dem so luong san pham trong product dung (group by)
select product.productName,count(product.productID) as soLuong 
from product
group by product.productName
--group with join
--dem so luong categoryName tu left join voi product
select category.categoryName,count(product.productName) as So 
from category
left join product on category.categoryID=product.categoryID
group by category.categoryName
order by So
--having(dung de thay the where trong menh de group by)
select product.productName,MIN(product.unitPrice) as SanPhamThapNhat 
from product

group by product.productName
having MIN(product.unitPrice) < 35000

-----------------------------------------------------------------------------------------
--primary key
create table hocSinh
(
	masoSV int primary key,
	ten nvarchar(50),
	age int,
	lop nvarchar(50),
)
--xoa key tu constraint
alter table hocSinh
drop constraint PK__hocSinh__F894ECD16AC57B92
--tao primary key tu constraint (nvarchar not null)
alter table hocSinh
alter column ten nvarchar(50) not null

alter table hocSinh
add constraint pk_hocSinh_masoSV primary key (masoSV,ten)
------------------------------------------------------------------------
use THINN
--foreign key
create table ordersDetail
(
	orderID int,
	productID int,
	quantity int,
	price decimal,
	constraint pk_ordersDetail_orderID_productID 
	primary key(orderID,productID)
)

--tao foreign key tro den orderID
create table orders
(
	orderID int primary key ,
	createDate datetime,
	customerID int,
)
alter table ordersDetail
add foreign key (orderID) references orders(orderID)

--xoa foreign key tu constraint 
alter table ordersDetail
drop constraint FK__ordersDet__order__4D94879B

--tao foreign key truc tiep trong table 
drop table ordersDetail
drop table orders

create table ordersDetail
(
	orderID int foreign key references orders(orderID),
	productID int,
	quantity int,
	price decimal,
	constraint pk_ordersDetail_orderID_productID 
	primary key(orderID,productID)
)
create table orders	
(
	orderID int primary key ,
	createDate datetime,
	customerID int,
)
--unique constraint(unique la gia tri duy nhat ko dc co gia tri trung nhau)
create table person
(
	personID int primary key,
	indentify varchar(20), --unique,(rang buoc toan bo dulieu)
	[name] nvarchar(50),
)
insert person values (1,'123','thinh')
insert person values (2,'234','thinh')
drop table person
--tao constraint o ngoai sau khi da tao bang(chi rang buoc 1 du lieu duy nhat)
alter table person
add constraint UC_personID unique(personID)
--not null constraint
create table house
(
	houseID int primary key,
	indentifyID varchar(20) not null,
	[name] nvarchar(50),
)
--check constraint (gioi han mien du lieu)
create table cloth
(
	ID int not null,
	clothName varchar(50) not null,
	color varchar(20),
	price decimal check (price<=250)
)
insert into cloth values (202,'tee','red',300)--khong them dc vao bang vi gioi han cua check<=250
--default constraint(tu dong dua ra gia tri mac dinh cho 1 cot)
create table electric
(
	ID int not null,
	[name] varchar(50) not null,
	unit int,
	wharehouse varchar(20) default 'tp.hcm'
)
drop table electric
insert into electric (ID, [name],unit) values (212,'may tinh',3)
select * from electric
--chinh sua table co default
create table food
(
	ID int not null,
	[name] varchar(50) not null,
	unit int,
	dateDeliver date
)
alter table food 
add constraint DF_dateDeliver default getdate() for dateDeliver

insert into food (ID,[name],unit)values (321,'com ga xoi mo',1)
select * from food
--auto increment
use SALES
--identity
create table phone
(
	--identity(1,1):bat dau gia tri bang 1 voi buoc nhay la 1
	ID int identity(1,1) primary key,
	[name] varchar(50) not null,
	dateBuy date default getdate()
)
insert into phone ([name]) values('rog phone 5')
select * from phone
--dates
use HOCSINH

select * from ThucPham
where NgayNhap ='2022-09-30'
--index
use THINN

