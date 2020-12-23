select * from employee;

--Find all employees
SELECT *
FROM employee;

--Find all clients
SELECT *
FROM client;

--Find all employees ordered by salary
SELECT *
FROM employee
ORDER BY salary DESC;

--Find all employees ordered by sex then name
SELECT *
FROM employee
ORDER BY sex, first_name, last_name;

-- Find the first 5 employees in the table
SELECT *
FROM employee
LIMIT 5;

-- Find the first and last names of all employees
SELECT first_name, last_name
FROM employee;

--Find the forename and surnames of all employees
SELECT first_name AS forename, last_name AS surname
FROM employee;

--Find out all the different genders
SELECT DISTINCT sex
FROM employee;

--Find all the different branch ids
SELECT DISTINCT branch_id
FROM employee; 
