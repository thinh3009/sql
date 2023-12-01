use Mind
create table student(
	studentID int primary key,
	studentName nvarchar(50),
	stu_Subject_ID nvarchar(10),
	Stu_marks int,
	Stu_age smallint,
)

create table subj(
	subjectID nvarchar(10) primary key,
	subjectName varchar(50),
)
drop table subj
insert into student values(101,'Alkhil','BCA101',85,20)
insert into student values(102,'Balram','BCA104',78,19)
insert into student values(103,'Bheem','BCA102',80,22)
insert into student values(104,'Chetan','BCA103',95,20)
insert into student values(105,'Diksha','BCA104',99,20)
insert into student values(106,'Raman','BCA105',88,19)
insert into student values(107,'Sheetal','BCA103',98,22)

insert into subj values ('BCA101','C')
insert into subj values ('BCA102','C++')
insert into subj values ('BCA103','printciple managerment')
insert into subj values ('BCA104','Core java')
insert into subj values ('BCA105','Math')
insert into subj values ('BCA106','Android')

select * from student
select * from subj

--1. Write SQL query shows all the rows of those Students whose age is 20.
select * from student where Stu_age = 20
--2.Write query shows the second-highest marks from the student table.
SELECT MAX(Stu_marks) as secondHighest
FROM student 
WHERE Stu_marks < (SELECT MAX(Stu_marks) FROM student);
--3.Write a query to show the record of those students whose name begins with the 'R' character
select studentName from student where studentName like 'R%' 
--4. Write query shows the three minimum marks from the student table
SELECT TOP 3 Stu_marks 
FROM student 
ORDER BY Stu_marks ASC;
