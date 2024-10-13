use world;

-- Write a query to find all countries where the population is greater than the average population of all countries in the dataset.
select Name
from country
where Population > (select avg(Population) from country);

-- Write a query to find the top 5 most spoken languages in the world, along with their total number of speakers.
select `Language`, sum((country.Population*(countrylanguage.Percentage/100))) as totalSpeakingPopulation
from countrylanguage
inner join country
on countrylanguage.CountryCode = country.Code
group by `Language`
order by totalSpeakingPopulation desc
limit 5;

-- Write a query to calculate the population density (population / area) for each country, and return the country name along with its population density. Only include countries with a non-zero area.
select Name, Population/SurfaceArea as populationDensity
from country
where Population/SurfaceArea > 0;

-- Write a query to find all countries that do not have any cities listed in the cities table.
select country.Name, count(city.countryCode) as cityCount
from country
left join city
on city.countryCode = Country.Code
group by country.Name
having cityCount = 0;

-- Write a query to calculate the average life expectancy for each continent. Include the continent name in the result.
select Continent, avg(LifeExpectancy)
from country
group by Continent;

-- Write a query to find cities in countries that have a population within 10% of the population of 'Japan'. Display the city name, country name, and population.
-- there are no cities in the world that have a population with more than 10% of Japans population!
select *
from city
inner join (select Population/10 as Japan10pop
			from country
			where Name = 'Japan')
			as japan10poptable
where city.Population > japan10poptable.Japan10pop;

-- Write a query to rank countries by their GDP in descending order. Show the country name and its GDP, and add a rank column.
-- There are no column that represents GDP, but I asusme that GNP is meant!
select Name, GNP, dense_rank()
over (order by GNP desc) as `rank`
from country;

-- Write a query to find countries whose GDP is higher than that of any of their neighboring countries. Assume neighboring countries are defined by the neighbor relationship in the countries table.
-- As there are no neighbor collumn or table in my database, i assume it's a seperate table where every country is related to other countries based on a unique neighbor-id for every relationship which is displayed in the main countrytable.
select country.Name
from country
inner join neighborTable
on country.neighborid = neighborTable.neighborid
group by country.Name
;

-- Write a query to find the number of countries where each language is spoken. Show the language and the count of countries speaking that language, ordered by the count in descending order.
select countrylanguage.Language, count(`Name`) as count
from country
inner join countrylanguage
on countrylanguage.countryCode = country.Code
group by countrylanguage.Language
order by count desc;

-- Write a query to find all cities where the city population is greater than the average population of their respective countries. Show the city name, country name, and both populations.
select city.Name, city.Population, country.Name, countryAvgPopTable.CountryAvg
from city
inner join (select avg(Population) as CountryAvg, CountryCode
			from city
            group by CountryCode) as countryAvgPopTable
on city.CountryCode = countryAvgPopTable.CountryCode
inner join country
on country.Code = city.CountryCode
where city.Population > countryAvgPopTable.CountryAvg
