--Basic Statistics:

--What is the total number of COVID deaths in the dataset?

select sum(total_deaths) as total_covid_death
from CovidDeath


--What is the total number of COVID vaccinations administered?

select sum(total_vaccinations) as total_vaccinations_administered
from CovidVaccinations





--Geographical Insights:

--How many countries are included in the dataset for COVID deaths and vaccinations?

select count(DISTINCT location) as number_of_countries
from CovidDeath


--Can you list the continents present in the dataset for both tables?



select continent as common_continents 
from CovidDeath 
intersect
select continent
from CovidVaccinations

--Temporal Analysis:
--What is the earliest and latest date for which we have data on COVID deaths?
select min(date) as earliest_death, max(date)as latest_date
from CovidDeath

--What is the earliest and latest date for which we have data on COVID vaccinations?
select min(date) as earliest_death, max(date)as latest_date
from CovidVaccinations
where people_vaccinated is not null

--Population Analysis:
--What is the average population across all locations in the COVID deaths dataset?
select cast  (avg(population) as  int) AS average_population
from CovidDeath

--Can you find the location with the highest population in the COVID deaths dataset?
select top 1 location,population
from CovidDeath
where population = (select max(population) from CovidDeath )



--COVID Cases and Deaths:

--What is the total number of COVID cases and deaths reported for each location?
select location , 
		sum(total_cases) as Total_COVID_case ,
		sum(total_deaths) as Total_COVID_deaths
from CovidDeath
group by location
order by Total_COVID_case desc 

--Can you find the location with the highest total deaths?

select top 1 location,total_deaths
from CovidDeath
where total_deaths =(select max(total_deaths) from CovidDeath)



--Vaccination Metrics:

--What is the total number of vaccinations administered in each location?

select sum(total_vaccinations) as number_of_vaccinations
from CovidVaccinations

--Can you calculate the percentage of the population vaccinated for each location?
SELECT 
    d.location,
    ROUND(SUM(people_vaccinated) / AVG(population) * 100, 2) AS percentage_of_population_vaccinated
from CovidVaccinations v
join CovidDeath d
on d.iso_code = v.iso_code
group by d.location



--Testing Insights:
--What is the total number of COVID tests conducted in each location?

SELECT location, SUM(total_tests) AS total_tests
FROM CovidVaccinations
GROUP BY location

--Can you find the location with the highest positive rate in the COVID vaccinations dataset?

select location, positive_rate
from CovidVaccinations
where positive_rate =(select  max(positive_rate)from CovidVaccinations)



--Daily Trends:
--What is the average number of new COVID cases reported daily across all locations?

select location,avg(new_tests) as new_COVID_cases
from CovidVaccinations
group by location

--Can you identify the date with the highest number of new deaths?

select date,new_deaths
from CovidDeath
where new_deaths = (select max(new_deaths)from CovidDeath)



--Comparative Analysis:

--Is there a correlation between the total number of COVID deaths and vaccinations for each location?


select d.iso_code,d.location,d.total_deaths ,v.total_vaccinations
from CovidDeath d
JOIN CovidVaccinations v ON d.iso_code = v.iso_code
where v.total_vaccinations is not null


--How do the positive rates in COVID testing vary across different continents?

SELECT continent, AVG(positive_rate) AS average_positive_rate
FROM CovidVaccinations
GROUP BY continent

--Missing Data:
--Are there any missing values in important columns such as total_cases, total_deaths, total_vaccinations, etc.?
select COUNT(*) 
from CovidDeath
where total_cases is null or total_deaths is null 

select COUNT(*)
from CovidVaccinations
where total_vaccinations is null 

