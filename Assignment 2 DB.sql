DROP DATABASE IF EXISTS training_center_db;
create database training_center_db ;
use training_center_db;
DROP TABLE IF EXISTS enrollments;
DROP TABLE IF EXISTS courses;
DROP TABLE IF EXISTS instructors;
DROP TABLE IF EXISTS students;
-- task1 create tables 
CREATE TABLE students (                      
 student_id INT AUTO_INCREMENT PRIMARY KEY,
full_name VARCHAR(100) NOT NULL,
email VARCHAR(100) NOT NULL UNIQUE,
age INT NOT NULL,
city VARCHAR(50) DEFAULT 'Riyadh',
created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
CONSTRAINT chk_student_age
CHECK (age BETWEEN 19 AND 23)
 );
 
insert into students(full_name, email, age, city)
values
('Norah Tariq','noratariq456@gmail.com',22,'Riyadh'),
('Razan Mohammed','razannn7@gmail.com',23,'Buraidah'),
('Sarah Abdulrahman','saraah22@gmail.com',21, 'Madinah'),
('Yara Abdullah ', 'yyara55a@gmail.com',20,'Shaqra'),
('Reem Mutlaq' , 'reemmut4@gmail.com',19,'Makkah' ),
('Rahaf Ibrahim','raahaf33@gmail.com',20,'Dammam'),
('Hanen Osama','hannnosa11@gmail.com',22,'Jeddah'),
('Hoor Saud' ,'hoorS41@gmail.com',23,'Jubail'),
('Lama Saad','laamsd@gmail.com', 21,'Shaqra'),
('Abeer Fahad ','abeer90@gmail.com', 19,'Al Kharj' );
SELECT
 CONCAT('T', LPAD(student_id, 3, '0')) AS trainee_id,
   student_id,
   full_name,            شيليه
  email,
  age,
   city
FROM students;
create table instructors(                         
instructor_id int auto_increment primary key,
full_name varchar(100) NOT NULL,
email varchar(100) NOT NULL unique,
specialty varchar(50) NOT NULL
);
INSERT INTO instructors (full_name, email, specialty)
VALUES
('Dr. Ahmed Alqahtani', 'ahmed.alqahtani@gmail.com', 'Database'),
('Dr. Maha Alotaibi', 'maha.alotaibi@gmail.com', 'Artificial Intelligence'),
('Eng. Faisal Alharbi', 'faisal.alharbi@gmail.com', 'Cybersecurity'),
('Eng. Nouf Alzahrani', 'nouf.alzahrani@gmail.com', 'Web Development'),
('Dr. Khalid Alenezi', 'khalid.alenezi@gmail.com', 'Software Development');
create table courses (                                           -- task3--
course_id int auto_increment primary key,
course_name VARCHAR(100) NOT NULL,
category VARCHAR(50) NOT NULL,
price DECIMAL(8,2) NOT NULL,
duration_hours INT NOT NULL,
start_date DATE NOT NULL,
instructor_id INT NOT NULL,
CONSTRAINT chk_course_price
CHECK (price BETWEEN 300 AND 3000),

CONSTRAINT chk_course_duration
CHECK (duration_hours BETWEEN 10 AND 80),

CONSTRAINT fk_course_instructor
FOREIGN KEY (instructor_id)
REFERENCES instructors(instructor_id)
);

INSERT INTO courses
(course_name, category, price, duration_hours, start_date, instructor_id)
VALUES
('Database Fundamentals','Database',1200,40,'2026-09-01',1),
('Java Programming','Programming',1500,45,'2026-09-10',2),
('Information Security','Cybersecurity',1800,50,'2026-09-15',3),
('Machine Learning','Artificial Intelligence',2200,60,'2026-10-01',2),
('Deep Learning','Artificial Intelligence',2500,70,'2026-10-10',2),
('Web Development','Programming',1400,35,'2026-10-20',4);

