/*

Queries used for Tableau Dashboard "COVID-19 Data Visualization" by Kalcent Rabbi Santiago

List of the Visualizations:
1. Global Numbers
2. Total Death Per Continent
3. Percent Population Infected per Country
4. Percent Population Infected

Dataset Information:
Source: https://ourworldindata.org/covid-deaths
Dataset date: JAN 01,2020 - APR 30, 2021

*/


-- 1. Global Numbers
-- Shows the Total Cases, Total Deaths and Death Percentage 

SELECT SUM(new_cases) AS total_cases, SUM(CAST(new_deaths AS int)) as total_deaths, SUM(CAST(new_deaths AS int))/SUM(New_Cases)*100 AS DeathPercentage
FROM PortfolioProject..CovidDeaths
WHERE continent is not null 
ORDER BY 1,2


-- 2. Total Death Per Continent
-- Shows the TotalDeathCount of each continent using the OWID data excluding 'World', 'European Union', and 'International' for consistency

SELECT location, SUM(CAST(new_deaths AS int)) as TotalDeathCount
FROM PortfolioProject..CovidDeaths
WHERE continent IS NULL AND location NOT IN ('World', 'European Union', 'International')
GROUP BY location
ORDER BY TotalDeathCount desc


-- 3. Percent Population Infected per Country
-- Shows the percentage of the population of each country being infected 

SELECT location, population, MAX(total_cases) AS HighestInfectionCount,  MAX((total_cases/population))*100 AS PercentPopulationInfected
FROM PortfolioProject..CovidDeaths
GROUP BY location, population
ORDER BY PercentPopulationInfected desc


-- 4. Percent Population Infected
-- Shows the daily percentage of the population of each country being infected 

SELECT location, population,date, MAX(total_cases) AS HighestInfectionCount,  MAX((total_cases/population))*100 AS PercentPopulationInfected
FROM PortfolioProject..CovidDeaths
GROUP BY location, population, date
ORDER BY PercentPopulationInfected desc

