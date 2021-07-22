--SELECT *
--FROM PortfolioProject..CovidDeaths
--ORDER BY 3,4

--Data had been pre grouped by continent creating duplicates, selecting only countries
--SELECT *
--FROM PortfolioProject..CovidDeaths
--WHERE continent is not null
--ORDER BY 3,4

--SELECT *
--FROM PortfolioProject..CovidVaccinations
--ORDER BY 3,4


--View key basic/key data fields
--SELECT location,date, total_cases, new_cases, total_deaths, population
--FROM PortfolioProject..CovidDeaths
--ORDER BY 1,2

--Look at Total Deaths per Total Cases as DeathPercentage
--SELECT location,date, total_cases, total_deaths,(total_deaths/total_cases)*100 AS DeathPercentage
--FROM PortfolioProject..CovidDeaths
--ORDER BY 1,2

--DeathPercentage for US
--SELECT location,date, total_cases, total_deaths,(total_deaths/total_cases)*100 AS DeathPercentage
--FROM PortfolioProject..CovidDeaths
--WHERE location like '%states%'
--ORDER BY 1,2

--Total Cases vs Population for US
--SELECT location,date, total_cases, population,(total_cases/population)*100 AS PopPercentage
--FROM PortfolioProject..CovidDeaths
--WHERE location LIKE '%states%'
--ORDER BY 1,2

--Finding each countries with highest infection percentage
--SELECT location,population, MAX(total_cases) as PeakInfectionCount, MAX((total_cases/population))*100 AS PeakInfectionPercentage
--FROM PortfolioProject..CovidDeaths
--GROUP BY location, population
--ORDER BY 4 desc

--Finding countries with highest death count
--SELECT location, Max(cast(total_deaths as int)) AS TotalDeaths
--From PortfolioProject..CovidDeaths
--WHERE continent is not null
--GROUP BY location
--ORDER BY 2 DESC

--Continents with highest death count (2 ways)
--SELECT location, Max(cast(total_deaths as int)) AS TotalDeaths
--From PortfolioProject..CovidDeaths
--WHERE continent is null
--GROUP BY location
--ORDER BY 2 DESC

--SELECT continent, Max(cast(total_deaths as int)) AS TotalDeaths
--FROM PortfolioProject..CovidDeaths
--WHERE continent IS NOT NULL
--GROUP BY continent
--ORDER BY 2 DESC

--Continents 