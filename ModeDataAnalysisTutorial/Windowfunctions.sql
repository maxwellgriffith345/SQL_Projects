--SOURCE:https://mode.com/sql-tutorial/sql-data-types/
--using schemas from "Mode Public Warehouse"

--Basic running total
SELECT duration_seconds,
     SUM(duration_seconds) OVER (ORDER BY start_time) AS running_total
FROM tutorial.dc_bikeshare_q1_2012

--Running total using PARTITION BY
SELECT start_terminal,
     duration_seconds,
     SUM(duration_seconds) OVER
       (PARTITION BY start_terminal ORDER BY start_time)
       AS running_total
FROM tutorial.dc_bikeshare_q1_2012
WHERE start_time < '2012-01-08'

--EX1
/*Write a query modification of the above example query
that shows the duration of each ride as a percentage of
the total time accrued by riders from each start_terminal */

SELECT start_terminal,
       duration_seconds,
       SUM(duration_seconds) OVER (PARTITION BY start_terminal) AS start_terminal_sum,
       (duration_seconds/SUM(duration_seconds) OVER (PARTITION BY start_terminal))*100 AS pct_of_total_time
  FROM tutorial.dc_bikeshare_q1_2012
 WHERE start_time < '2012-01-08'
 ORDER BY 1, 4 DESC


 --Window functions using SUM, COUNT, AVG
 SELECT start_terminal,
       duration_seconds,
       SUM(duration_seconds) OVER
         (PARTITION BY start_terminal ORDER BY start_time)
         AS running_total,
       COUNT(duration_seconds) OVER
         (PARTITION BY start_terminal ORDER BY start_time)
         AS running_count,
       AVG(duration_seconds) OVER
         (PARTITION BY start_terminal ORDER BY start_time)
         AS running_avg
  FROM tutorial.dc_bikeshare_q1_2012
 WHERE start_time < '2012-01-08'

 --EX2
 /*Write a query that shows a running total of the duration
 of bike rides (similar to the last example), but grouped by
 end_terminal, and with ride duration sorted in descending order.*/

SELECT end_terminal,
       duration_seconds,
       SUM(duration_seconds) OVER
         (PARTITION BY end_terminal ORDER BY duration_seconds DESC)
         AS running_total
  FROM tutorial.dc_bikeshare_q1_2012
 WHERE start_time < '2012-01-08'

 --ROW_NUMBER()
 SELECT start_terminal,
       start_time,
       duration_seconds,
       ROW_NUMBER() OVER (ORDER BY start_time)
                    AS row_number
  FROM tutorial.dc_bikeshare_q1_2012
 WHERE start_time < '2012-01-08'

 --ROW_NUMBER() wtih PARTITION BY
 SELECT start_terminal,
       start_time,
       duration_seconds,
       ROW_NUMBER() OVER (PARTITION BY start_terminal
                          ORDER BY start_time)
                    AS row_number
  FROM tutorial.dc_bikeshare_q1_2012
 WHERE start_time < '2012-01-08'

 --RANK() and DENSE_RANK()
 SELECT start_terminal,
       duration_seconds,
       RANK() OVER (PARTITION BY start_terminal
                    ORDER BY start_time)
              AS rank
  FROM tutorial.dc_bikeshare_q1_2012
 WHERE start_time < '2012-01-08'

 --EX3
 /*Write a query that shows the 5 longest rides from
 each starting terminal, ordered by terminal,
 and longest to shortest rides within each terminal.
 Limit to rides that occurred before Jan. 8, 2012. */

SELECT *
FROM (
      SELECT start_terminal,
             start_time,
             duration_seconds AS trip_time,
             RANK() OVER (PARTITION BY start_terminal ORDER BY duration_seconds DESC) AS rank
        FROM tutorial.dc_bikeshare_q1_2012
       WHERE start_time < '2012-01-08'
             ) sub
WHERE sub.rank <= 5
