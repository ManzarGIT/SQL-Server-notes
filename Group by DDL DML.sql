select * from STUDENT 

--GROUP BY 
--it is used to organise data into groups based on specific column 
--and the perfrom aggregates function like (min max avg sum count)

--max marks per state
select Max(Marks) as 'max marks', states from STUDENT group by States 
--max marks per gender 
select Max(Marks) as 'max marks', Gender  from STUDENT group by Gender 
--avg marks per state and marks in desc order
select avg(Marks) as 'average marks', states from STUDENT group by States order by 'average marks' desc

--NOTE:-when using group by every column in select clause must be 
--listed in the group by clause 
--be used inside an aggregates function (sum min avg etc..)

select max(marks),States ,Gender  from STUDENT group by States ,Gender 

--WHERE AND HAVING CLAUSE

SELECT States ,AVG(marks) as 'avg marks' from STUDENT where Gender ='M'
group by States 
having AVG(marks) >70   -- having clause used in array of grouping 

--get the number of student having age is greater than 18 ,but only shows those state having min 2 student 

select  States ,count(*) as 'students more than 18 yr'from STUDENT where Age >18 
group by States 
having count(*)>1   
--count(*) will count the values present in column 

--select total number of female student in each state who scored more than 80 but include only those state having atlest 2 student 

select States ,count(*) from STUDENT where Gender ='F' and  Marks >85
group by States 
having count(*)>1

--solving problem 

--1 List the genders and their average marks for students younger than 20, only if the average marks are between 80 and 90.

select  Gender , AVG(Marks) from student where Age >20 
group by Gender 
having AVG(Marks) between 80 and 90



--2 Find average marks of male students in each state who are from 'UP', 'DL' or 'CH', and only show the states where average is below 80.
select States ,AVG(marks) as 'average marks' from STUDENT where States in ('UP','DL','CH') and Gender ='M'
group by States 
having AVG(marks) <80

--3 List states where female students have an average age greater than 18 and a total of more than 1 student.
select States ,AVG(marks) as 'avg marks',count(*) as 'students no.'  from STUDENT where Gender ='F' 
group by States 
having AVG(marks)>18 and count(*)>1

--4 Show the state(s) whose topper scored less than the class average marks. Display state and that topper's marks.
select  States ,Max(Marks)   from STUDENT  group by States 
having max(Marks) <(select avg(Marks) from STUDENT 
)

--5 List the names of students who are not among the top 3 average-scoring states.
select * from student where States not in (
select  top 3 States  from STUDENT 
group by States order by AVG(marks) desc)

--6 Show each state and its average marks, only for states whose average is higher than the overall class average. 
--Also, sort the result by highest average first.
--correct order is 
--SELECT …FROM … WHERE … GROUP BY … HAVING … ORDER BY …
select States ,AVG(marks) as 'state average'from STUDENT group by States 
having 
AVG(marks)>(
select avg(marks) from STUDENT ) order by AVG(marks)  desc

--7 Find the name(s) of the student(s) who belong to the state with the second highest number of students.(teacher help)

select Sname ,States  from STUDENT where States =(
select top 1 States   from (
select top 2 States ,count(*) as 'student_count' from STUDENT group by States order by count(*) desc)h order by student_count)  


--8 Find the names of students who are the youngest in their state, and from the state with the highest number of students.

select * from student where
Age =(select youngest_age  from (
select top 1 States , min(Age )as 'youngest_age',count(* ) as 'student_count'from STUDENT group by States order by student_count desc)h
)
and
States =(select States   from (
select top 1 States , min(Age )as 'youngest_age',count(* ) as 'student_count'from STUDENT group by States order by student_count desc)h
)

--9 Find the students who scored the highest marks among all those whose state has exactly 2 students.

select top 1 * from STUDENT where States=
(select states   from STUDENT group by States 
having COUNT(*)=2)
order by Marks desc

--10 Find the name(s) of the student(s) who belong to the only state where the average age and average marks both exceed the overall average

select * from STUDENT where States =(
select  States  from STUDENT group by States 
having avg(marks)>
(select AVG(Marks)from STUDENT )
and
avg(Age )>
(select avg(Age) from STUDENT )
)



 --DDL AND DML 
 --DDL-DATA DEFINITION LANGUAGE
 --DML-DATA MAUPULATION LANGUAGE 
 --DDL 
 --1 CREATE
 --2 ALTER to perform any modification on the table 
 select * from project 
 alter table project add duration int

 --Check data type 
 sp_help project 
 --Modify an existing column data type 
 alter table project alter column duration varchar(20)
 --Rename column 
 exec sp_rename 'project.duration' , 'software','column'  

 --3 DROP delete table existence 
 create table house 
 (memeber_name varchar(100),
 age int )
 select * from house
 insert into house values
 ('manzar',21),
 ('usman',22),
 ('samir',18)
 --drop table 
 drop table house 
 --4 TRUNCATE  delete all the data from table with left headers
truncate table house

--RENAME A TABLE 
exec sp_rename 'house','family'

select * from family
insert into family values
 ('manzar',21),
 ('usman',22),
 ('samir',18)


--DML COMMANDS
--INSERT
--SELECT
--UPDATE
--DELETE to remove specific records 
select * from family
UPDATE FAMILY 
SET AGE =22
WHERE memeber_name='manzar'

delete from family where age=18
select * from family

--DELETE AND TRUNCATE
--DELETE -DELETE ROW BY ROW 
--TRUNCATE-DROP THE ENTIRE TABLE AND CREATE BACK THE ENTIRE TABLE IN BACKGROUND
--DELETE -WHERE CLAUSE IS APPLICABLE 
--TRUNCATE-WHERE CLAUE IS NOT APPLICABLE 
--DELETE -DML
--TRUNCATE-DDL
--DELETE -SLOWER
--TRUNCATE-FASTER 


--DROP A COLUMN 
ALTER TABLE family
drop column age
select * from family

--INTO COMMAND it create a permanet table 

select Sname ,Age into class from STUDENT 
select * from class 

--TEMPRORY TABLE (LOCAL )
select Sname ,Age into #klass from STUDENT 
select * from #klass  

--TEMPRORY TABLE (UNIVERSAL)
select Sname ,Age into ##klass from STUDENT 
select * from ##klass  

