-- Create Employee_Training Table
CREATE TABLE Employee_Training (
    emp_id INT PRIMARY KEY,
    emp_name VARCHAR(50),
    dept_id VARCHAR(10),
    
);

-- Insert Data into Employee_Training
INSERT INTO Employee_Training (emp_id, emp_name, dept_id) VALUES
(101, 'Alice', 'D1'),
(102, 'Bob', 'D1'),
(103, 'Carol', 'D2'),
(104, 'David', 'D2'),
(105, 'Eva', 'D1'),
(106, 'Faisal', 'D3'),
(107, 'Gita', 'D3'),
(108, 'Hema', 'D3');

-- Create Training_Score Table
CREATE TABLE Training_Score (
    emp_id INT,
    score INT
);

-- Insert Data into Training_Score
INSERT INTO Training_Score (emp_id, score) VALUES
(101, 85),
(102, 92),
(103, 88),
(104, 91),
(105, 92),
(106, 80),
(107, 95),
(108, 95);

select * from Employee_Training
select * from Training_Score 

--Q.show employee who score maximum marks 
--step1-find maximum scroe from taining page 
--step2-emp id from that corresponding score 
--step3-employe detail from that 
--emp_id emp_name dept-id
--emp_id score

select * from Employee_Training where emp_id in (
select emp_id from Training_Score 
where score=(select Max(score)  from Training_Score ))


--details of student who score max marks 
select * from student where Marks =( 
select max(Marks) from STUDENT )

select top 1 * from STUDENT order by Marks desc   --method 2

--details of the student who score in the range of average+5 and avg-5 

select avg(Marks )+5 from STUDENT 
select avg(Marks )-5 from STUDENT 

select * from STUDENT where Marks between (select avg(Marks )-5 from STUDENT ) and (select avg(Marks )+5 from STUDENT )

--second highest scorer details 
select Top 1 * from (
select top 2 * from STUDENT order by Marks  desc)t order by Marks 
-----------------------------------------------)t mandatory any alphbet 

--find the student who score more than UP student but are not from UP
select * from STUDENT where Marks > all  (    --ANY AND ALL 
select Marks  from STUDENT where States ='UP')

--ALL -means the condition must be true for all the value 
--ANY-means the condition must ture for atleast one value


--assignment

-- Table: employees
CREATE TABLE employees (
    emp_id INT,
    emp_name VARCHAR(50),
    age INT,
    gender CHAR(1),
    department VARCHAR(50),
    city VARCHAR(50)
);

-- Table: training_Q1
CREATE TABLE training_Q1 (
    emp_id INT,
    training_name VARCHAR(50),
    training_score INT
);

-- Table: training_Q2
CREATE TABLE training_Q2 (
    emp_id INT,
    training_name VARCHAR(50),
    training_score INT
);

-- Insert into employees
INSERT INTO employees VALUES
(1, 'John Smith', 34, 'M', 'Tech', 'Delhi'),
(2, 'Nina J', 29, 'F', 'Tech', 'Mumbai'),
(3, 'Akash N', 41, 'M', 'HR', 'Delhi'),
(4, 'Kriti Shah', 25, 'F', 'HR', 'Kolkata'),
(5, 'Daniel K', 38, 'M', 'Finance', 'Mumbai'),
(6, 'Jaya P', 30, 'F', 'Tech', 'Chennai'),
(7, 'Anil', 33, 'M', 'HR', 'Delhi'),
(8, 'Zara Khan', 28, 'F', 'Finance', 'Delhi');

-- Insert into training_Q1
INSERT INTO training_Q1 VALUES
(1, 'Advanced SQL', 90),
(2, 'Advanced SQL', 55),
(3, 'Leadership', 80),
(4, 'Leadership', 70),
(5, 'Risk Mgmt', 60),
(6, 'Advanced SQL', 65),
(7, 'Leadership', 50),
(8, 'Risk Mgmt', 75);

-- Insert into training_Q2
INSERT INTO training_Q2 VALUES
(1, 'Data Analysis', 88),
(2, 'Ethics', 78),
(3, 'Data Analysis', 82),
(4, 'Ethics', 60),
(5, 'Financial Modeling', 85),
(6, 'Ethics', 50),
(7, 'Data Analysis', 48),
(8, 'Financial Modeling', 92);


select * from employees
select * from training_Q1 
select * from training_Q2 

--Find names of employees whose name start with a vowel and scored less than 60 in Q2.
select * from employees where emp_id in (
select emp_id from training_Q2 where training_score < 60) and
emp_name like '[aeiou]%' 

--Find employees who scored above 70 in both Q1 and Q2.

select * from employees where emp_id in (
select emp_id from training_Q1 where training_score  >70
intersect
select emp_id from training_Q2 where training_score > 70)

--List employees who appeared in either Q1 or Q2 but not both.
select * from employees where emp_id in( 
select emp_id from 
((select * from training_Q1  
union 
select * from training_Q2)
except
(select * from training_Q1
intersect
select * from training_Q2 ))u)
--List names of employees who did not appear in Q1.
select * from employees  where emp_id not in (
select emp_id  from training_Q1 )
--Find employees from the 'Tech' department who have lower Q1 scores than the average of non-Tech employees.
select * from employees where emp_id in (
 
select emp_id  from training_Q1 where Training_Score <(
select AVG(Training_Score) from ( 
select * from training_Q1 where emp_id in (
select emp_id  from employees where department <>'Tech'))y)
)
and department ='Tech'

--Find employee names who had any score in Q1 greater than all scores in Q2.
select * from employees where emp_id in (
select emp_id  from training_Q1  where training_score > (
select max(training_score) from training_Q2 ))

--Find all employees who trained in both 'Leadership' and 'Ethics' in any quarter.
select * from employees where emp_id in (
select emp_id from (
select *  from training_Q1
union all
select * from training_Q2)h where training_name='Leadership' or training_name='Ethics')


--Find names of employees who had ‘SQL’ in the training name in Q1 or Q2.
select * from employees where emp_name like '%\_%' escape '\'
--Find employee names from Delhi whose score in any training is lower than at least one female employee from another city.
select * from (
select *  from training_Q1
union all
select * from training_Q2
)h where emp_id in (
select emp_id from employees where  city='Delhi')h
where training_score <(
select top 1  h.training_score  from (
select *  from training_Q1
union all
select * from training_Q2)h where emp_id in ( 

select emp_id  from employees where gender ='F' and city <>'Delhi') order by training_score asc 
)


