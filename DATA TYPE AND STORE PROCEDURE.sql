--CREATING THE VARIABLE 

--DECLARE VARIABLE
DECLARE @VAR INT 
--SET a value
set @VAR=45
--USE IT TO SHOW 
select @VAR

--short-cut
declare @va Int =60
select @VA

--HR salary 
--10 increament
declare @salary decimal(10,2)=1000000
declare @increament decimal(4,2)=10
select @salary+(@salary*@increament/100) as 'new salary'

--DATA TYPE 

--NUMERIC DATA TYPES
--INT   
-->INTEGER VALUE (-2147483648 TO +2147483648)
--4BYTE
DECLARE @A INT =10000
SELECT @A AS 'Variable A'

--SMALL INT  
-->INTEGER (-32768 TO +32768)
--2 BYTES

--TINYINT 
--INTEGER(0,255)
--1 BYTE

--BIGINT
--VERY VERY LARGE NUMBER  (-+9.8 QUINTILLION)
--8 BYTE

--DECIMAL (PRECISION,SCALE)/NUMERIC (PRECISION,SCALE)
--DECIMAL ,FRACTIONAL INFORMATION 

--PRECISION-TOTAL NUMBER OF DIGIT 
--SCALE --TOTAL DIGIT AFTER DECIMAL 

--FLOAT 
--FRACTIONAL DATA
--NO  LIMIT 

--STRING 

--UNICODE CHARACTER -->oldest ->represented only limited value
--128 character 
--(A-Z),(a,z),(0-9),punctuation and control characters

--ASCII CHARACTER 
--modern and universal character set 
--emojis hindi chinese arabic etc
--1 million character

--char(N)
--stores text ,but it is fixed 
--number of character (-1 to 8000)
--no unicode ,only ascii

--varchar(N)
--store text  but length is variable 
--no unicode ,only ascii


--text 
--depriciated from MS-sql
--stores very large values
--text of space upto 28gb
---no unicode ,only ascii

--nchar(n)
--accept values(1-4000)
--accepts unicode

--nchar(n)
--store text ,length is variable
--stores unicode 

--NTEXT 
--depriciated from MS-sql
--stores very large values
--text of space upto 28gb
--accepts unicode data

create table users
(name nvarchar(50))

insert into users values(N'नमस्ते')-->N in capital -->in case of varchar (!possible)
select * from users

--DATE AND TIME 

--DATE
--STORE ONLY DATE (Y,M,D)

--DATETIME
--DATES AND TIMES (DATES,TIMES,HRS,MINUE,SECOND,MILI-SECOND)


--TIME
--STORE ONLY TIME



--<><>STORE PROCEDURE<><>
--LIKE A FUNCTION IN PYTHON ,ONCE WRITTEN , CAN USE MULTIPLE TIMES

--show a average for employment type
create procedure avg_salary_emp_type
as
begin 
     select employment_type ,avg(salary_usd) as salary from AIjob
     group by employment_type
end

exec avg_salary_emp_type

--show average salary for each employee as per job title 
--USER INPUT BASED 
create procedure Average_salry @Job_title varchar(50)
as 
begin 
     select employment_type ,avg(salary_usd) as salary from AIjob
     where job_title=@Job_title
     group by employment_type
end

exec Average_salry 'AI Consultant'  --user input 
select * from AIjob

--FIND JOBS BY EDUCATION AND EXPERIENCE LEVEL 
--(TWO USER INPUT)
CREATE PROCEDURE GET_JOBS @experience_level smallint,@educaton_level varchar(50)
as 
begin
select job_title ,salary_usd as salary,education_required,years_experience from AIjob
     where years_experience<=@experience_level and education_required=@educaton_level
     
end
select * from AIjob
exec GET_JOBS 2 ,'Bachelor'
--OR
exec GET_JOBS @experience_level=2 ,@educaton_level='Bachelor'

