--SOURCE:https://mode.com/sql-tutorial/sql-data-types/
--using schemas from "Mode Public Warehouse"

--CLEANING STRINGS

--Pull date using LEFT
SELECT incidnt_num,
     date,
     LEFT(date, 10) AS cleaned_date
FROM tutorial.sf_crime_incidents_2014_01

--Pull date using RIGHT and LENGTH
SELECT incidnt_num,
     date,
     LEFT(date, 10) AS cleaned_date,
     RIGHT(date, LENGTH(date) - 11) AS cleaned_time
FROM tutorial.sf_crime_incidents_2014_01

--Remove () using TRIM
SELECT location,
     TRIM(both '()' FROM location)
FROM tutorial.sf_crime_incidents_2014_01

--Find position of 'A' using POSITION
SELECT incidnt_num,
     descript,
     POSITION('A' IN descript) AS a_position
FROM tutorial.sf_crime_incidents_2014_01

--USING STRPOS
SELECT incidnt_num,
     descript,
     STRPOS(descript, 'A') AS a_position
FROM tutorial.sf_crime_incidents_2014_01

--Pull day using SUBSTR
SELECT incidnt_num,
     date,
     SUBSTR(date, 4, 2) AS day
FROM tutorial.sf_crime_incidents_2014_01

--EX1
/*Write a query that separates the `location`
field into separate fields for latitude and longitude.
You can compare your results against the actual
`lat` and `lon` fields in the table. */
SELECT location,
     TRIM(leading '(' FROM LEFT(location, POSITION(',' IN location) - 1)) AS lattitude,
     TRIM(trailing ')' FROM RIGHT(location, LENGTH(location) - POSITION(',' IN location) ) ) AS longitude
FROM tutorial.sf_crime_incidents_2014_01


--Combine strings using CONCAT
SELECT incidnt_num,
     day_of_week,
     LEFT(date, 10) AS cleaned_date,
     CONCAT(day_of_week, ', ', LEFT(date, 10)) AS day_and_date
FROM tutorial.sf_crime_incidents_2014_01

--EX2
/*Concatenate the lat and lon fields to form a field that
is equivalent to the location field.*/
SELECT CONCAT('(', lat, ', ', lon, ')') AS concat_location,
     location
FROM tutorial.sf_crime_incidents_2014_01

--Combine strings using ||
SELECT incidnt_num,
     day_of_week,
     LEFT(date, 10) AS cleaned_date,
     day_of_week || ', ' || LEFT(date, 10) AS day_and_date
FROM tutorial.sf_crime_incidents_2014_01

--EX3
--EX2 but using ||
SELECT '(' || lat || ', ' || lon || ')' AS concat_location,
     location
FROM tutorial.sf_crime_incidents_2014_01

--EX4
-- Write a query that creates a date column formatted YYYY-MM-DD.
SELECT incidnt_num,
     date,
     SUBSTR(date, 7, 4) || '-' || LEFT(date, 2) || '-' || SUBSTR(date, 4, 2) AS cleaned_date
FROM tutorial.sf_crime_incidents_2014_01

--Using UPPER and LOWER
SELECT incidnt_num,
     address,
     UPPER(address) AS address_upper,
     LOWER(address) AS address_lower
FROM tutorial.sf_crime_incidents_2014_01

--EX5
/*Write a query that returns the `category` field,
but with the first letter capitalized and the rest
of the letters in lower-case.*/
SELECT incidnt_num,
     category,
     UPPER(LEFT(category, 1)) || LOWER(RIGHT(category, LENGTH(category) - 1)) AS category_cleaned
FROM tutorial.sf_crime_incidents_2014_01

--EX6
/*Write a query that creates an accurate timestamp
using the date and time columns in tutorial.sf_crime_incidents_2014_01.
Include a field that is exactly 1 week later as well. */
SELECT incidnt_num,
       (SUBSTR(date, 7, 4) || '-' || LEFT(date, 2) ||
        '-' || SUBSTR(date, 4, 2) || ' ' || time || ':00')::timestamp AS timestamp,
       (SUBSTR(date, 7, 4) || '-' || LEFT(date, 2) ||
        '-' || SUBSTR(date, 4, 2) || ' ' || time || ':00')::timestamp
        + INTERVAL '1 week' AS timestamp_plus_interval
  FROM tutorial.sf_crime_incidents_2014_01

--Using EXTRACT
SELECT cleaned_date,
     EXTRACT('year'   FROM cleaned_date) AS year,
     EXTRACT('month'  FROM cleaned_date) AS month,
     EXTRACT('day'    FROM cleaned_date) AS day,
     EXTRACT('hour'   FROM cleaned_date) AS hour,
     EXTRACT('minute' FROM cleaned_date) AS minute,
     EXTRACT('second' FROM cleaned_date) AS second,
     EXTRACT('decade' FROM cleaned_date) AS decade,
     EXTRACT('dow'    FROM cleaned_date) AS day_of_week
FROM tutorial.sf_crime_incidents_cleandate

--Rounding dates using DATE_TRUNC
SELECT cleaned_date,
     DATE_TRUNC('year'   , cleaned_date) AS year,
     DATE_TRUNC('month'  , cleaned_date) AS month,
     DATE_TRUNC('week'   , cleaned_date) AS week,
     DATE_TRUNC('day'    , cleaned_date) AS day,
     DATE_TRUNC('hour'   , cleaned_date) AS hour,
     DATE_TRUNC('minute' , cleaned_date) AS minute,
     DATE_TRUNC('second' , cleaned_date) AS second,
     DATE_TRUNC('decade' , cleaned_date) AS decade
FROM tutorial.sf_crime_incidents_cleandate

--EX7
/*Write a query that counts the number of incidents reported by week.
Cast the week as a date to get rid of the hours/minutes/seconds.*/

SELECT DATE_TRUNC('week', cleaned_date)::date AS week_beginning,
       COUNT(*) AS incidents
  FROM tutorial.sf_crime_incidents_cleandate
 GROUP BY 1
 ORDER BY 1

 --Using COALESCE to fill NULLS
 SELECT incidnt_num,
     descript,
     COALESCE(descript, 'No Description')
FROM tutorial.sf_crime_incidents_cleandate
ORDER BY descript DESC
