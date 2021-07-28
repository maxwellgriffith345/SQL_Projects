SELECT *
FROM CovidProject..CovidVaccinations

--Join Deaths and Vaccinations
SELECT *
FROM CovidProject..CovidDeaths Death
JOIN CovidProject..CovidVaccinations Vax
ON Death.location = Vax.location
AND Death.date = Vax.date

--Looking at Total Population VS Vaccination
SELECT Death.continent, Death.location, Death.date, Death.population, Vax.new_vaccinations
FROM CovidProject..CovidDeaths Death
JOIN CovidProject..CovidVaccinations Vax
	ON Death.location = Vax.location
	AND Death.date = Vax.date
WHERE Death.continent is not null
ORDER BY 2,3 

--Create running total of new_vaccinations
SELECT Death.continent, Death.location, Death.date, Death.population, Vax.new_vaccinations,
	SUM(CAST(Vax.new_vaccinations as int)) 
	OVER (Partition by Death.location ORDER BY Death.date) As Total_Vax
FROM CovidProject..CovidDeaths Death
JOIN CovidProject..CovidVaccinations Vax
	ON Death.location = Vax.location
	AND Death.date = Vax.date
WHERE Death.continent is not null
ORDER BY 2,3   

--Create running total of new_vaccinations
SELECT Death.continent, Death.location, Death.date, Death.population, Vax.new_vaccinations,
	SUM(CAST(Vax.new_vaccinations as int)) 
	OVER (Partition by Death.location ORDER BY Death.date) As Total_Vax
FROM CovidProject..CovidDeaths Death
JOIN CovidProject..CovidVaccinations Vax
	ON Death.location = Vax.location
	AND Death.date = Vax.date
WHERE Death.continent is not null
ORDER BY 2,3 

-- USE CTE
WITH PopvsVax AS (
SELECT Death.continent, Death.location, Death.date, Death.population, Vax.new_vaccinations,
	SUM(CAST(Vax.new_vaccinations as int)) 
	OVER (Partition by Death.location ORDER BY Death.date) As Total_Vax
FROM CovidProject..CovidDeaths Death
JOIN CovidProject..CovidVaccinations Vax
	ON Death.location = Vax.location
	AND Death.date = Vax.date
WHERE Death.continent is not null)
Select *, (Total_Vax/Population)*100 AS PerctVax
FROM PopvsVax

--TEMP TABLE
DROP Table IF EXISTS #PerctPopVaxed
Create Table #PerctPopVaxed
(Continent nvarchar(255), Location nvarchar(255), Date datetime, Population numeric,
New_Vax numeric, Total_vax numeric) 

Insert INTO #PerctPopVaxed
SELECT Death.continent, Death.location, Death.date, Death.population, Vax.new_vaccinations,
	SUM(CAST(Vax.new_vaccinations as int)) 
	OVER (Partition by Death.location ORDER BY Death.date) As Total_Vax
FROM CovidProject..CovidDeaths Death
JOIN CovidProject..CovidVaccinations Vax
	ON Death.location = Vax.location
	AND Death.date = Vax.date
WHERE Death.continent is not null

Select *, (Total_Vax/Population)*100 AS PerctVax
FROM #PerctPopVaxed


--Creating View to store data for visualizations
Create View RunningTotalVax AS
SELECT Death.continent, Death.location, Death.date, Death.population, Vax.new_vaccinations,
	SUM(CAST(Vax.new_vaccinations as int)) 
	OVER (Partition by Death.location ORDER BY Death.date) As Total_Vax
FROM CovidProject..CovidDeaths Death
JOIN CovidProject..CovidVaccinations Vax
	ON Death.location = Vax.location
	AND Death.date = Vax.date
WHERE Death.continent is not null

Select * FROM RunningTotalVax