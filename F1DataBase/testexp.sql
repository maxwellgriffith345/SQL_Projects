--SELECT * FROM Races limit 10

SELECT DriverFirst, DriverLast, SUM(PTS) AS "Total Points"
     FROM Races
    WHERE RaceDate > '2021' GROUP BY   DriverLast 
    ORDER BY 3 DESC 

