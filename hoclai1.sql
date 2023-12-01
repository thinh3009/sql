use sample
create table SinhVien(
	ma int primary key,
	ten nvarchar(50),
	tuoi int,
	gioitinh bit,
	sodth char(15),
)
insert into SinhVien values (1,'bui duc thinh', 20, 1, '0372818739')
insert into SinhVien values (2,'nguyen van luyen', 20, 1, '0372548739')
insert into SinhVien values (3,'le thi mai', 20, 2, '0372818569')
--xoa thong tin trong ban
select * from SinhVien
delete from SinhVien
where ma=2
--update
update SinhVien
set
ten='ly van nam'
where ma=1
--rang buoc
create table KhachHang(
	id int primary key,
	[name] nvarchar(50),
	phone char(15),
	[address] nvarchar(100),
	sex bit,
	birth date
)
drop table KhachHang
insert into KhachHang values (1,'bui van linh', '0934543467','12, ton duc thang, tphcm',1,'2002-09-21')
insert into KhachHang values (2,'le thi lua', '0434541267','1, le van viet, tphcm',2,'2002-09-01')
insert into KhachHang values (3,'bui van linh', '0934543467','45, ton duc thang, tphcm',1,'2004-12-04')
insert into KhachHang values (4,'tran le minh', '0734543267','4, vo nguyen giap, tphcm',1,'2000-03-22')
insert into KhachHang values (5,'tran thuy vy', '0934543467','19/5, kenh 19/5, tphcm',2,'2000-11-17')
insert into KhachHang values (6,'tran ngoc my', '0434543467','19/5, kenh 19/5, tphcm',2,'2000-11-17')
update KhachHang
set [name]='Tuan' where id= 2

--group by
--dem tong so ban ghi cua khachHang trong dia chi
select [address],COUNT(id) as khachhang from KhachHang
group by [address]
order by COUNT(id) desc --sap xep so khach hang o dia chi theo thu tu giamr dan
--group by with join
create table Orders
(
	OrderID int,
	CustomerID int,
	EmPloyeeID int,
	OrderDate datetime,
	ShipperID int,
)
insert into Orders values (1038,2,7,'2022-02-01',1)
insert into Orders values (1039,3,3,'2022-01-01',3)
insert into Orders values (10310,5,4,'2022-06-01',2)
insert into Orders values (10311,5,3,'2022-06-01',3)
insert into Orders values (10312,5,5,'2022-06-01',2)
create table Shipper
(
	ShipperID int,
	ShipperName nvarchar(100)
)
insert into Shipper values (1,'le thi minh')
insert into Shipper values (2,'nguyen thi ha')
insert into Shipper values (3,'bui duc thinh')

--co bao nhieu don hang cho moi shipper
--shipper name: co so luong don hang
select s.ShipperName,COUNT(o.OrderID) as sodonhang
from Orders o
left join Shipper s 
on o.ShipperID=s.ShipperID
group by s.ShipperName order by COUNT(o.OrderID) desc
--having
select [address],COUNT(id) as khachhang from KhachHang
group by [address]
having COUNT(id) >1
order by COUNT(id) desc
--having with join
select s.ShipperName,COUNT(o.OrderID) as sodonhang
from Orders o
left join Shipper s 
on o.ShipperID=s.ShipperID
group by s.ShipperName 
having count(o.OrderID) > 1
order by COUNT(o.OrderID) desc
--join
create table MonHoc
(
	MaMonHoc nvarchar(50),
	TenMonHoc nvarchar(100),
	soChi int,
	LoaiHP bit,
)
insert into MonHoc values ('20h11','giai tich 1',3,1)
insert into MonHoc values ('20h12','xac suat thong ke',3,1)
insert into MonHoc values ('20h13','lap trinh mang',3,2)
insert into MonHoc values ('20h14','ky thuat so lieu',2,2)
insert into MonHoc values ('20h15','bong da',1,1)

