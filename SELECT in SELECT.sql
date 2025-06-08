-- 1. List each country name where the population is larger than that of 'Russia'. 
SELECT name 
FROM world
WHERE population > (
  SELECT population 
  FROM world
  WHERE name='Russia')

-- 2. Show the countries in Europe with a per capita GDP greater than 'United Kingdom'.
SELECT name
FROM world
WHERE continent= 'EUROPE'
AND gdp/population > (
  SELECT gdp/population 
  FROM world 
  WHERE name = 'United Kingdom');

-- 3. List the name and continent of countries in the continents containing either Argentina or Australia. Order by name of the country.
SELECT name, continent
FROM world
WHERE continent IN (
  SELECT continent 
  FROM world 
  WHERE name = 'Argentina' OR name = 'Australia')
ORDER BY name ASC;

-- 4. Which country has a population that is more than United Kingdom but less than Germany? Show the name and the population.
SELECT name, population
FROM world
WHERE population > (
  SELECT population 
  FROM world 
  WHERE name = 'United Kingdom')
AND population < (
  SELECT population 
  FROM world 
  WHERE name = 'Germany');

-- 5. Germany (population roughly 80 million) has the largest population of the countries in Europe. Austria (population 8.5 million) has 11% of the population of Germany. 
SELECT name, CONCAT(ROUND((population * 100.0 / (SELECT population FROM world WHERE name = 'Germany')), 0), '%') AS percentage
FROM world
WHERE continent = 'Europe' 
  AND population / (
  SELECT population 
  FROM world 
  WHERE name = 'Germany')

-- 6. Which countries have a GDP greater than every country in Europe? [Give the name only.] (Some countries may have NULL gdp values) 
SELECT name
FROM world
WHERE gdp >= 
  ALL(
  SELECT gdp 
  FROM world 
  WHERE continent = 'Europe' 
  AND gdp>0)
  AND (continent <> 'Europe')

-- 7. Find the largest country (by area) in each continent, show the continent, the name and the area: 
SELECT continent, name, area FROM world x
WHERE area >= 
  ALL(
  SELECT area 
  FROM world y
  WHERE y.continent=x.continent
  AND area>0)

-- 8. List each continent and the name of the country that comes first alphabetically.
SELECT x.continent, x.name
FROM world x
WHERE name <= 
  ALL(
  SELECT name 
  FROM world y
  WHERE y.continent = x.continent
  ORDER BY name ASC)

-- 9. Find the continents where all countries have a population <= 25000000. Then find the names of the countries associated with these continents. Show name, continent and population. 
SELECT name, continent, population 
FROM world x
WHERE 25000000>=
  ALL (
  SELECT population 
  FROM world y
  WHERE x.continent=y.continent
  AND population>0)

-- 10. Some countries have populations more than three times that of all of their neighbours (in the same continent). Give the countries and continents.
SELECT x.name, x.continent
FROM world x
WHERE x.population > 
  ALL(
  SELECT population*3
  FROM world y
  WHERE y.continent = x.continent
  AND x.name<>y.name)
