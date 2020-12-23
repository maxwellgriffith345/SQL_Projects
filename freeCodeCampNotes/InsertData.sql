SELECT * FROM student;

INSERT INTO student VALUES (1,'Jack', 'Biology');
INSERT INTO student VALUES (2, 'Kate', 'Sociology');
INSERT INTO student VALUES (3, 'Claire', 'Chemistry');
INSERT INTO student VALUES(4, 'Jack', 'Biology');
INSERT INTO student VALUES(5, 'Mike', 'CompSci');

INSERT INTO student(student_id, name) VALUES (3, 'Claire');



DROP TABLE student;

INSERT INTO student VALUES(3, NULL, 'Chemistry');

INSERT INTO student(student_id, name) VALUES(1, 'Jack');

INSERT INTO student(name, major) VALUES('Jack', 'Biology');
INSERT INTO student(name, major) VALUES('Kate', 'Sociology');
