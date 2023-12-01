select * from CovidDeaths d
where d.continent is not null --continent:luc dia
order by 3,4

--select data to using
select d.location,d.date,d.total_cases,d.new_cases,d.total_deaths,d.population from CovidDeaths d
order by 1,2

--looking at total cases vs total deaths
select d.location,d.date,d.total_cases,d.total_deaths,(d.total_deaths/d.total_cases)*100 as deathpercent from CovidDeaths d
where d.location like '%vietnam%' and d.continent is not null --continent:luc dia
order by 1,2

--looking at total case and population
--showing that percent population got covid
select d.location,d.date,d.total_cases,d.population,(d.total_deaths/d.population)*100 as percentPopulationInfection from CovidDeaths d
--where d.location like '%vietnam%'
order by 1,2

--loking at country with highest infection rate compared to population(tong so lay nhiem cao nhat)
select d.location,max(d.total_cases)  as highestInfectionCount,d.population,max((d.total_cases/d.population)*100) as percentPopulationInfection
from CovidDeaths d
group by d.population,d.location
order by percentPopulationInfection desc

--break things down by contient  (chia cac luc dia)
select d.continent,MAX(cast(d.total_deaths as int)) as totalDeathCount
from CovidDeaths d
where d.continent is not null --continent:luc dia
group by d.continent 
order by totalDeathCount desc 

--showing country with highest death count per population
select d.location,MAX(cast(d.total_deaths as int)) as totalDeathCount
from CovidDeaths d
where d.continent is not null --continent:luc dia
group by d.location 
order by totalDeathCount desc 

--showing continent with the highest death count per population
select d.continent,MAX(cast(d.total_deaths as int)) as totalDeathCount
from CovidDeaths d
where d.continent is not null --continent:luc dia
group by d.continent
order by totalDeathCount desc 

--global number
select SUM(d.new_cases) as totalCase,SUM(cast(d.new_deaths as int)) as total_deaths,SUM(cast(d.new_deaths AS int))/SUM(d.new_cases) *100 as deathPercentAge
from CovidDeaths d
where d.continent is not null
--group by d.date
order by 1,2

--total population and vaccin
select d.continent, d.location,d.date,d.population,v.new_vaccinations, 
SUM(convert(int,v.new_vaccinations )) over (partition by d.location order by d.location,d.date ) as rollingPeopleVacc
from CovidVaccinations v join CovidDeaths d
on v.location = d.location and v.date=d.date
where d.continent is not null and d.location like '%albania%'
order by 2,3

--use cte
with PopulaVacc (contient,location,date,population,new_vaccinations, rollingPeopleVacc)
as

(
select d.continent, d.location,d.date,d.population,v.new_vaccinations, 
SUM(convert(int,v.new_vaccinations )) over (partition by d.location order by d.location,d.date ) as rollingPeopleVacc
from CovidVaccinations v join CovidDeaths d
on v.location = d.location and v.date=d.date
where d.continent is not null --and d.location like '%albania%'
--order by 2,3
)
select * ,(rollingPeopleVacc/population)*100 from PopulaVacc

--temp table
drop table if exists #PercentpopulationVacc
create table #PercentpopulationVacc
(
	continent nvarchar(255),
	location nvarchar (255),
	date datetime,
	population numeric,
	new_vaccinations numeric,
	rollingPeopleVacc numeric
)
insert into #PercentpopulationVacc
select d.continent, d.location,d.date,d.population,v.new_vaccinations, 
SUM(convert(int,v.new_vaccinations )) over (partition by d.location order by d.location,d.date ) as rollingPeopleVacc
from CovidVaccinations v join CovidDeaths d
on v.location = d.location and v.date=d.date
--where d.continent is not null --and d.location like '%albania%'
--order by 2,3

select *, (rollingPeopleVacc/population)*100 from #PercentpopulationVacc

--create view to store data for later visualization

create view PercentpopulationVacc as
select d.continent, d.location,d.date,d.population,v.new_vaccinations, 
SUM(convert(int,v.new_vaccinations )) over (partition by d.location order by d.location,d.date ) as rollingPeopleVacc
from CovidVaccinations v join CovidDeaths d
on v.location = d.location and v.date=d.date
where d.continent is not null --and d.location like '%albania%'
--order by 2,3
select * from PercentpopulationVacc