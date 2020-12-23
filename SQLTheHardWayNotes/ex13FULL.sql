CREATE TABLE person(
  id INTEGER PRIMARY KEY,
  first_name TEXT,
  last_name TEXT,
  age INTEGER,
  dead INTEGER,
  phone_number INTEGER,
  salary FLOAT,
  dob DATETIME
);

CREATE TABLE pet(
  id INTEGER PRIMARY KEY,
  name TEXT,
  breed TEXT,
  age TEXT,
  dead INTEGER,
  dob DATETIME,
  parent_id INTEGER
);

CREATE TABLE person_pet(
  person_id INTEGER,
  pet_id INTEGER,
  purchased_on DATETIME
);

INSERT INTO person(id, first_name, last_name, age,dead,phone_number,salary,dob)
    VALUES(0, 'Zed', 'Shaw', 37, 0, 8421212, 102.5,  '01-01-2020');

INSERT INTO pet(id, name, breed, age, dead, dob, parent_id)
    VALUES(0, 'Fluffy', 'Unicorn',100, 0, '2008', 2);
INSERT INTO pet VALUES(1, 'Gigantor', 'Robot',1,0, '2020', 2);
INSERT INTO pet VALUES(2, 'BigPaPa', 'Wofl', 23, 0, '2005', 4);

INSERT INTO person_pet(person_id, pet_id, purchased_on)
VALUES(0,0,2008);
INSERT INTO person_pet VALUES(0,1,2020);
INSERT INTO person_pet VALUES (0, 2, 2005);
