-- Step 1: Create the table
CREATE TABLE student_hobby (
    roll INT,
    hobby VARCHAR(50)
);

select * from student_hobby
-- Step 2: Insert 15 rows (only even roll numbers)
INSERT INTO student_hobby (roll, hobby) VALUES
(1, 'Chess'),
(2, 'Painting'),
(3, 'Guitar'),
(4, 'Dancing'),
(5, 'Cricket'),
(6, 'Photography'),
(7, 'Swimming'),
(8, 'Programming'),
(9, 'Singing'),
(10, 'Football'),
(11, 'Reading'),
(12, 'Drawing'),
(13, 'Cooking'),
(14, 'Cycling'),
(15, 'Tennis'),
(16, 'Yoga'),
(17, 'Gardening'),
(18, 'Video Games'),
(19, 'Music'),
(20, 'Hiking'),
(21, 'Badminton'),
(22, 'Painting'),
(23, 'Dancing'),
(24, 'Chess'),
(25, 'Photography'),
(26, 'Swimming'),
(27, 'Programming'),
(28, 'Singing'),
(29, 'Reading'),
(30, 'Cooking'),
(31, 'Cycling'),
(32, 'Tennis'),
(33, 'Yoga'),
(34, 'Gardening'),
(35, 'Video Games'),
(36, 'Music'),
(37, 'Hiking'),
(38, 'Badminton'),
(39, 'Painting'),
(40, 'Dancing'),
(41, 'Chess'),
(42, 'Photography'),
(43, 'Swimming'),
(44, 'Programming'),
(45, 'Singing'),
(46, 'Reading'),
(47, 'Cooking'),
(48, 'Cycling'),
(49, 'Tennis'),
(50, 'Yoga');

SELECT * FROM student_hobby 


--JOINS
--1.INNER JOIN 
--Returns only the rows that have matching values in both tables.

SELECT * FROM STUDENT AS S1 
INNER JOIN 
 student_hobby AS S2
ON S1.roll=S2.roll

--2.LEFT JOIN (LEFT OUTER JOIN)
--Returns all rows from the left table and the matched rows from the right table.
--If there is no match, NULL is returned for right table columns.
select *from STUDENT s1
left join 
student_hobby s2
on s1.Roll =s2.roll 
--3. RIGHT JOIN (RIGHT OUTER JOIN)
--Returns all rows from the right table and the matched rows from the left table.
--If there is no match, NULL is returned for left table columns.
select *from STUDENT s1
right join 
student_hobby s2
on s1.Roll =s2.roll 
--4. FULL JOIN (FULL OUTER JOIN)
--Returns all rows when there is a match in either left or right table.
--If there is no match, NULL fills the missing side.
select *from STUDENT s1
full join  
student_hobby s2
on s1.Roll =s2.roll 

--6. SELF JOIN
--A table joined with itself (useful for hierarchical data).
select * from STUDENT as a
join 
student as b
on a.States=b.States
and a.Roll<>b.Roll


--find name and marks of the student whose marks are higher than the average marks of students from theri states 
     --find student averge marks state wise
     --join the table with student table 
select * from (
select States ,avg(Marks )as 'average'from STUDENT group by States ) as t1
inner join
STUDENT t2
on t1.States =t2.States
where average <Marks 

--display each states with its average marks but only for states having more than 2 students order by average marks desc
select States ,avg(Marks)as'avg_marks' from STUDENT group by States 
having count(*)>2
order by avg_marks desc


--find student and hobbies who have the same hobby as atleast one another student 
           --find count of hobby
select hobby ,count(*) from student_hobby group by hobby

select * from STUDENT t1
right join
student_hobby t2
on t1.Roll=t2.roll

select * from student_hobby

select * from STUDENT
select * from student_hobby 

--Show hobbies that are shared by students from more than 1 different states.

select h.hobby ,count(states) from STUDENT s --one part
inner join 
student_hobby h 
on s.Roll=h.roll
group by h.hobby--part one end 
having count(states)>1

--Find students who have the same marks as another student from a different state. (SELF JOIN)
select * from STUDENT s1
inner join STUDENT s2
on s1.Marks=s2.Marks
where  s1.States<>s2.States
--Find names of students who share a hobby with someone from a different state.
--CORELATE SUBQUERY its a query that depend on outer query for its value

select * from student s1
join 
student_hobby h1 on h1.roll=s1.Roll
where h1.hobby in

(select h2.Hobby from STUDENT s2
join student_hobby h2 on 
s2.Roll=h2.roll
where s1.States<>s2.States
)

--Find states where the average marks of females are higher than that of males.
select m.States from (
select States ,AVG(marks)as'average' from STUDENT where Gender='M' group by States) m
join 
(select States ,AVG(marks)as'faverge' from STUDENT where Gender='f' group by States) f
on m.States=f.States
where m.average<f.faverge
--List students whose hobbies are entirely unique (no one else has the same hobby).