create table LoaiHP(
	MaMonHoc nvarchar(50),
	loaiHP nvarchar(50),
)
insert into LoaiHP values ('20h11','batbuoc')
insert into LoaiHP values ('20h12','batbuoc')
insert into LoaiHP values ('20h13','khong')
insert into LoaiHP values ('20h14','khong')
insert into LoaiHP values ('20h15','batbuoc')

create table LopHocPhan
(
	maLopHP nvarchar(50),
	maMonHoc nvarchar(50),
	namHoc int,
	maGiangVien nvarchar(50),
)
insert into LopHocPhan values ('cn1','20h11',2023,'gv1')
insert into LopHocPhan values ('cn2','20h12',2022,'gv1')
insert into LopHocPhan values ('cn3','20h13',2023,'gv2')
insert into LopHocPhan values ('cn4','20h14',2023,'gv3')
insert into LopHocPhan values ('cn5','20h15',2023,'gv4')
insert into LopHocPhan values ('cn6','20h11',2023,'gv3')
update LopHocPhan
set
maMonHoc = '20h15'
where maLopHP='cn3'
drop table SinhVien
create table SinhVien 
(
	Tensv nvarchar(100),
	Masv int,
	MonHoc nvarchar(100),
)
insert into SinhVien values ('tran van nam',21,'xac suat thong ke')
insert into SinhVien values ('bui thi ha',24,'lap trinh mang')
insert into SinhVien values ('le van hung',22,'bong da')
insert into SinhVien values ('nguyen trung hieu',29,'xac suat thong ke')
insert into SinhVien values ('ha thi ly',33,'giai tich 1')
insert into SinhVien values ('nguyen van bay',69,'ky thuat so lieu')
--inner join
select m.MaMonHoc,m.TenMonHoc,l.namHoc from MonHoc m
inner join LopHocPhan l
on m.MaMonHoc=l.maMonHoc
--left join
select m.MaMonHoc,m.TenMonHoc,l.namHoc from MonHoc m
left join LopHocPhan l
on m.MaMonHoc=l.maMonHoc
--right join
select m.MaMonHoc,m.TenMonHoc,l.namHoc from MonHoc m
right join LopHocPhan l 
on m.MaMonHoc=l.maMonHoc
--full outer join
select m.MaMonHoc,m.TenMonHoc,l.namHoc from MonHoc m
full outer join LopHocPhan l 
on m.MaMonHoc=l.maMonHoc
--self join
select s1.Tensv as ten1 from SinhVien s1, SinhVien s2
where s1.MonHoc=s2.MonHoc and s1.Masv != s2.Masv
--cross join
select * from MonHoc m cross join LoaiHP l
-----------------------------------------------------------------------------------------
--primary key
create table nhanVien(
	maNV int primary key,
	ten nvarchar(50),
	tuoi int,
	bophan nvarchar(100),
)
alter table nhanVien 
alter column ten nvarchar(50) not null
--drop key
alter table nhanVien
drop constraint [PK__nhanVien__7A3EC7D51A2A7157]
--add constraint
alter table nhanVien
add constraint pk_nhanVien_maNV	primary key (maNV,ten)

--foreign key
create table orderDetail(
	orderID int,
	productID int,
	price decimal,
	constraint pk_orderDetail_orderID_productID
	primary key (orderID, productID)
)

create table [order] (
	orderID int primary key,
	createdate datetime,
	customerID int,

)
alter table orderDetail 
add foreign key (orderID) references [order](orderID)
--drop foreign key
alter table orderDetail
drop constraint [FK__orderDeta__order__540C7B00]
--unique constraint
--khoa ko can la primary key la unique van dc
--not null constraint
--check constraint
create table person(
	id int not null,
	lastname varchar(50),
	firstname varchar(50),
	age int check (age>=18),
)

