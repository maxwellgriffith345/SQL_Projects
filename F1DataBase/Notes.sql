
--Creating the database?

--IMPORTING A CSV FILE
--https://www.sqlite.org/cli.html

--IN sqlite COMMAND LINE SHELL

--CHANGE 'MODE' TO CSV
.mode csv


--IMPORT CSV FILE
.import file_path table_name

--IF table_name DOES NOT EXIST THE FIRST ROW OF file WILL BE USED AS TO SET THE NAMES OF THE COLUMNS
--IF table_name DOES EXIST THE FIRST ROW WILL BE ASSUMED TO BE CONTENT

--CHANGE 'MODE' TO box FROM READABILITY
.mode column
.headers on
