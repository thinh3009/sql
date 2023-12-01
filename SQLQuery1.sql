--create new database
CREATE DATABASE [sample]

ALTER DATABASE [sample] MODIFY NAME= [SAMPLE]
alter database [SAMPLE] modify name=[HOCSINH]
USE [SAMPLE]
use [HOCSINH]

--create with options
CREATE DATABASE SALES
ON
(
	NAME = SALES_DATA,
	FILENAME='C:\DATABASE\SALES.MDF',
	SIZE =10MB,
	MAXSIZE=50MB,
	FILEGROWTH=5MB
)
LOG ON
(
	NAME = SALES_LOG,
	FILENAME='C:\DATABASE\SALES.LDF',
	SIZE =10MB,
	MAXSIZE=50MB,
	FILEGROWTH=5MB
)
--------------------------------------------------------------------------------
--create table
drop table Student
create table Student
(
	studentID int,
	studentName nvarchar(50),
	studentBIRH date,
	studentADD nvarchar(100),
	ClassID nvarchar(50),
	ClassPoint int,
	
)
insert into Student (studentID,studentName,studentBIRH,studentADD,ClassID,ClassPoint) values (20021,'bui duc thinh','2002-09-30','2 ngo gia tu','cn20clcb',9)
insert into Student (studentID,studentName,studentBIRH,studentADD,ClassID,ClassPoint) values (20022,'bui thi hung','2001-08-30','3 lien nghia','cn20clca',10)
insert into Student (studentID,studentName,studentBIRH,studentADD,ClassID,ClassPoint) values (20023,'nguyen van luyen','2002-06-30','20 thi tin','cn20clcc',7)
insert into Student (studentID,studentName,studentBIRH,studentADD,ClassID,ClassPoint) values (20024,'ngo dinh diem','2006-09-05','3 dinh tien hoang','cn20clca',5)
insert into Student (studentID,studentName,studentBIRH,studentADD,ClassID,ClassPoint) values (20025,'nguyen thi mai','2007-01-23','3 lien nghia','cn20clcd',5)
insert into Student (studentID,studentName,studentBIRH,studentADD,ClassID,ClassPoint) values (20026,'le duc bao','2002-06-11','2 ngo ba kha','cn20clca',8)
select * from Student

create table achievement
(
	studentID int,
	ClassPoint int,
)
insert into achievement(studentID,ClassPoint) values (20021,9)
insert into achievement(studentID,ClassPoint) values (20022,8)
insert into achievement(studentID,ClassPoint) values (20023,7)
insert into achievement(studentID,ClassPoint) values (20024,6)
delete from achievement
drop table achievement
select * from achievement
--in(chon nhieu ban ghi cung luc)
select *from Student
where ClassID in('cn20clca','cn20clcd')
--cach khac
select *from Student
where ClassPoint in (select ClassPoint from achievement )/*chon hoc sinh co diem 8,9 tu bang achivement so voi bang student*/
--between
select * from Student
where ClassPoint between 5 and 9
--exists
--any
create table ability
(
	ClassPoint int,
	ClassAbility nvarchar(50),
	StudentName nvarchar (50),
)
drop table ability
insert into ability(studentName,ClassPoint,ClassAbility) values ('bui thi hung',10,'xuat sac')
insert into ability(studentName,ClassPoint,ClassAbility) values ('bui duc thinh',9,'gioi')
insert into ability(studentName,ClassPoint,ClassAbility) values ('le duc bao',8,'kha')
insert into ability(studentName,ClassPoint,ClassAbility) values ('nguyen van luyen',7,'kha')
insert into ability(studentName,ClassPoint,ClassAbility) values ('ngo dinh diem',5,'trung binh')
insert into ability(studentName,ClassPoint,ClassAbility) values ('nguyen thi mai',5,'trung binh')

select * from ability
where ClassPoint= 
any(select ClassPoint from ability where ClassAbility='kha') 

--all
select * from Student
where ClassPoint= 
all(select ClassPoint from ability where ClassAbility='trung binh') 

--order by(sap xep theo thu tu tang dan),desc (sap xep theo thu tu giam dan)
select * from Student order by ClassPoint 
select * from Student order by ClassPoint desc
select * from Student order by ClassPoint,studentName

--insert into(primary key not null bat buoc dien thong tin)
insert into Student values (20027,'le thanh toan','2009-04-30','4 nguyen van tuyen','cn20clcd',7)
insert into Student(studentName,studentBIRH) values ('le thien hieu','2003-04-04')

--dien 2 cot tren 1 hang
insert into Student(studentName,studentBIRH) values ('maguy','2003-05-04'),('harry potter','2001-01-01')

--update
select* from Student
update Student set studentID=20028
where studentName='le thien hieu'

--update nhieu dong
update Student set studentID=20028, studentADD='30/2 dong lao',ClassID='cn20clca'
where studentName='le thien hieu'

--delete
delete from Student
where studentID=20021
-------------------------------------------------------------------
--self join (lay du lieu trong 1 bang chia lam 2)
select c1.studentName as name1,c2.studentName as name2 from
Student c1, Student c2
where c1.studentADD =c2.studentADD and c1.studentID != c2.studentID
order by c1.studentADD
--create trigger
use SALES
create table t1 
(
	ID int primary key, 
	t1_values varchar(50),
)
insert into t1 values(1,'dien thoai')
insert into t1 values(2,'may tinh')
insert into t1 values(3,'tv')

create table t2
(
	ID int primary key, 
	t2_values varchar(50),
)
insert into t2 values(1,null)
insert into t2 values(2,null)
insert into t2 values(3,null)
--create
create trigger update_t2
on t1 for update
as--nhieu dong dung begin end
begin
	set nocount on
	declare @id int,@t1_values varchar(50)
	select @id=id, @t1_values = t1_values from inserted
	update t2 set t2_values =@t1_values
	where id=@id
end
--run trigger(update lai tu bang t2 null)
update t1--update gia tri
set t1_values ='do choi'
where id=1

select * from t2

--update nhieu gia tri
alter trigger update_t2
on t1 for update
as--nhieu dong dung begin end
begin
	set nocount on
	
	update t2 
	set t2_values =i.t1_values
	from inserted as i
	inner join t2 on t2.ID =i.ID
end
--vd2
create table order1
(
	orderID integer identity(1,1) primary key,
	orderDate datetime,
	orderStatus varchar(20)
)

create table order2
(
	orderAuditID integer identity(1,1) primary key,
	orderID integer,
	orderDate datetime,
	orderStatus varchar(20),
	updateBy nvarchar(128)
)
--create trigger
create trigger trig_createAuditorder on order1
after update,insert
as 
begin
	insert into order2(orderID, orderDate , orderStatus , updateBy )
	select i.orderID,i.orderDate,i.orderStatus,SUSER_NAME(),GETDATE() 
	from order1 t inner join inserted i on t.orderID=i.orderID 
end