insert into person values (1,'bui','thinh',17)
insert into person values (1,'bui','ha',19)
select * from person
--default constraint: gan gia tri mac dinh cho city
create table person2(
	id int not null,
	lastname nvarchar(50) not null,
	firstname nvarchar(50),
	age int,
	city nvarchar(200) default 'sadnes'
)
insert into person2 (id,firstname,lastname,age) values (1,'thinh','bui',30)
select * from person2
alter table person2
add dateofbrth datetime;
alter table person2
add constraint df_dateofbrth default getdate() for dateofbrth
insert into person2 (id,firstname,lastname,age,city) values (3,'thinh','nguyen',20,'american')
select * from person2
---------------------------------------------------
--auto increment: tu dong cap nhat so lieu
create table person3(
	id int identity(1,1),
	lastname nvarchar(50) not null,
	firstname nvarchar(50),
	age int,
	city nvarchar(200)
)
insert into person3 (lastname,firstname,age,city) values ('thinh','bui',20,'vietnam')
select * from person3
---------------------------------------------------------
--index
--clustered index
create clustered index idx_person_id on person(id)

select * from person where id=1
select * from person_noIndex where id=1
insert into person_noIndex values (1,'thinh','le',20)
insert into person_noIndex values (2,'mai','le',20)
insert into person_noIndex values (3,'hung','le',20)
--drop index
drop index idx_person_id on person

--non_clustered index
create nonclustered index idx_person_1stname_age on person(firstname,age)
select * from person where firstname='le' and age=20
----------------------------------------------------------------------------
--view
create view v_KhachHang_name
as
select * from KhachHang where [name]='bui van linh'
select * from v_KhachHang_name
--view with check option
alter view v_KhachHang_name
as
select * from KhachHang where sex is not null
with check option
select * from v_KhachHang_name
update KhachHang
set sex = 0 where id =1

update v_KhachHang_name set [name]=null, phone =null where ID= 5

insert into v_KhachHang_name values (7,'nguyen thi lua',0334343212,'72,quang trung,tphcm',0,'2000-04-12')

--------------------------------------------------------------------------------
--function
create table HocSinh(
	id int primary key not null,
	[name] nvarchar(100),
	age int,
	datebirth date,
)
insert into HocSinh values (1,'bui duc thinh',21,'2002-09-30')
insert into HocSinh values (2,'le duc minh',22,'2001-09-30')
insert into HocSinh values (3,'duong minh tuyen',19,'2004-02-10')
insert into HocSinh values (4,'nguyen van a',18,'2005-09-30')

create function	udf_caculateAge
(
	@age int
)
returns bit 
as 
begin
	declare @allowBuyTicket bit;
	if @age >= 20
		set @allowBuyTicket =1;
	else
		set @allowBuyTicket =0;
	return @allowBuyTicket;
end
select dbo.[udf_caculateAge](20) as tuoi

select *,dbo.[udf_caculateAge](age) as muave from HocSinh

select * from HocSinh where dbo.[udf_caculateAge](age) = 0

select * from 
(select *,dbo.[udf_caculateAge](age) as muave from HocSinh) 
as ve where muave =1

---------------------------------------------------------------------
--store procedure
create proc sp_HocSinh
as
	begin
		insert into HocSinh values (5,'Nguyen van ha',20,'2003-09-02');
		update LopHocPhan set namHoc=2025 where maLopHP= 'cn4'
	end

exec sp_HocSinh
select * from HocSinh
select * from LopHocPhan
--store procedure co tham so dau vao
alter proc sp_HocSinh @id int, @maHP nvarchar(50)
as
	begin
		insert into HocSinh values (@id,'Nguyen van ha',20,'2003-09-02');
		update LopHocPhan set namHoc=2022 where maLopHP= @maHP
	end

exec sp_HocSinh 7, 'cn6'
select * from HocSinh
select * from LopHocPhan
--store procedure co tham so output
create proc sp_getStudent
--------------------------------------------------------
--trigger
create table t1
(
	id int primary key,
	t1_values varchar(50)
)

insert into t1 select 1, 'values1'
insert into t1 select 2, 'values2'
insert into t1 select 3, 'values3'
select * from t1

