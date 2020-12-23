-- % = any # characters, _ = one character

--Find any client's who are an LLC
SELECT *
FROM client
WHERE client_name LIKE '%LLC';

--Find any branch supplies who are in the label business
SELECT *
FROM branch_supplier
where supplier_name LIKE '%Label%';

--Find any employee born in October
SELECT *
FROM employee
WHERE birth_day LIKE '____-10%';

--Find any clients who are schools
SELECT *
FROM client
WHERE client_name LIKE '%school%';
