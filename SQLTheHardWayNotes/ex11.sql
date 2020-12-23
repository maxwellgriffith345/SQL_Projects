/*should get error because id 0 is already taken */

INSERT INTO person (id, first_name, last_name, age)
      VALUES (0, 'Frank', 'Smith', 100);

INSERT OR REPALCE INTO person (id, frist_name, last_name, age)
      VALUES (0, 'Frank', 'Smith', 100);

SELECT * FROM person;

REPLACE INTO PERSON ......; 