--DROP PROCEDURE (procedure name)
-- Delete multiple procedures at once
--DROP PROCEDURE uspInsertEmployee, uspUpdateEmployee;

--TOP 3 INDUSTRIES BY COUNT OF JOB OPENINGS BY GVING EXPERIENCE YEAR 
create procedure top3_industry_by_experience @exper smallint 
as 
begin 
select top 3  industry ,COUNT(*) as 'count' from AIjob where years_experience<=@exper group by industry order by count(*) desc
end 

exec top3_industry_by_experience 0

DROP PROCEDURE top3_industry_by_experience

--show all the job that the skill are provided by user 

create procedure skill_job @skill1 varchar(50),@skill2 varchar (50)
as 
begin
select * from AIjob where required_skills  like '%'+@skill1+'%' 
or required_skills  like '%'+@skill2+'%'
end

exec skill_job 'sql','python'





--USE OF STORE PROCEDURE 

CREATE TABLE Warehouse_Inventory (
    ProductID INT PRIMARY KEY,
    ProductName VARCHAR(100),
    Quantity INT
);

INSERT INTO Warehouse_Inventory (ProductID, ProductName, Quantity) VALUES
(101, 'Levi Jeans', 100),
(102, 'Denim Jacket', 60),
(103, 'Cotton Shirt', 150),
(104, 'Sneakers', 80),
(105, 'Leather Belt', 40);

DROP TABLE new_consigment
CREATE TABLE new_consigment (
    ProductID INT,
    ProductName VARCHAR(100),
    Quantity INT
);

INSERT INTO new_consigment (ProductID, ProductName, Quantity) VALUES
(101, 'Levi Jeans', 25),
(103, 'Cotton Shirt', 15),
(106, 'Sports Cap', 50),
(107, 'Woolen Scarf', 30),
(104, 'Sneakers', 10);

SELECT * FROM Warehouse_Inventory


--UPDATE (common product find )
select * from Warehouse_Inventory as I
inner join 
new_consigment as N
on I.ProductID=N.ProductID

--update on qunatity of product which is same 
update I
set I.Quantity=I.Quantity+N.Quantity
from Warehouse_Inventory as I
inner join 
new_consigment as N
on I.ProductID=N.ProductID

select * from Warehouse_Inventory

--new product 
select N.* from Warehouse_Inventory as I  --N.* is the the last execution 
right join 
new_consigment as N
on I.ProductID=N.ProductID
where I.ProductID is null

--insert 
insert into Warehouse_Inventory(ProductID, ProductName, Quantity) 
select N.* from Warehouse_Inventory as I  --N.* is the the last execution 
right join 
new_consigment as N
on I.ProductID=N.ProductID
where I.ProductID is null

select * from Warehouse_Inventory

--USE OF STORE PROCEDURE 
CREATE PROCEDURE UPSERT
AS
BEGIN 

update I
set I.Quantity=I.Quantity+N.Quantity
from Warehouse_Inventory as I
inner join 
new_consigment as N
on I.ProductID=N.ProductID

insert into Warehouse_Inventory(ProductID, ProductName, Quantity) 
select N.* from Warehouse_Inventory as I  --N.* is the the last execution 
right join 
new_consigment as N
on I.ProductID=N.ProductID
where I.ProductID is null

END 

--DROP BOTH TABLE AND CREATE ONCE AGAIN TO EXEC
exec UPSERT

select * from Warehouse_Inventory

--MERGE COMMAND (merging andd inserting operation on same time )
MERGE Warehouse_Inventory AS target
USING new_consigment AS source
ON target.ProductID = source.ProductID
WHEN MATCHED THEN
    UPDATE SET target.Quantity = target.Quantity + source.Quantity
WHEN NOT MATCHED BY TARGET THEN
    INSERT (ProductID, ProductName, Quantity)
    VALUES (source.ProductID, source.ProductName, source.Quantity);

select * from Warehouse_Inventory