CREATE TABLE enrollments (

    enrollment_id INT AUTO_INCREMENT PRIMARY KEY,

    student_id INT NOT NULL,

    course_id INT NOT NULL,

    enrollment_date DATE NOT NULL,

    status VARCHAR(20) NOT NULL,

    grade DECIMAL(5,2),

    CONSTRAINT fk_enrollment_student
    FOREIGN KEY (student_id)
    REFERENCES students(student_id),

    CONSTRAINT fk_enrollment_course
    FOREIGN KEY (course_id)
    REFERENCES courses(course_id)

);

INSERT INTO enrollments
(student_id, course_id, enrollment_date, status, grade)
VALUES
(1,1,'2026-09-01','Completed',95),
(1,2,'2026-09-10','Completed',60),

(2,1,'2026-09-02','Completed',88),

(3,2,'2026-09-10','Completed',84),
(3,4,'2026-10-01','Active',NULL),

(4,3,'2026-09-15','Completed',90),

(5,4,'2026-10-01','Active',NULL),

(6,5,'2026-10-10','Active',NULL),

(7,1,'2026-09-01','Completed',78),
(7,3,'2026-09-15','Completed',81),

(8,2,'2026-09-10','Completed',86),

(9,5,'2026-10-10','Active',NULL),

(10,1,'2026-09-01','Completed',92),
(10,4,'2026-10-01','Active',NULL),
(10,5,'2026-10-10','Active',NULL);
-- task3--
-- CRUD Queries 
SELECT * FROM students;
SELECT * FROM courses;
SELECT * FROM enrollments;

-- Find students from Riyadh
SELECT *
FROM students
WHERE city = 'Riyadh';

-- Check the student before updating
SELECT *
FROM students
 WHERE student_id = 5;

-- Update student's city
UPDATE students
 SET city = 'Riyadh'
 WHERE student_id = 5;

-- Check after updating
 SELECT *
FROM students
 WHERE student_id = 5;

-- Check enrollment before deleting
SELECT *
FROM enrollments
 WHERE enrollment_id = 15;

-- Delete one enrollment
 DELETE FROM enrollments
WHERE enrollment_id = 15;

-- Check after deleting
SELECT *
fROM enrollments
WHERE enrollment_id = 15;

-- Restore deleted enrollment
INSERT INTO enrollments
(student_id, course_id, enrollment_date, status, grade)
VALUES
(10,5,'2026-10-10','Active',NULL);

-- Task 4: String Functions

-- Combine student name and city in one column
SELECT
CONCAT(full_name,' - ',city) AS student_info
FROM students;

-- Convert names to uppercase
SELECT
 UPPER(full_name) AS upper_name
 FROM students;

-- Convert emails to lowercase
 SELECT
LOWER(email) AS lower_email
 FROM students;

-- Extract the first 5 letters of the student's name
SELECT
 SUBSTRING(full_name,1,5) AS short_name
FROM students;

-- Replace Programming with Coding
 SELECT
REPLACE(category,'Programming','Coding') AS new_category
FROM courses;

-- Count the number of letters in each student's name
SELECT
full_name,
 CHAR_LENGTH(full_name) AS name_length
FROM students;

-- Task 5: Refining Selections

-- Show all unique course categories
 SELECT DISTINCT category
FROM courses;

-- Sort courses from highest price to lowest
 SELECT *
 FROM courses
ORDER BY price DESC;

-- Show the top 3 most expensive courses
 SELECT *
FROM courses
ORDER BY price DESC
LIMIT 3;

-- Find students whose names contain the letter 'a'
SELECT *
 FROM students
WHERE full_name LIKE '%a%';

-- Escaped wildcard was not used because the sample data
-- does not contain '_' or '%' characters.

-- Task 6: Aggregate Functions

-- Count the total number of students
SELECT COUNT(*) AS total_students
FROM students;

-- Count the number of enrollments per course
 SELECT
 course_id,
 COUNT(*) AS total_enrollments
FROM enrollments
GROUP BY course_id;

-- Calculate the average course price
 SELECT AVG(price) AS average_price
FROM courses;

-- Find the minimum course price
SELECT MIN(price) AS minimum_price
 FROM courses;

-- Find the maximum course price
SELECT MAX(price) AS maximum_price
FROM courses;
-- Group courses by category
SELECT
category,
 COUNT(*) AS total_courses
 FROM courses
 GROUP BY category;

-- Show only courses with more than one enrolled student
 SELECT
