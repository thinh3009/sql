USE THINN
--CREATE TABLE
CREATE TABLE Student
(
	Id INT,
	[Name] NVARCHAR(50),--ki tu toi thieu
	[Age] INT,
	Birth DATE,
	sex BIT,--gia tri true false
)
create table student3
(
	Id int,
	[Name] nvarchar(50),
	[Age] int,
	Birth date,
	genth Bit,
)
INSERT INTO student3(Id,[Name],[Age],Birth,genth) VALUES(1,'LE VAN LUYEN',19,'2002-09-30',2)
INSERT INTO student3(Id,[Name],[Age],Birth,genth) VALUES(2,'NGUYEN THI TINH',20,'2004-08-30',1)
INSERT INTO student3(Id,[Name],[Age],Birth,genth) VALUES(3,'BUI DUC HUNG',22,'2001-06-20',1)
INSERT INTO student3(Id,[Name],[Age],Birth,genth) VALUES(4,'HA VAN TAM',19,'2009-09-30',2)
INSERT INTO student3(Id,[Name],[Age],Birth,genth) VALUES(5,'HA VAN MINH',22,'2006-07-30',1)
INSERT INTO student3(Id,[Name],[Age],Birth,genth) VALUES(6,'LE QUANG VINH',17,'2007-09-30',2)
SELECT * FROM student3
DELETE FROM student3
--drop table(xoa toan bo bang)
drop table student3
DROP TABLE Student
--insert table (them du lieu vaof bang)
INSERT INTO Student(Id,[Name],[Age],Birth,sex) VALUES(5,'LE DUC THINH',20,'2001-09-30',1)
INSERT INTO Student(Id,[Name],[Age],Birth,sex) VALUES(6,'NGUYEN DUC NAM',22,'2002-08-30',2)
INSERT INTO Student(Id,[Name],[Age],Birth,sex) VALUES(7,'BUI DUC HUNG',18,'2003-09-30',1)
SELECT * FROM Student
--delete table(xoa du lieu trong bang)
DELETE FROM Student 
WHERE Age=20

DELETE FROM Student
--Xoa sach du lieu
TRUNCATE TABLE Student
--rename table
sp_rename 'student2','student'
--lay du lieu tu bang cu qua bang moi
SELECT Id,[name] INTO Student2 FROM Student
--Select
SELECT * FROM student WHERE [Age] >20 and id=1
select * from student order by [Age] desc--sap xep tuoi giam dan
--select distinct(xoa cac ban ghi giong nhau)
select [name] from student
select distinct [name] from student
--select min, max
select * from student
select min([age]) from student
select max([age]) from student
--select top(TOP dung de lay ban ghi tu 1 hoac nhieu bang va gioi han so ban ghi tra ve dua tren gia tri hay phan tram co dinh)
use [sample]
select top 
create table GiangVien
(
	id int,
	[name] nvarchar(100),
	class nvarchar(100),
)
insert into GiangVien values (1,'le van quang', '12a1')
insert into GiangVien values (2,'nguyen thi thuy','11a3')
insert into GiangVien values (3,'pham thi trinh','3a3')
--lay so luong gia tri trong bang
select top 2 [name] from GiangVien 
select top 2 [name] from GiangVien where class='3a3'
--count(dem)
select * from student
--as (dat ten cho cot chua co ten, no chi hien thi 1 lan)
select count(*) from student where [Age]>18
select count(*) as tuoi from student where [Age]>18
--averange (gia tri trung binh trong cot)
select avg([Age]) as tuoiTB from student
--sum
select sum([Age]) as tongTuoi from student
--union SELECT(hop nhat 2 ban ghi voi nhau bo ban ghi giong nhau)
SELECT * FROM student3
union all--(hop 2 ban ghi lay tat ca ban ghi giong nhau)
select *from Student
--NULL(ktra gia tri dua ra gia tri thay the)
select * from Student
update Student set [Name]=null where Id=5
select Id,[Name] from Student
select Id,isnull([Name],'No Name ') from Student--neu null ta gan gia tri mac dinh
--select into(lay gia tri tu ban ghi cu dua vao ban ghi moi)
select * into Student4
from student3 where [Age]<20
select * from Student4
-------------------------------------------------------------------------------------
--and(hien thi dieu kien khi ca 2 dieu kien deu dung)
select * from student3
where [Age]= '19' and sex='1'
--or(hien thi khi 1 trong 2 dung)
select *from student3
where [Age]='19' or birth='2002-09-30'
--not
select *from student3
where not [Age]='19'
--combine and,or,not
insert into student3 values (7,'Nguyen thi tuyet','30','2006-07-30',2)
insert into student3 values (8,'Nguyen thi toan','19','2006-07-30',2)
select *from student3
where [Age]='19' and (Birth='2002-09-30' or Birth='2006-07-30')

select *from student3
where not [Age]=19 and not [Age]=30
--like(lay ki tu tuong dong trong bang)
--lay ki tu dau
select * from student3
where [Name] like 'h%'
--lay ki tu cuoi
select *from student3
where [name] like '%h'
--lay ki tu o giua bat ki
select *from student3
where [name] like '%an%'
--gach ngang:phia truoc rong, %:chuoi ki tu bat ki
select * from student3
where [name] like '_a%'
--
insert into student3 values (8,'la thitoan','19','2006-07-30',2)
--gia tri bat dau bang n chieu dai toi thieu la 3
select * from student3
where [name] like 'n_%_%'
--bat dau bang h ki tu bat ki ket thuc bang m
select * from student3
where [name] not like 'h%m'
where [name] like 'h%m'

