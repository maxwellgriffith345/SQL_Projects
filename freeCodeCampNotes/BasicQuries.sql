SELECT *
FROM student;

SELECT name, major
FROM student;

SELECT student.name, student.major
FROM student;

SELECT student.name, student.major
FROM student
ORDER BY name;

SELECT student.name, student.major
FROM student
ORDER BY name DESC;

SELECT *
FROM student
ORDER BY student_id DESC;

SELECT *
FROM student
ORDER BY major, student_id;

SELECT *
FROM student
LIMIT 2;

SELECT *
FROM student
ORDER BY student_id DESC
LIMIT 2;

SELECT *
FROM student
WHERE major = 'Biology';

SELECT name, major
FROM student
WHERE major = 'Biology' OR name = 'Kate';

-- comment
-- not equal no <>

SELECT name, major
FROM student
WHERE major <> 'Chemistry';


SELECT *
FROM student
WHERE name IN ('Claire', 'Kate', 'Mike');
