-- Create Database                Roll no. 2501351020
CREATE DATABASE IF NOT EXISTS EXPERIMENT_1;

-- Use Database
USE EXPERIMENT_1;

-- Create Table
CREATE TABLE IF NOT EXISTS student (
    id INT PRIMARY KEY,
    name VARCHAR(50),
    age INT,
    course VARCHAR(50)
);

-- Describe Table
DESC student;

-- Add Column
ALTER TABLE student
ADD marks INT;

-- Modify Column
ALTER TABLE student
MODIFY name VARCHAR(100);

-- Use Database                                             || EXPERIMENT_2  ||
USE EXPERIMENT_1;

-- Insert Data
INSERT INTO student (id, name, age, course, marks) VALUES
(1, 'Rajveer', 20, 'BTech', 85),
(2, 'shruti', 21, 'BA', 90),
(3, 'veerraj', 19, 'B.Tech', 78),
(4, 'Badal', 19, 'B.Tech', 78);

-- Retrieve Data
SELECT * FROM student;

-- Update Data
UPDATE student
SET marks = 95
WHERE id = 2;

-- Delete Data
DELETE FROM student
WHERE id = 3;
                                                               -- || EXPERIMENT 3 |||

-- Step 1: Remove user if it already exists (to avoid error)
DROP USER IF EXISTS 'student_user'@'localhost';

-- Step 2: Create a new user with username and password
CREATE USER 'student_user'@'localhost' IDENTIFIED BY 'Rajveer123';

-- Step 3: Grant permissions (SELECT and INSERT) on EXPERIMENT_1 database
GRANT SELECT, INSERT ON EXPERIMENT_1.* TO 'student_user'@'localhost';

-- Step 4: Apply and refresh privileges
FLUSH PRIVILEGES;

-- Step 5: Revoke INSERT permission from the user
REVOKE INSERT ON EXPERIMENT_1.* FROM 'student_user'@'localhost';

-- Step 6: Check final permissions of the user (for verification)
SHOW GRANTS FOR 'student_user'@'localhost';


          -- || EXPERIMENT 4 : AGGREGATE FUNCTIONS ||

-- Step 1: Use Database
USE EXPERIMENT_1;

-- Step 2: Display Table Data
SELECT * FROM student;

-- Step 3: Find Minimum Marks
SELECT MIN(marks) AS Minimum_Marks FROM student;

-- Step 4: Find Maximum Marks
SELECT MAX(marks) AS Maximum_Marks FROM student;

-- Step 5: Find Total Marks
SELECT SUM(marks) AS Total_Marks FROM student;

-- Step 6: Find Average Marks
SELECT AVG(marks) AS Average_Marks FROM student;

-- Step 7: Count Total Students
SELECT COUNT(*) AS Total_Students FROM student;

SELECT 
    MIN(marks) AS Minimum_Marks,
    MAX(marks) AS Maximum_Marks,
    SUM(marks) AS Total_Marks,
    AVG(marks) AS Average_Marks,
    COUNT(*) AS Total_Students
FROM student;


                                  -- || EXPERIMENT 5 : CONDITIONS & SORTING ||

-- Use Database
USE EXPERIMENT_1;

-- Display All Data
SELECT * FROM student;

-- Condition: Marks Greater Than 80
SELECT * FROM student
WHERE marks > 80;

-- Sorting in Ascending Order
SELECT * FROM student
ORDER BY marks ASC;

-- Sorting in Descending Order
SELECT * FROM student
ORDER BY marks DESC;

-- Condition with Descending Sorting
SELECT * FROM student
WHERE marks > 80
ORDER BY marks DESC;

                                  -- || EXPERIMENT 6 : NATURAL JOIN & EQUI JOIN ||
        USE EXPERIMENT_1;
-- Create Table 1: student_id
CREATE TABLE student_id (
    id INT PRIMARY KEY,
    name VARCHAR(50),
    course VARCHAR(50)
);

-- Create Table 2: marks
CREATE TABLE marks (
    id INT,
    marks INT
);

-- Insert Data into student_id
INSERT INTO student_id VALUES
(1, 'Rajveer', 'BTech'),
(2, 'Badal', 'BTech'),
(3, 'Shruti', 'BA'),
(4, 'Aditya', 'BBA'),
(5, 'Shiv', 'BTech');

-- Insert Data into marks
INSERT INTO marks VALUES
(1, 85),
(2, 90),
(3, 78),
(4, 98),
(5, 88);

-- View Tables 
SELECT * FROM student_id; 
SELECT * FROM marks; 

-- NATURAL JOIN
SELECT * FROM student_id
NATURAL JOIN marks;

-- EQUI JOIN
SELECT student_id.id, student_id.name, student_id.course, marks.marks
FROM student_id
JOIN marks
ON student_id.id = marks.id;

                               -- || EXPERIMENT 7 : LEFT & RIGHT OUTER JOIN ||

-- Use Database
USE EXPERIMENT_1;

-- Drop tables if already exist (to avoid errors)
DROP TABLE IF EXISTS student_left;
DROP TABLE IF EXISTS marks_right;

-- Create Table 1: student_left
CREATE TABLE student_left (
    id INT PRIMARY KEY,
    name VARCHAR(50)
);

-- Create Table 2: marks_right
CREATE TABLE marks_right (
    id INT,
    marks INT
);

-- Insert Data into student_left
INSERT INTO student_left VALUES
(1, 'Rajveer'),
(2, 'Badal'),
(3, 'Shruti'),
(4, 'Aditya'),
(6, 'Shiv');

-- Insert Data into marks_right
INSERT INTO marks_right VALUES
(1, 85),
(2, 90),
(3, 78),
(5, 88);

-- LEFT OUTER JOIN
SELECT s.id, s.name, m.marks
FROM student_left s
LEFT JOIN marks_right m
ON s.id = m.id;

-- RIGHT OUTER JOIN
SELECT s.id, s.name, m.marks
FROM student_left s
RIGHT JOIN marks_right m
ON s.id = m.id;

												 -- || EXPERIMENT 8 : SELF JOIN ||

-- Use Database
USE EXPERIMENT_1;

-- Drop table if exists (to avoid error)
DROP TABLE IF EXISTS employee;

-- Create Table
CREATE TABLE employee (
    emp_id INT PRIMARY KEY,
    emp_name VARCHAR(50),
    manager_id INT
);

INSERT INTO employee VALUES
(1, 'Aarav', NULL),      -- Top manager
(2, 'Karan', 1),
(3, 'Neha', 1),
(4, 'Rohit', 2),
(5, 'Pooja', 2);

select * from employee;

-- SELF JOIN (Employee with Manager)
SELECT 
    e.emp_id AS Employee_ID,
    e.emp_name AS Employee_Name,
    m.emp_name AS Manager_Name
FROM employee e
LEFT JOIN employee m
ON e.manager_id = m.emp_id;