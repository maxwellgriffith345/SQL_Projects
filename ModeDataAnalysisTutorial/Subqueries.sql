--SOURCE:https://mode.com/sql-tutorial/sql-data-types/
--using schemas from "Mode Public Warehouse"

--Basic Subquery
SELECT sub.*
FROM (
      SELECT *
        FROM tutorial.sf_crime_incidents_2014_01
       WHERE day_of_week = 'Friday'
     ) sub
WHERE sub.resolution = 'NONE'

--EX1
/*Write a query that selects all Warrant Arrests
from the tutorial.sf_crime_incidents_2014_01 dataset,
then wrap it in an outer query that only displays
unresolved incidents. */
SELECT sub.*
FROM (
      SELECT *
        FROM tutorial.sf_crime_incidents_2014_01
       WHERE descript = 'WARRANT ARREST'
     ) sub
WHERE sub.resolution = 'NONE'


--Find out how many incidents on average happen on each weekday per month
SELECT LEFT(sub.date, 2) AS cleaned_month,
     sub.day_of_week,
     AVG(sub.incidents) AS average_incidents
FROM (
      SELECT day_of_week,
             date,
             COUNT(incidnt_num) AS incidents
        FROM tutorial.sf_crime_incidents_2014_01
       GROUP BY 1,2
     ) sub
GROUP BY 1,2
ORDER BY 1,2

--EX2
/*Write a query that displays the average number of
monthly incidents for each category.*/

SELECT sub.category,
     AVG(sub.incidents) AS avg_incidents_per_month
FROM (
      SELECT EXTRACT('month' FROM cleaned_date) AS month,
             category,
             COUNT(1) AS incidents
        FROM tutorial.sf_crime_incidents_cleandate
       GROUP BY 1,2
     ) sub
GROUP BY 1

--Subqueires in conditional logic
SELECT *
  FROM tutorial.sf_crime_incidents_2014_01
 WHERE Date = (SELECT MIN(date)
                 FROM tutorial.sf_crime_incidents_2014_01
              )

--Using In
SELECT *
  FROM tutorial.sf_crime_incidents_2014_01
 WHERE Date IN (SELECT date
                 FROM tutorial.sf_crime_incidents_2014_01
                ORDER BY date
                LIMIT 5
              )

--Subqueires in Joins
SELECT *
  FROM tutorial.sf_crime_incidents_2014_01 incidents
  JOIN ( SELECT date
           FROM tutorial.sf_crime_incidents_2014_01
          ORDER BY date
          LIMIT 5
       ) sub
    ON incidents.date = sub.date

--Ranking results by how many incidents were reported in a given day
SELECT incidents.*,
       sub.incidents AS incidents_that_day
  FROM tutorial.sf_crime_incidents_2014_01 incidents
  JOIN ( SELECT date,
          COUNT(incidnt_num) AS incidents
           FROM tutorial.sf_crime_incidents_2014_01
          GROUP BY 1
       ) sub
    ON incidents.date = sub.date
 ORDER BY sub.incidents DESC, time

 --EX3
 /*Write a query that displays all rows from the three categories
 with the fewest incidents reported.*/
 SELECT incidents.*,
       sub.count AS total_incidents_in_category
  FROM tutorial.sf_crime_incidents_2014_01 incidents
  JOIN (
        SELECT category,
               COUNT(*) AS count
          FROM tutorial.sf_crime_incidents_2014_01
         GROUP BY 1
         ORDER BY 2
         LIMIT 3
       ) sub
    ON sub.category = incidents.category

--EX4
/*Write a query that counts the number of companies founded
and acquired by quarter starting in Q1 2012.
Create the aggregations in two separate queries, then join them.*/
SELECT COALESCE(companies.quarter, acquisitions.quarter) AS quarter,
       companies.companies_founded,
       acquisitions.companies_acquired
  FROM (
        SELECT founded_quarter AS quarter,
               COUNT(permalink) AS companies_founded
          FROM tutorial.crunchbase_companies
         WHERE founded_year >= 2012
         GROUP BY 1
       ) companies

  LEFT JOIN (
        SELECT acquired_quarter AS quarter,
               COUNT(DISTINCT company_permalink) AS companies_acquired
          FROM tutorial.crunchbase_acquisitions
         WHERE acquired_year >= 2012
         GROUP BY 1
       ) acquisitions

    ON companies.quarter = acquisitions.quarter
 ORDER BY 1

--Subqueires and UNION
SELECT COUNT(*) AS total_rows
  FROM (
        SELECT *
          FROM tutorial.crunchbase_investments_part1

         UNION ALL

        SELECT *
          FROM tutorial.crunchbase_investments_part2
       ) sub

--EX5
/*Write a query that ranks investors from the combined dataset
 above by the total number of investments they have made.*/
SELECT investor_name,
       COUNT(*) AS investments
  FROM (
        SELECT *
          FROM tutorial.crunchbase_investments_part1

         UNION ALL

         SELECT *
           FROM tutorial.crunchbase_investments_part2
       ) sub
 GROUP BY 1
 ORDER BY 2 DESC

 --EX6
 /*Write a query that does the same thing as in the previous
 problem, except only for companies that are still operating*/

SELECT investments.investor_name,
       COUNT(investments.*) AS investments
  FROM tutorial.crunchbase_companies companies
  JOIN (
        SELECT *
          FROM tutorial.crunchbase_investments_part1

         UNION ALL

         SELECT *
           FROM tutorial.crunchbase_investments_part2
       ) investments
    ON investments.company_permalink = companies.permalink
 WHERE companies.status = 'operating'
 GROUP BY 1
 ORDER BY 2 DESC
