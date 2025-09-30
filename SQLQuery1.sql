use manzardb
create table project
(Topic varchar(100),
project_type varchar(100)
)
select * from project
-- insert value 
insert into project values
('pizza','sql'),
('olympic','power bi ')



--from class 
CREATE TABLE STUDENT
(
    Roll int,
    Sname varchar(100),
    Marks numeric(5,2),
    Age int,
    Gender varchar(1),
    States varchar(2)
);


-- INSERTING VALUES INTO TABLE
INSERT INTO Student VALUES
(1, 'Aarnav Mehta', 89.50, 18, 'M', 'MH'),
(2, 'Sneha Reddy', 92.75, 17, 'F', 'DL'),
(3, 'Rohan Das', 76.25, 19, 'M', 'DL'),
(4, 'Pooja Sharma', 85.00, 18, 'F', 'DL'),
(5, 'Imran Khan', 67.00, 20, 'M', 'UP'),
(6, 'Meena Joshi', 90.25, 21, 'F', 'RJ'),
(7, 'Yash Patel', 73.80, 18, 'M', 'GJ'),
(8, 'Anjali Nair', 95.60, 17, 'F', 'CH'),
(9, 'Ravi Verma', 82.40, 19, 'M', 'CH'),
(10, 'Tanya Sen', 88.20, 18, 'F', 'AS'),
(11, 'Nikhil Roy', 69.70, 20, 'M', 'BR'),
(12, 'Divya Kaur', 91.10, 17, 'F', 'AS'),
(13, 'Arjun Rathi', 84.50, 19, 'M', 'HR'),
(14, 'Neha Jain', 87.65, 20, 'F', 'CH'),
(15, 'Vikas Singh', 79.00, 18, 'M', 'UP');

--another way to insert avlue 
insert into STUDENT(roll,Marks,Gender,States) values
(16,90,'m','JH')

select * from STUDENT

--use of IN operator 
select * from STUDENT where states in ('MH','DL','GJ')

--use of Distinct operator
select distinct Sname from STUDENT WHERE States='DL'

SELECT DISTINCT States from STUDENT

--comparision operator  (eqal to)= (not equal)!=  (greater than)>  
--(less than)<  (less than eqal)<=  (greater than equal)>=   not(<>)
--between (inclusive 70 and 90)

select * from STUDENT where Marks between 70 and 90;

--conditional operator   AND OR
--AND  true all condition 
--OR  true one condition 

--IN and NOT IN 
select * from STUDENT where States in ('UP','RJ') AND Marks <80   

--delete One Row from table
delete from STUDENT where roll=16