create table t2 (
	id int primary key,
	t2_values varchar(50)
)
insert into t2 select 1, null
insert into t2 select 2, null
insert into t2 select 3, null
select * from t1
select * from t2
--tao trigger update bang t1 se tu update o t2
create trigger update_t2
on t1 for update
as
	begin
		set nocount on

		declare @id int, @t1_value varchar(50)
		select @id =id, @t1_value = t1_values from inserted
		update t2 set t2_values = @t1_value
		where id=@id
	end
--run trigger
update t1 set t1_values = 'hoc' where id=1

--cap nhat het cac cot trong value2
alter trigger update_t2
on t1 for update
as
	begin
		set nocount on

		update t2 
		set t2_values = i.t1_values
		from inserted as i --inserted la them gia tri vao trigger values2
		inner join t2 on t2.id=i.id
	end

update t1 set t1_values = 'hai'

--ex2
create table [o.order] 
(
	orderID integer identity(1,1) primary key,
	orderApprovalDate datetime,
	orderStatus varchar(20)
)
create table [o.tblOrderAudit]
(
	orderAuditID integer identity(1,1) primary key,
	orderID integer,
	orderApprovalDate datetime,
	orderStatus varchar(20),
	updateBy nvarchar(128),
	updateOn datetime
)
drop table [o.tblOrderAudit]
--create trigger
create trigger trig_CreateOrderAudit on [o.order] 
after update, insert
as
begin
	insert into [o.tblOrderAudit](orderID,orderApprovalDate,orderStatus,updateBy,updateOn)
	select i.orderID,i.orderApprovalDate,i.orderStatus,SUSER_NAME(),GETDATE() from  [o.order] t inner join inserted i on t.orderID=i.orderID
end

insert into [o.order] values (null,'pending')
insert into [o.order] values (null,'pending')
insert into [o.order] values (null,'pending')
select * from [o.order] 
select * from [o.tblOrderAudit]

update [o.order] set orderStatus = 'approve',orderApprovalDate=GETDATE()
where orderID=1
------------------------------------------------------------------------

--transaction
--rollback
create table valueTable(id int)
begin transaction
insert into valueTable values (1)
insert into valueTable values (1)
rollback

select * from valueTable
--commit
begin transaction
insert into valueTable values (1)
insert into valueTable values (1)
commit
--delete

declare @tranName varchar(20) = 'deleteHocSinh'
begin transaction @tranName
delete from HocSinh where id=1
commit transaction @tranName
--try catch
begin try
	insert into valueTable values (3)
	insert into valueTable values ('test')
commit
end try
begin catch
	if(@@TRANCOUNT>0)--dem so lon hon 0
		rollback tran
	DECLARE @ErrorMessage nvARCHAR(4000)= error_message()
	DECLARE @ErrorSeverity INT = error_severity()
	DECLARE @ErrorState INT = error_state()
		RAISERROR (@ErrorMessage,--message text
		@ErrorSeverity,--severity
		@ErrorState--state
		);
end catch
----------------------------------------------------------------
--subquery
select * from Orders
select * from orderDetail
insert into orderDetail values (1038,001,20000)
insert into orderDetail values (1039,002,40000)
insert into orderDetail values (10310,003,290000)
insert into orderDetail values (10311,004,80000)
insert into orderDetail values (10312,005,450000)
--subquery in select
select OrderID,productID,(select avg(price) from orderDetail) 
as trungbinh from orderDetail 
--select with from
select * from \
--------------
use AdventureWorks2017
select * from Purchasing.PurchaseOrderDetail
-----------------------------------------------------------
select * from DonDatHang
select * from KhachHang
select count(k.TenKH) over (partition by k.TenKH) as totalKH,k.TenKH ,d.MaKH,k.DiaChi 
from DonDatHang d 
inner join KhachHang k on d.MaKH = k.MaKH

select count(k.TenKH) as totalKH,k.TenKH
from DonDatHang d 
inner join KhachHang k on d.MaKH = k.MaKH
group by k.TenKH 

---------------------------------------------------------------------------

use DA
--using trim, ltrim,strim
select 