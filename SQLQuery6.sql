/****** Script for SelectTopNRows command from SSMS  ******/
--cluster index: neu da co khoa chinh no se tu dong tao cluster index
SELECT TOP (1000) [houseID]
      ,[indentifyID]
      ,[name]
  FROM [THINN].[dbo].[house]

insert into house values(331,0372818739,'nha san')
insert into house values(332,0976351034,'nha go')
insert into house values(333,0769399818,'nha cap 3')
insert into house values(334,083581514,'nha cap 4')
select * from house

--noncluster index: khi khong co khoa chinh,co the tao moi khi ko co khoa chinh
create clustered index IX_food_ID
on food(ID)
--view:giong nhu tao ham 
create view V_name_NameIs
as
select * from house
where name='nha go'
--
select * from V_name_NameIs
--check view not null
alter view V_name_NameIs
as
select * from house
where name is not null--name bat buoc not null
with check option
--update view
update V_name_NameIs
set houseID= 337,[name]='nha lau xe hoi'
where houseID=331
--insert view
insert into V_name_NameIs
values (331,01644754509,'nha ngheo')
--delete view
delete V_name_NameIs where [name]='nha ngheo'
--function
use HOCSINH
select * from hocSinh
insert into hocSinh values (123,'thinh',13,'cn20b')
insert into hocSinh values (124,'huy',17,'cn20b')
insert into hocSinh values (125,'thao',20,'cn20c')
insert into hocSinh values (126,'mai',10,'cn20d')

create function udf_caculateAge
(
	@age int
)
returns bit
as 
begin
	declare @allowBuyTobaco bit;
	if @age >=13
		set @allowBuyTobaco =1;
	else
		set @allowBuyTobaco=0;
	return @allowBuyTobaco;
end
select dbo.udf_caculateAge(10) 
--dung chung function voi select
select *,[dbo].[udf_caculateAge](age) from hocSinh