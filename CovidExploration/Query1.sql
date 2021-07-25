SELECT *
FROM CovidProject..CovidDeaths
ORDER BY 3,4

--Data had been pre grouped by continent creating duplicates, selecting only countries
SELECT *
FROM CovidProject..CovidDeaths
WHERE continent is not null
ORDER BY 3,4

SELECT *
FROM CovidProject..CovidVaccinations
ORDER BY 3,4


--View key basic/key data fields
SELECT location,date, total_cases, new_cases, total_deaths, population
FROM CovidProject..CovidDeaths
ORDER BY 1,2

--Look at Total Deaths per Total Cases as DeathPercentage
SELECT location,date, total_cases, total_deaths,(total_deaths/total_cases)*100 AS DeathPercentage
FROM CovidProject..CovidDeaths
ORDER BY 1,2

--DeathPercentage for US
SELECT location,date, total_cases, total_deaths,(total_deaths/total_cases)*100 AS DeathPercentage
FROM CovidProject..CovidDeaths
WHERE location like '%states%'
ORDER BY 1,2

--Total Cases vs Population for US
SELECT location,date, total_cases, population,(total_cases/population)*100 AS PopPercentage
FROM CovidProject..CovidDeaths
WHERE location LIKE '%states%'
ORDER BY 1,2

--Finding each countries with highest infection percentage
SELECT location,population, MAX(total_cases) as PeakInfectionCount, MAX((total_cases/population))*100 AS PeakInfectionPercentage
FROM CovidProject..CovidDeaths
GROUP BY location, population
ORDER BY 4 desc

--Finding countries with highest death count
SELECT location, Max(cast(total_deaths as int)) AS TotalDeaths
From CovidProject..CovidDeaths
WHERE continent is not null
GROUP BY location
ORDER BY 2 DESC

--Continents with highest death count (2 ways)
SELECT location, Max(cast(total_deaths as int)) AS TotalDeaths
From CovidProject..CovidDeaths
WHERE continent is null
GROUP BY location
ORDER BY 2 DESC

SELECT continent, Max(cast(total_deaths as int)) AS TotalDeaths
FROM CovidProject..CovidDeaths
WHERE continent IS NOT NULL
GROUP BY continent
ORDER BY 2 DESC

--Continents

--Create column that shows change in infection rate from day to day
SELECT location,date, total_cases, new_cases_smoothed,
	ROUND(new_cases_smoothed - LAG(new_cases_smoothed,1) OVER(ORDER BY date), 0) AS RateNew_Cases
FROM CovidProject..CovidDeaths
WHERE location LIKE '%states%'
ORDER BY 1,2

--Create column that shows infection info grouped by week
SELECT location, DATEPART(week, date) as DateWeek, Sum(total_cases) as WeeklyCases, COUNT(total_cases) as CountCases
FROM CovidProject..CovidDeaths
WHERE location LIKE '%states%'
GROUP BY location, DATEPART(week, date)
ORDER BY DATEPART(week, date)
 --problem is it is grouping all "first week of the month" into same bucket
 --need to order/group by year, month, then week

--Create column that shows infection info grouped by month
SELECT location, DATEPART(YEAR, date) as DateYear, DATEPART(MONTH, date) as DateMonth,
Sum(total_cases) as MonthlyCases, COUNT(total_cases) as CountCases
FROM CovidProject..CovidDeaths
WHERE location LIKE '%states%'
GROUP BY location,DATEPART(YEAR, date), DATEPART(MONTH, date)
ORDER BY DATEPART(YEAR, date), DATEPART(MONTH, date)
--can't use total cases as that is a running total, grouping wouldn't show chases per month

--Summing using new cases group by year and month
SELECT location, DATEPART(YEAR, date) as DateYear, DATEPART(MONTH, date) as DateMonth,
Sum(new_cases) as MonthlyNewCases
FROM CovidProject..CovidDeaths
WHERE location LIKE '%states%'
GROUP BY location,DATEPART(YEAR, date), DATEPART(MONTH, date)
ORDER BY DATEPART(YEAR, date), DATEPART(MONTH, date)

--Use subquries to add new cases grouping by year and month
SELECT sub.location, DATEPART(YEAR, sub.date) as Year, sub.Month,
		SUM(sub.MonthCases) as NewCases
FROM (SELECT location, DATEPART(Month, date) as Month, date,Sum(new_cases) as MonthCases
		FROM CovidProject..CovidDeaths
		GROUP BY location,DATEPART(Month, date), date) sub
WHERE location LIKE '%states'
GROUP BY sub.location, DATEPART(YEAR, sub.date), sub.Month
ORDER BY location, DATEPART(YEAR, sub.date), sub.Month

--create column that shows change in percentage infection rate???
--need to use CTE, temp table, or subquries

WITH pop_perct AS(
	SELECT location, date, total_cases, population, (total_cases/population)*100 AS PopPercentage
	FROM CovidProject..CovidDeaths)
SELECT death.location, death.date, death.total_cases, death.population, pop.PopPercentage,
	pop.PopPercentage - LAG(pop.Poppercentage,1) OVER(ORDER BY death.date) AS ChangeInRate
FROM CovidProject..CovidDeaths death
JOIN pop_perct pop
ON death.location = pop.location AND death.date = pop.date
WHERE death.location LIKE '%states%'
ORDER BY 1,2
