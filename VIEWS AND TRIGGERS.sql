SELECT * FROM STUDENT

Go
CREATE VIEW ST_DL 
AS 
SELECT * FROM STUDENT WHERE States='DL'
go

SELECT * FROM ST_DL

--VIEW IS AN VIRTUAL TABLE, THAT DONT STORE AY DATA OF ITS OWN,RATHER IT IS JUST AN 
--SRORED SQL QUERY, THAT RETRIVES DATA FROM THE MAIN TABLE WHENEVER CALLED.

--SNAPSHOT OF DATA (VIRTUAL TABLE )

CREATE LOGIN login_dl WITH PASSWORD = 'dl@2025#';
create user user_dl for login login_dl;

grant select , update , delete on st_dl to user_dl

--check exixtence 
SELECT name 
FROM sys.server_principals
WHERE name = 'login_dl';

SELECT name 
FROM sys.database_principals
WHERE name = 'user_dl';

revoke delete on st_dl to user_dl 


--USE OF VIEW 

CREATE TABLE Patients (
    PatientID INT PRIMARY KEY,
    Name VARCHAR(100),
    PhoneNumber VARCHAR(15),
    Email VARCHAR(100)
);

DROP TABLE IF EXISTS Appointments;

CREATE TABLE Appointments (
    AppointmentID INT PRIMARY KEY,
    PatientID INT FOREIGN KEY REFERENCES Patients(PatientID),
    AppointmentDate DATE
);

INSERT INTO Patients (PatientID, Name, PhoneNumber, Email) VALUES
(1, 'Rohit Mehta', '9876543210', 'rohit.mehta@example.com'),
(2, 'Anita Sharma', '9123456780', 'anita.sharma@example.com'),
(3, 'Vikram Desai', '9001234567', 'vikram.desai@example.com'),
(4, 'Priya Reddy', '9988776655', 'priya.reddy@example.com'),
(5, 'Sahil Khan', '9876509876', 'sahil.khan@example.com');

INSERT INTO Appointments (AppointmentID, PatientID, AppointmentDate) VALUES
(101, 1, '2024-01-15'), -- 1 appointment only
(102, 2, '2023-12-20'), -- multiple appointments
(103, 2, '2024-03-20'),
(104, 3, '2025-01-10'), -- 1 appointment only
(105, 4, '2024-11-15'),
(106, 4, '2025-01-05'),
(107, 5, '2025-04-01'); -- 1 appointment only


GO 
CREATE VIEW TELLICALLER
AS

SELECT * FROM Patients WHERE PatientID IN (

SELECT P.PatientID FROM Patients P JOIN Appointments A
ON P.PatientID=A.PatientID
GROUP BY P.PatientID
HAVING COUNT(*)=1)

GO

SELECT * FROM TELLICALLER


-- TRIGGER
-- IS A SPECIAL KIND OF STORE PROCEDURE THAT AUTOMATICALLY GETS (FIRED) OR EXECUTES IN RESPONSE TO CERTAIN EVENT
-- ON A TABLE
GO
CREATE TRIGGER BACKUPS
ON STUDENT
AFTER DELETE
AS 
BEGIN 
SELECT * FROM deleted
SELECT * FROM inserted
END

SELECT * INTO STUDENT_BACKUP FROM STUDENT

TRUNCATE TABLE STUDENT_BACKUP

SELECT * FROM STUDENT_BACKUP



--STORE DELETED ON STUDENT_BACKUP  as backup 
go
CREATE OR ALTER TRIGGER BACKUPS
ON STUDENT
AFTER DELETE
AS
BEGIN
    INSERT INTO STUDENT_BACKUP
    SELECT * FROM DELETED
END

select * from ST_DL
select * from STUDENT

insert into student values
(51,'komal',99,22,null,'jh')

delete from STUDENT where Roll=51

select * from STUDENT
select * from STUDENT_BACKUP


--add detail on STUDENT_BACKUP who delete the data 
truncate table STUDENT_BACKUP
alter table STUDENT_BACKUP
add deleted_by varchar(20)
--TRIGGER FOR deletion 
go
CREATE OR ALTER TRIGGER BACKUP_D
ON STUDENT
AFTER DELETE
AS
BEGIN
    INSERT INTO STUDENT_BACKUP
    SELECT *,SYSTEM_USER,'deletion' FROM DELETED
END


-- TRIGGER FOR INSERTION
go
CREATE OR ALTER TRIGGER BACKUP_I
ON STUDENT
AFTER INSERT
AS
BEGIN
    INSERT INTO STUDENT_BACKUP
    SELECT *,SYSTEM_USER,'Insert' FROM INSERTED
END

drop trigger backups
truncate table STUDENT_BACKUP
alter table STUDENT_BACKUP
add action varchar(20)

select * from STUDENT_BACKUP

 exec sp_help student 

insert into student values
(52,'Shreya',48,20,	'f'	,'jh')
select * from STUDENT

drop trigger if exists  backups

-- TRIGGER ON UPDATE
go
CREATE or alter TRIGGER UPDATESTUDENT
ON STUDENT
AFTER UPDATE
AS
BEGIN
    INSERT INTO student_backup
    SELECT *, 'Updation-deletion', SYSTEM_USER FROM deleted

    INSERT INTO student_backup
    SELECT *, 'Updation-Insertion', SYSTEM_USER FROM inserted
END


select * from ST_DL

delete from ST_DL where roll=46

select * from STUDENT
insert into student values
(50,'Shreya',48,20,	'F'	,'WB')

select * from STUDENT_BACKUP

--DML TRIGGERS 
--AFTER THE DML COMMAND TRIGGERS
--INSTEAD OF DML COMMAND TRIGGER 
--IT REPLACE THE STANDARD ACTION (INSERT ,UPDATE ,DELETE ) AND DOES NOT EXECUTE THE ACTUAL OPERATION
--IT RUNS THE CUSTOM LOGIC 

--I WANT STOP DELETION OF ROWS FROM THE TABLE 
GO
CREATE OR ALTER TRIGGER STOP_DELETION 
ON STUDENT 
INSTEAD OF DELETE AS 
BEGIN 
INSERT INTO STUDENT_BACKUP
SELECT *,'TRIED TO DELETE',SYSTEM_USER FROM deleted
PRINT('YOU DONT HAVE ACCESS')
END 

--INSTEAD OF UPDATE 
GO
CREATE OR ALTER TRIGGER STOP_UPDATION 
ON STUDENT 
INSTEAD OF UPDATE AS 
BEGIN 
INSERT INTO STUDENT_BACKUP
SELECT *,'TRIED TO UPDATE',SYSTEM_USER FROM inserted
PRINT('YOU DONT HAVE ACCESS')
END 

select * from STUDENT_BACKUP


--EXAPLE OF DOUBLE ENTRY

create table main
(id int, role varchar(100), department varchar(10));
create table hr
(id int, department varchar(50) default 'hr');
create table fin
(id int, department varchar(50) default 'Finance');

SELECT * FROM main
SELECT * FROM hr
SELECT * FROM fin

go
create or alter  trigger multiple_insert 
on main 
instead of insert 
as 
begin 
    insert into main
    select * from inserted

    insert into hr(id)
    select id from inserted where department = 'hr'

    insert into fin(id)
    select id from inserted where department = 'finance'
end 


insert into main values
(1,'recruiter','HR'),
(2,'consulatnt','finance'),
(3,'analyst','R&D')