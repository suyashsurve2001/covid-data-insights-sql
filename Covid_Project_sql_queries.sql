use CovidProject

select  *
from CovidDeath
where continent is not null
order by 1,2



 
--------------------------------------  Comparing the total number of cases(total_cases) to the total number of deaths(total_deaths)---------------------------------------------------------------
select 
	location,
	date, 
	total_cases,
	total_deaths,
	CAST(total_deaths as decimal(20,2))/CAST(total_cases as decimal(20,2)) *100.0 as Deaths_percentage
from CovidDeath
where location = 'india' and continent is not null
order by 1,2



-------------------------------------- Comparing the total number of cases(total_cases) to the population (population) show how many people got covid--------------------------------------


select 
	location,
	date, 
	total_cases,
	population,
	CAST(total_cases as decimal(20,2))/CAST(population as decimal(20,2)) *100.0 as  get_infected_percentage
from CovidDeath
where location = 'india' and continent is not null
order by 1,2


---------------------------------------looking at  countries with highest infection rate compared to population-------------------------------------------------------------------------------------
select 
	location,
	population,
	max(total_cases) as high_infected_count ,
    CAST(max(total_cases) as decimal(20,2))/CAST(population as decimal(20,2)) *100.0 as high_infected_percentage
from CovidDeath
where continent is not null
group by location,population
order by high_infected_percentage desc


---------------------------------------------------------------looking at  countries with highest death count per population-------------------------------------------------------------------------

select 
	  location,
	  cast(max(total_deaths) as int) as total_deaths_count
from CovidDeath
where continent is not null
group by location
order by 2 desc


------------------------------------------------------------showing continents with the hihest death count per population---------------------------------------------------------------------------

select 
	  continent,
	  location,
	  cast(max(total_deaths) as int) as total_deaths_count
from CovidDeath
where continent is not null
group by location,continent
order by total_deaths_count desc



--------------------------------------------------------------------glober number-------------------------------------------------------------------------------------------------------------------

select 
	--date, 
	sum(new_cases) as total_cases ,
	sum(cast(new_deaths as int)) as total_deaths,
	case
		when sum(new_cases) <> 0 then
			sum(cast(new_deaths as int))/ SUM(new_cases)*100
		else
			null
	end as Deaths_percentage_globale
from CovidDeath
where  continent is not null
--group by date
order by 1,2



------------------------------------------------joining CovidDeath table and CovidVaccinations table-----------------------------------------------------------------------------------------------





------------------------------------------------loking at total population and vaccinations--------------------------------------------------------------------------------------------------------

with population_vs_vaccinations (continent,location,date,population,new_vaccinations,vaccination_by_location) 
as
(

select 
	 dea.continent,
	 dea.location,
	 dea.date,
	 population,
	 vac.new_vaccinations,
	 sum(convert(float,vac.new_vaccinations))  over(PARTITION by dea.location order by dea.location,dea.date) as vaccination_by_location
	 --(vaccination_by_location/population)*100


from CovidDeath dea
join CovidVaccinations vac
 on dea.location = vac.location
and dea.date  = vac.date 
where dea.continent is not null 
--order by 1,2,3

)

select * ,(vaccination_by_location/population) * 100 as vaccination_by_location
from population_vs_vaccinations




--------------------------------------------------------------------temp table----------------------------------------------------------------------------------------------------------------------------------------
--drop table if exists #percent_Population_vaccination
create Table #percent_Population_vaccination
(
continent nvarchar(255),
location nvarchar(255),
Date datetime ,
population numeric,
new_vaccinations numeric,
vaccination_by_location numeric
)
insert into #percent_Population_vaccination
select 
	 dea.continent,
	 dea.location,
	 dea.date,
	 population,
	 vac.new_vaccinations,
	 sum(convert(float,vac.new_vaccinations))  over(PARTITION by dea.location order by dea.location,dea.date) as vaccination_by_location
	 


from CovidDeath dea
join CovidVaccinations vac
 on dea.location = vac.location
and dea.date  = vac.date 
where dea.continent is not null 



select * ,(vaccination_by_location/population) * 100 as vaccination_by_location
from #percent_Population_vaccination




------------------------------------------------------------------------------creating view to store data-------------------------------------------------------------------------------------------------------------
create view percent_Population_vaccination as
select 
	 dea.continent,
	 dea.location,
	 dea.date,
	 population,
	 vac.new_vaccinations,
	 sum(convert(float,vac.new_vaccinations))  over(PARTITION by dea.location order by dea.location,dea.date) as vaccination_by_location
	 


from CovidDeath dea
join CovidVaccinations vac
 on dea.location = vac.location
and dea.date  = vac.date 
where dea.continent is not null 


select * from percent_Population_vaccination
 