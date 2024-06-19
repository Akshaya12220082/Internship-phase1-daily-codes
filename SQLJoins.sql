--1. INNER JOIN
--This join returns records that have matching values in both tables.

SELECT A.column1, B.column2
FROM TableA A
INNER JOIN TableB B
ON A.common_column = B.common_column;

--2. LEFT JOIN (or LEFT OUTER JOIN)
--This join returns all records from the left table (TableA), and the matched records from the right table (TableB).
-- The result is NULL from the right side if there is no match.

SELECT A.column1, B.column2
FROM TableA A
LEFT JOIN TableB B
ON A.common_column = B.common_column;

--3. RIGHT JOIN (or RIGHT OUTER JOIN)
--This join returns all records from the right table (TableB), and the matched records from the left table (TableA).
-- The result is NULL from the left side when there is no match.

SELECT A.column1, B.column2
FROM TableA A
RIGHT JOIN TableB B
ON A.common_column = B.common_column;

--4. FULL JOIN (or FULL OUTER JOIN)
--This join returns all records when there is a match in either left (TableA) or right (TableB) table records.
-- The result is NULL from the side where there is no match.

SELECT A.column1, B.column2
FROM TableA A
FULL OUTER JOIN TableB B
ON A.common_column = B.common_column;

--5. CROSS JOIN
--This join returns the Cartesian product of the two tables, i.e.,
-- it combines each row of the first table with all rows of the second table.

SELECT A.column1, B.column2
FROM TableA A
CROSS JOIN TableB B;

--6. SELF JOIN
--This is a regular join, but the table is joined with itself.

SELECT A.column1, B.column2
FROM TableA A, TableA B
WHERE A.common_column = B.common_column;

--EXAMPLE
-- creating school database and has three tables students, courses, enrollments
-- Creating database
CREATE DATABASE school;

-- Using the database
USE school;

-- Creating Students table
CREATE TABLE Students (
    student_id INT PRIMARY KEY,
    student_name VARCHAR(100)
);

-- Creating Courses table
CREATE TABLE Courses (
    course_id INT PRIMARY KEY,
    course_name VARCHAR(100),
    instructor VARCHAR(100)
);

-- Creating Enrollments table
CREATE TABLE Enrollments (
    enrollment_id INT PRIMARY KEY,
    student_id INT,
    course_id INT,
    FOREIGN KEY (student_id) REFERENCES Students(student_id),
    FOREIGN KEY (course_id) REFERENCES Courses(course_id)
);

--Inserting data into the tables
-- Inserting data into Students table
INSERT INTO Students (student_id, student_name) VALUES
(1, 'John Doe'),
(2, 'Jane Smith'),
(3, 'Alice Johnson');

-- Inserting data into Courses table
INSERT INTO Courses (course_id, course_name, instructor) VALUES
(1, 'Math', 'Mr. Smith'),
(2, 'Physics', 'Dr. Brown'),
(3, 'Chemistry', 'Dr. Green');

-- Inserting data into Enrollments table
INSERT INTO Enrollments (enrollment_id, student_id, course_id) VALUES
(1, 1, 1),
(2, 1, 2),
(3, 2, 2),
(4, 3, 1),
(5, 3, 3);

--performing different joins
--1.INNER JOIN
SELECT Students.student_name, Courses.course_name
FROM Students
INNER JOIN Enrollments ON Students.student_id = Enrollments.student_id
INNER JOIN Courses ON Enrollments.course_id = Courses.course_id;

--2.LEFT JOIN
SELECT Students.student_name, Courses.course_name
FROM Students
LEFT JOIN Enrollments ON Students.student_id = Enrollments.student_id
LEFT JOIN Courses ON Enrollments.course_id = Courses.course_id;

--3.RIGHT JOIN
SELECT Students.student_name, Courses.course_name
FROM Students
RIGHT JOIN Enrollments ON Students.student_id = Enrollments.student_id
RIGHT JOIN Courses ON Enrollments.course_id = Courses.course_id;

--4.FULL OUTER JOIN
SELECT Students.student_name, Courses.course_name
FROM Students
FULL OUTER JOIN Enrollments ON Students.student_id = Enrollments.student_id
FULL OUTER JOIN Courses ON Enrollments.course_id = Courses.course_id;

--5.CROSS JOIN
SELECT Students.student_name, Courses.course_name
FROM Students
CROSS JOIN Courses;

--6.SELF JOIN
SELECT S1.student_name AS Student1, S2.student_name AS Student2, Courses.course_name
FROM Enrollments E1
INNER JOIN Enrollments E2 ON E1.course_id = E2.course_id AND E1.student_id < E2.student_id
INNER JOIN Students S1 ON E1.student_id = S1.student_id
INNER JOIN Students S2 ON E2.student_id = S2.student_id
INNER JOIN Courses ON E1.course_id = Courses.course_id;


