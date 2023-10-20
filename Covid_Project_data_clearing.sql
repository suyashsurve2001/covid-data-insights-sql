
select * from CovidDeath
select * from CovidVaccinations

 ---------------------------------------cheacking value in continent ,location is null and given wrong value   in CovidVaccinations tabel--------------------------------------------------
 
select  
	COALESCE(continent,location)
from CovidVaccinations
where continent  is null

update  CovidVaccinations
set continent = location
where continent is null


--distinct

select  continent
from CovidVaccinations
where continent  in ('lower middle income','Low income','World' , 'Upper middle income' ,'High income')

delete CovidVaccinations
where continent in ('lower middle income' , 'Low income' , 'World' , 'Upper middle income','High income')


---------------------------------------cheacking value in continent ,location is null and given wrong value   in CovidDeath tabel--------------------------------------------------

select distinct continent
from CovidDeath
where continent  is null


select coalesce(continent,location)
from CovidDeath

update CovidDeath
set continent = location
where continent is null

select continent
from CovidDeath
where continent in('lower middle income' , 'Low income' , 'World' , 'Upper middle income','High income')

delete CovidDeath
where continent in('lower middle income' , 'Low income' , 'World' , 'Upper middle income','High income')



---------------------------------------cheacking date type in date  in CovidDeath & CovidVaccinations  tabel--------------------------------------------------

select convert(date, date) 
from CovidDeath

alter table CovidDeath
alter column date DATE






select convert(date,date)
from CovidVaccinations

alter table CovidVaccinations
alter column date Date



---------------------------------------cheacking date type in all other column  in CovidDeath & CovidVaccinations  tabel--------------------------------------------------

select total_cases,total_deaths
from CovidDeath


alter table CovidDeath
alter column total_cases float

alter table CovidDeath
alter column total_deaths float


select total_tests ,new_tests ,positive_rate ,total_vaccinations , people_vaccinated  ,new_vaccinations
from CovidVaccinations



alter table CovidVaccinations
alter column new_tests float


alter table CovidVaccinations
alter column total_tests float


alter table CovidVaccinations
alter column positive_rate float



alter table CovidVaccinations
alter column total_vaccinations float


alter table CovidVaccinations
alter column people_vaccinated float


alter table CovidVaccinations
alter column new_vaccinations float

------------------------------------------------deleting unused column from  CovidDeath table------------------------------------------------------------------------

select  iso_code,continent,location,date, population,total_cases,new_cases,new_cases_smoothed,total_deaths,new_deaths 
from CovidDeath


select  new_deaths_smoothed,
		total_cases_per_million,
		new_cases_per_million,
		new_cases_smoothed_per_million,
		total_deaths_per_million,
		new_deaths_per_million,
		new_deaths_smoothed_per_million,
		reproduction_rate,icu_patients,
		icu_patients_per_million,
		hosp_patients,
		hosp_patients_per_million,
		weekly_icu_admissions,
		weekly_icu_admissions_per_million,
		weekly_hosp_admissions,
		weekly_hosp_admissions_per_million
from CovidDeath

alter table CovidDeath
drop column new_deaths_smoothed,
		total_cases_per_million,
		new_cases_per_million,
		new_cases_smoothed_per_million,
		total_deaths_per_million,
		new_deaths_per_million,
		new_deaths_smoothed_per_million,
		reproduction_rate,icu_patients,
		icu_patients_per_million,
		hosp_patients,
		hosp_patients_per_million,
		weekly_icu_admissions,
		weekly_icu_admissions_per_million,
		weekly_hosp_admissions,
		weekly_hosp_admissions_per_million

select * from CovidDeath

------------------------------------------------deleting unused column from  CovidVaccinations table------------------------------------------------------------------------
select  iso_code,
		continent,
		location,date,
		total_tests,
		new_tests,
		positive_rate,
		tests_units,
		new_vaccinations,
		total_vaccinations,
		people_vaccinated
from CovidVaccinations

select
      [total_tests_per_thousand]
      ,[new_tests_per_thousand]
      ,[new_tests_smoothed]
      ,[new_tests_smoothed_per_thousand]
      ,[tests_per_case]
      ,[people_fully_vaccinated]
      ,[total_boosters]
      ,[new_vaccinations_smoothed]
      ,[total_vaccinations_per_hundred]
      ,[people_vaccinated_per_hundred]
      ,[people_fully_vaccinated_per_hundred]
      ,[total_boosters_per_hundred]
      ,[new_vaccinations_smoothed_per_million]
      ,[new_people_vaccinated_smoothed]
      ,[new_people_vaccinated_smoothed_per_hundred]
      ,[stringency_index]
      ,[population_density]
      ,[median_age]
      ,[aged_65_older]
      ,[aged_70_older]
      ,[gdp_per_capita]
      ,[extreme_poverty]
      ,[cardiovasc_death_rate]
      ,[diabetes_prevalence]
      ,[female_smokers]
      ,[male_smokers]
      ,[handwashing_facilities]
      ,[hospital_beds_per_thousand]
      ,[life_expectancy]
      ,[human_development_index]
      ,[excess_mortality_cumulative_absolute]
      ,[excess_mortality_cumulative]
      ,[excess_mortality]
      ,[excess_mortality_cumulative_per_million]
from CovidVaccinations


alter table CovidVaccinations
drop column  [total_tests_per_thousand]
      ,[new_tests_per_thousand]
      ,[new_tests_smoothed]
      ,[new_tests_smoothed_per_thousand]
      ,[tests_per_case]
      ,[people_fully_vaccinated]
      ,[total_boosters]
      ,[new_vaccinations_smoothed]
      ,[total_vaccinations_per_hundred]
      ,[people_vaccinated_per_hundred]
      ,[people_fully_vaccinated_per_hundred]
      ,[total_boosters_per_hundred]
      ,[new_vaccinations_smoothed_per_million]
      ,[new_people_vaccinated_smoothed]
      ,[new_people_vaccinated_smoothed_per_hundred]
      ,[stringency_index]
      ,[population_density]
      ,[median_age]
      ,[aged_65_older]
      ,[aged_70_older]
      ,[gdp_per_capita]
      ,[extreme_poverty]
      ,[cardiovasc_death_rate]
      ,[diabetes_prevalence]
      ,[female_smokers]
      ,[male_smokers]
      ,[handwashing_facilities]
      ,[hospital_beds_per_thousand]
      ,[life_expectancy]
      ,[human_development_index]
      ,[excess_mortality_cumulative_absolute]
      ,[excess_mortality_cumulative]
      ,[excess_mortality]
      ,[excess_mortality_cumulative_per_million]


select  *
from CovidVaccinations