course_id,
 COUNT(*) AS total_students
FROM enrollments
GROUP BY course_id
HAVING COUNT(*) > 1;

-- task7 
-- Find courses with prices between 1000 and 2000
SELECT *
 FROM courses
WHERE price BETWEEN 1000 AND 2000;

-- Show courses in selected categories
SELECT *
FROM courses
WHERE category IN ('Programming','Database');

-- Find students using AND and OR
SELECT *
FROM students
WHERE (age > 20 AND city = 'Riyadh')
OR city = 'Shaqra';

-- Find enrollments without grades
 SELECT *
 FROM enrollments
 WHERE grade IS NULL;

-- Show grade status
SELECT
student_id,
course_id,
  grade,
CASE
 WHEN grade >= 90 THEN 'Excellent'
 WHEN grade >= 70 THEN 'Passed'
 WHEN grade < 70 THEN 'Failed'
 ELSE 'Not Graded'
  END AS grade_status
FROM enrollments;

-- task8--
-- describe students;
alter table students
add phone varchar(15);
 
 alter table students
 modify phone varchar(20);
 -- select * from students
 
 -- Make phone numbers unique
describe students;
 ALTER TABLE students
ADD CONSTRAINT uq_student_phone UNIQUE (phone);

-- Remove phone column
 ALTER TABLE students
DROP COLUMN phone;

-- Show table structure after ALTER
 DESCRIBE students;

-- task 9-- JOINS
-- Show students with their enrolled courses
SELECT
    s.full_name,
    c.course_name
FROM students s
INNER JOIN enrollments e
ON s.student_id = e.student_id
INNER JOIN courses c
ON e.course_id = c.course_id;


-- Show all students even if they are not enrolled
SELECT
    s.full_name,
    c.course_name
FROM students s
LEFT JOIN enrollments e
ON s.student_id = e.student_id
LEFT JOIN courses c
ON e.course_id = c.course_id;


-- Show all courses even if no student is enrolled
SELECT
    c.course_name,
    s.full_name
FROM enrollments e
RIGHT JOIN courses c
ON e.course_id = c.course_id
LEFT JOIN students s
ON e.student_id = s.student_id;



-- Display student, course, instructor and enrollment status
SELECT
    s.full_name,
    c.course_name,
    i.full_name AS instructor_name,
    e.status
FROM students s
JOIN enrollments e
ON s.student_id = e.student_id
JOIN courses c
ON e.course_id = c.course_id
JOIN instructors i
ON c.instructor_id = i.instructor_id;


-- Count students in each course
SELECT
    c.course_name,
    COUNT(e.student_id) AS total_students
FROM courses c
LEFT JOIN enrollments e
ON c.course_id = e.course_id
GROUP BY c.course_name;








-- task10-- viwe
-- Create a view for student enrollments
CREATE VIEW student_enrollments AS
SELECT
    s.full_name,
    c.course_name,
    e.status,
    e.grade
FROM students s
JOIN enrollments e
ON s.student_id = e.student_id
JOIN courses c
ON e.course_id = c.course_id;

-- Total students in each course with a grand total
SELECT
    category,
    COUNT(*) AS total_courses
FROM courses
GROUP BY category WITH ROLLUP;
-- Create a stored procedure to display all students
DELIMITER $$
CREATE PROCEDURE ShowStudents()
BEGIN
    SELECT *
    FROM students;
END $$

DELIMITER ;
-- Execute the stored procedure
CALL ShowStudents();

   -- Display all records from the view
SELECT *
FROM student_enrollments;

-- Display only completed enrollments
SELECT *
FROM student_enrollments
WHERE status = 'Completed';

-- Sort students by grade
SELECT *
FROM student_enrollments
ORDER BY grade DESC;

-- Update the view to include only active enrollments
CREATE OR REPLACE VIEW student_enrollments AS
SELECT
    s.full_name,
    c.course_name,
    e.status,
    e.grade
FROM students s
JOIN enrollments e
ON s.student_id = e.student_id
JOIN courses c
ON e.course_id = c.course_id
WHERE e.status = 'Active';
-- Display the updated view
SELECT *
FROM student_enrollments;