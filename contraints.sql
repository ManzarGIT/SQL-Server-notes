--CONSTRAINTS
--1.NOT NULL ,2.PRIMARY KEY ,3.SECONDARY KEY ,4.FOREING KEY ,5.DEFAULT ,6.CHECK

--PRIMARY KEY
--any column that is made primary key will restrict duplicate and null value
--one primay key per table
--primary key can be defined on one or more than column 
--clustered index is created on creating primary key on same column 

--UNIQUE KEY 
--any column defined as unique will restrict the entry of duplicates
--there can be many unique key in table 
--non clustered index is created


--drop the constraints
--alter table table_name
--drop constraint contrainst value 

--name the constraint 
create table orders
(orderid int,
ordernumber int
constraint pk_order_orderid primary key (orderid),
constraint uq_order_ordernumber unique (ordernumber)
)


exec sp_help orders

--create primary key on existing table 
select * from STUDENT 
--priimary key should not have null 
exec sp_help student 
alter table student 
alter column roll int not null 

alter table student
add constraint xyz primary key(roll)

--NOT NULL 

create table employee
(empid int primary key ,
empname varchar(100) not null,
emp_mail varchar(50) ,
department varchar(50) not null)

exec sp_help employee 

insert into employee values
(1,'manjar','abchk','chemical')
insert into employee values  --will show error 
(1,null,'abchk','chemical')
insert into employee values  
(2,'abhi',null,'chemical')
select * from employee


--FOREIGN KEY 
--It is a field (or collection of field ) in one table that refer to primary key of other table 
--In simple terms:
--A foreign key in the child table points to the primary key of the parent table.
--It ensures that the value in the child table must exist in the parent table (this is called referential integrity).
-- Parent table: Flights

CREATE TABLE Flights (
    flight_id INT PRIMARY KEY,
    flight_number VARCHAR(20) NOT NULL,
    source VARCHAR(50),
    destination VARCHAR(50),
    departure_time DATETIME,
    arrival_time DATETIME
);

-- Child table: Passengers
CREATE TABLE Passengers (
    passenger_id INT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    age INT,
    seat_number VARCHAR(10),
    flight_id INT,
    FOREIGN KEY (flight_id) REFERENCES Flights(flight_id)
);
-- Insert into Flights table
INSERT INTO Flights (flight_id, flight_number, source, destination, departure_time, arrival_time)
VALUES
(1, 'AI101', 'Delhi', 'Mumbai', '2025-09-05 08:00:00', '2025-09-05 10:15:00'),
(2, 'AI202', 'Kolkata', 'Bangalore', '2025-09-05 12:30:00', '2025-09-05 15:45:00'),
(3, 'AI303', 'Chennai', 'Hyderabad', '2025-09-06 09:00:00', '2025-09-06 10:30:00'),
(4, 'AI404', 'Delhi', 'Dubai', '2025-09-07 18:00:00', '2025-09-07 21:00:00'),
(5, 'AI505', 'Mumbai', 'Singapore', '2025-09-08 22:00:00', '2025-09-09 04:00:00');

-- Insert into Passengers table
INSERT INTO Passengers (passenger_id, name, age, seat_number, flight_id)
VALUES
(101, 'Rahul Sharma', 29, '12A', 1),
(102, 'Anita Verma', 34, '14C', 2),
(103, 'Mohammed Ali', 41, '08B', 3),
(104, 'Priya Singh', 26, '02D', 4),
(105, 'John Mathew', 38, '21F', 5);

exec sp_help passengers 
exec sp_help flights

--ON DELETE CASCADE → Delete children when parent is deleted.
--ON UPDATE CASCADE → Update children when parent’s key changes.

--SYNTAX
--CREATE TABLE Passengers (
  --  passenger_id INT PRIMARY KEY,
    --name VARCHAR(100),
    --age INT,
    --seat_number VARCHAR(10),
    --flight_id INT,
    --FOREIGN KEY (flight_id) REFERENCES Flights(flight_id)
    --ON DELETE CASCADE
    --ON UPDATE CASCADE
--);


--ADD FOREIGN KEY ON EXISTING TABLE  
--SYNTAX
--ALTER TABLE Passengers
--ADD CONSTRAINT fk_flight_passenger
--FOREIGN KEY (flight_id)
--REFERENCES Flights(flight_id)
--ON DELETE CASCADE
--ON UPDATE CASCADE;

select * from Passengers
select * from STUDENT
select * from Flights

--DEFAULT CONSTRAINT
--default constraints are used to assign a default if nothing is inserted 
select * from employee
drop table employee


-- Create table
create table employees
(
    empid int primary key,
    empname varchar(100),
    deptid int,
    joiningdate date default getdate(),
    status varchar(20) constraint df_status default 'Active'
);


insert into employees (empid, empname, deptid) 
values (1, 'Ajay', 1);

select * from employees;

exec sp_help employees
--adding default constraints on existing table 

create table project 
(project_id int,
project_name varchar(50),
status varchar(50)
)
select * from project 

alter table project
add constraint m default 'pending ' for status 

EXEC sp_help project


    --CHECK CONSTRAINT
    --It restrict the value that can be inserted that can be inserted into particular column 
    --it insure that only those value inserted that follow a particuar rule
drop table employees 
create table employees
(
    empid int primary key,
    empname varchar(100),
    age int check (age >18 and age <60),
    salary  decimal (10,2),
    gender char(1) constraint mjr check (gender in ('m','f'))
);

select * from employees 

insert into employees values 
(1,'xycsh',23,86659,'f')
insert into employees values  --error due to age restriction 
(1,'xycsh',13,86659,'f')
insert into employees values  --error due to gender restriction 
(1,'xycsh',19,86659,'o')

--adding check constraint on existing column 
alter table employees
add constraint qwe check (salary<1000000)

--IDENTITY 
--INCREMENT OF VALUE AOTOMATIVALY 
--example ->empid int identity(1,1) 
