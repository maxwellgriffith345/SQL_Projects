

-- See all of Verstappen's 2021 Race Results
--Select * From Races Where DriverLast = "Verstappen" AND RaceDate > "2021"

--Which driver had the most points in 2021? Who won the WDC

SELECT DriverFirst, DriverLast, SUM(PTS) AS "Total Points"
     FROM Races
    WHERE RaceDate > '2021' GROUP BY   DriverLast
    ORDER BY 3 DESC

--Wich Team had the most points in 2021? Who won the constructors
Select Team, SUM(PTS) as "Total Points"
  From Races
  Where RaceDate > '2021'
  Group By Team
  ORDER BY 2 DESC

--What circuit has the most DNF of all time?
SELECT Circuit, COUNT(Retired) as "Total DNF"
  FROM Races
  WHERE Retired = "DNF"
  GROUP BY Circuit
  ORDER BY 2 DESC

--Find Total number of races per circuit for 2021
Select Circuit, Count(DISTINCT RaceDate) AS Count
    From Races
    Where RaceDate > 2021
    GROUP BY Circuit

--Find Total number of races per circuit
Select Circuit, Count(DISTINCT RaceDate) AS Count
    From Races
    GROUP BY Circuit
    ORDER BY 2 DESC

--What race has the most DNF % (#DNF at circuit/#Races at circuit)?
--Subquiries and CTE (WITH), Views

--Approach 1 Subquiries
Select sub.Circuit, sub.DNFCount, sub.RaceCount,
       ROUND((CAST(sub.DNFCount AS REAL)/CAST(sub.RaceCount AS REAL)),2) as DNFRatio
From (
    Select Circuit, COUNT(Retired) as DNFCount, Count(DISTINCT RaceDate) AS RaceCount
        From Races
        Where Retired = "DNF"
        GROUP BY Circuit
        ) sub
    GROUP BY 1
    Order BY 3 DESC
--Problems: is only counting races where a DNF happened. Does not count races w/o a DNF as part of "RaceCount"

--Approach 2: Using nested CTEs
WITH DNF AS (
    SELECT Circuit, COUNT(Retired) as "TotalDNF"
    FROM Races
    WHERE Retired = "DNF"
    GROUP BY Circuit
),

TotalRaces AS (

    SELECT Circuit, COUNT(DISTINCT RaceDate) AS "RaceCount"
    FROM Races
    GROUP BY Circuit
)
Select tr.Circuit, DNF.TotalDNF, tr.RaceCount
FROM TotalRaces tr
JOIN DNF
ON tr.Circuit = DNF.Circuit
Order BY 2 DESC
-- Get's the accurate RaceCount and DNF Count

--Add in the DNF/RaceCount column

WITH DNF AS (
    SELECT Circuit, COUNT(Retired) as "TotalDNF"
    FROM Races
    WHERE Retired = "DNF"
    GROUP BY Circuit
),

TotalRaces AS (

    SELECT Circuit, COUNT(DISTINCT RaceDate) AS "RaceCount"
    FROM Races
    GROUP BY Circuit
)
Select tr.Circuit, DNF.TotalDNF, tr.RaceCount,
    ROUND((CAST(DNF.TotalDNF as REAL)/CAST(tr.RaceCount as REAL)),2) as DNFRatio
FROM TotalRaces tr
JOIN DNF
ON tr.Circuit = DNF.Circuit
Order BY 2 DESC

--Using Views?
