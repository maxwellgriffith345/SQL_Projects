ALTER TABLE person ADD COLUMN dead INTEGER;
ALTER TABLE person ADD COLUMN phone_number INTEGER;
ALTER TABLE person ADD COLUMN salary FLOAT;
ALTER TABLE person ADD COLUMN dob DATETIME;

ALTER TABLE pet ADD COLUMN dob DATETIME;
ALTER TABLE pet ADD COLUMN parent_id INTEGER;

ALTER TABLE person_pet ADD COLUMN purchased_on DATETIME;


UPDATE person SET dead = 0 WHERE id = 0;
UPDATE person SET phone_number = 8421212 WHERE id = 0;
UPDATE person SET salary = 102.5 WHERE id = 0;
UPDATE person SET dob = '01-01-2020' WHERE id = 0;

UPDATE pet SET dob = 2008 where id = 0;
UPDATE pet SET parent_id = 2 where id =0;

UPDATE pet SET dob = 2020 where id = 1;
UPDATE pet SET parent_id = 2 where id =1;

INSERT INTO pet VALUES(2, 'BigPaPa', 'Wofl', 23, 0, '2005', 4);

UPDATE person_pet SET purchased_on = 2020 where pet_id= 0;
UPDATE person_pet SET purchased_on = 2020 where pet_id = 1;

INSERT INTO person_pet VALUES (0,2,2005);
