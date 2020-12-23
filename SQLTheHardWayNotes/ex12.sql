/*Only drop table if it exist */
DROP TABLE IF EXISTS person;

/*Create person again to work with it */
CREATE TABLE person (
  id INTEGER PRIMARY KEY,
  first_name TEXT,
  last_name TEXT,
  age INTEGER
);

/* Rename Table to peoples */
ALTER TABLE person RENAME TO peoples;

/* add hatered column*/
ALTER TABLE peoples ADD COLUMN hatred INTEGER;

/* Rname table back to person */
ALTER TABLE peoples RENAME TO person;

.schema person;

DROP TABLE person;