select * from STUDENT
insert into STUDENT(Roll ,Sname ,Gender,Age ,Marks ,States ) values
(1, 'Raj', 'F', 16, 72, 'UK'),
(2, 'Ramesh', 'F', 16, 34, 'MP'),
(3, 'Alok', 'M', 23, 61, 'TN'),
(4, 'Meera', 'F', 17, 94, 'UK'),
(5, 'Rizwan', 'M', 25, 56, 'RJ'),
(6, 'Shreya', 'M', 25, 44, 'GJ'),
(7, 'Diya', 'F', 17, 65, 'MH'),
(8, 'Ananya', 'M', 24, 81, 'GJ'),
(9, 'Aisha', 'F', 25, 38, 'TN'),
(10, 'Farhan', 'M', 18, 48, 'DL'),
(11, 'Imran', 'M', 23, 100, 'KA'),
(12, 'Faizan', 'F', 19, 96, 'DL'),
(13, 'Sohan', 'F', 19, 86, 'UP'),
(14, 'Sai', 'M', 21, 56, 'GJ'),
(15, 'Sai', 'M', 23, 96, 'WB'),
(16, 'Meera', 'F', 21, 36, 'UP'),
(17, 'Shreya', 'F', 24, 55, 'RJ'),
(18, 'Aarav', 'M', 16, 61, 'RJ'),
(19, 'Nisha', 'F', 23, 55, 'MH'),
(20, 'Rizwan', 'M', 20, 40, 'TN'),
(21, 'Manish', 'M', 21, 70, 'UP'),
(22, 'Priya', 'F', 19, 89, 'MH'),
(23, 'Pooja', 'M', 18, 35, 'TN'),
(24, 'Myra', 'M', 22, 96, 'TN'),
(25, 'Samir', 'F', 21, 43, 'WB'),
(26, 'Kiran', 'F', 18, 71, 'KA'),
(27, 'Aadhya', 'F', 24, 94, 'MP'),
(28, 'Manzar', 'M', 21, 95, 'DL'),
(29, 'Aditya', 'F', 18, 49, 'MH'),
(30, 'Diya', 'M', 19, 52, 'WB'),
(31, 'Arif', 'M', 17, 40, 'RJ'),
(32, 'Ira', 'M', 21, 44, 'DL'),
(33, 'Alok', 'F', 23, 46, 'DL'),
(34, 'Sneha', 'M', 21, 84, 'GJ'),
(35, 'Diya', 'F', 20, 92, 'DL'),
(36, 'Simran', 'F', 20, 70, 'UP'),
(37, 'Ananya', 'M', 17, 93, 'MH'),
(38, 'Meera', 'M', 25, 40, 'MP'),
(39, 'Myra', 'F', 17, 52, 'KA'),
(40, 'Rizwan', 'M', 25, 74, 'WB'),
(41, 'Diya', 'F', 18, 51, 'MH'),
(42, 'Komal', 'M', 24, 75, 'DL'),
(43, 'Sneha', 'M', 16, 98, 'RJ'),
(44, 'Neha', 'F', 23, 58, 'UP'),
(45, 'Aisha', 'F', 22, 77, 'GJ'),
(46, 'Aisha', 'F', 19, 88, 'DL'),
(47, 'Anika', 'M', 16, 57, 'KA'),
(48, 'Maya', 'M', 21, 39, 'GJ'),
(49, 'Maya', 'M', 20, 49, 'MP'),
(50, 'Shreya', 'M', 20, 48, 'WB');

select * from STUDENT 


--ALIAS 
select Sname as 'Baccho_ke_naam' from STUDENT 

--ORDER BY
select * from STUDENT order by Age desc
select * from STUDENT order by Age desc,Marks desc

--TOP keyword just like numpy head function 
--return head row as per request 
select top 5 * from STUDENT where Gender='F' order by Marks desc  --top 5 female student 
select top 5 * from STUDENT where Gender='M' order by Marks desc  --top 5 male student 

--AGGREGATES
-- SUM() MIN() MAX() AVG() COUNT()

select sum(Marks) as 'total_sum' from STUDENT 
select avg(Age) as 'average age' from STUDENT
select count(Roll) as 'number of student' from STUDENT
select min(Marks) as 'min marks' from STUDENT
select max(Marks) as 'max marks' from STUDENT

--LIKE OPERATOR 
-- is used with wild card character to find particular pattern 
--A %
--name start with a 
select * from student where Sname like 'an%';
--name end with a 
select * from student where Sname like '%a';
--contain a
select * from student where Sname like '%a%';

--B _ IS SINGLE CHARACTER
--Q.find a name whose name's fouth character is A
select * from student where Sname like '___a%';

--C []  SET OF CHARACTER 
--name starts with A R S 
select * from STUDENT where Sname like '[A,R,s]%' order by Sname ---without comma will work same as with comma

--D [^] EXCLUDE CHARACTER
-- name not start with a r s
select * from STUDENT where Sname like '[^ars]%'
--name start with a and have not second letter n and from state start with D 
selEct * FROM STUDENT Where Sname like 'a[^n]%' and  States like 'd%'

--SET OPERTOR 
--they are used to combine table vertically 
create table training_q1 
(emp_id int ,emp_name varchar(100),department varchar(50)
)

insert into training_q1 values
(101,'alice','finance'),
(102,'bob','HR'),
(103,'charlie' ,'dvaid' ),
(104,'david' ,'sales'),
(105,'eva', 'finance');

create table training_q2 
(emp_id int ,emp_name varchar(100),department varchar(50)
)
insert into training_q2 values
(101,'charlie','IT'),
(102,'david','sales'),
(103,'farah' ,'HR' ),
(104,'george' ,'it'),
(105,'hina', 'Marketing');

select * from training_q1 
select * from training_q2 

--NOTE at the time of set operator both table should have same column 
--UNION add all value remove duplicates 
--UNION ALL add all with duplictaes
--INTERSECTion matching values from both table 
--EXCEPTion  A-B

select * from training_q1
union all 
select * from training_q2  
