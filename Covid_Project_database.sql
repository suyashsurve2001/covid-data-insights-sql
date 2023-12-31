USE [master]
GO
/****** Object:  Database [CovidProject]    Script Date: 20-10-2023 05:34:42 PM ******/
CREATE DATABASE [CovidProject]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'CovidProject', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL16.SQLEXPRESS\MSSQL\DATA\CovidProject.mdf' , SIZE = 270336KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'CovidProject_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL16.SQLEXPRESS\MSSQL\DATA\CovidProject_log.ldf' , SIZE = 401408KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
 WITH CATALOG_COLLATION = DATABASE_DEFAULT, LEDGER = OFF
GO
ALTER DATABASE [CovidProject] SET COMPATIBILITY_LEVEL = 160
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [CovidProject].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [CovidProject] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [CovidProject] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [CovidProject] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [CovidProject] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [CovidProject] SET ARITHABORT OFF 
GO
ALTER DATABASE [CovidProject] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [CovidProject] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [CovidProject] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [CovidProject] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [CovidProject] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [CovidProject] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [CovidProject] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [CovidProject] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [CovidProject] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [CovidProject] SET  DISABLE_BROKER 
GO
ALTER DATABASE [CovidProject] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [CovidProject] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [CovidProject] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [CovidProject] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [CovidProject] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [CovidProject] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [CovidProject] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [CovidProject] SET RECOVERY SIMPLE 
GO
ALTER DATABASE [CovidProject] SET  MULTI_USER 
GO
ALTER DATABASE [CovidProject] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [CovidProject] SET DB_CHAINING OFF 
GO
ALTER DATABASE [CovidProject] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [CovidProject] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [CovidProject] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [CovidProject] SET ACCELERATED_DATABASE_RECOVERY = OFF  
GO
ALTER DATABASE [CovidProject] SET QUERY_STORE = ON
GO
ALTER DATABASE [CovidProject] SET QUERY_STORE (OPERATION_MODE = READ_WRITE, CLEANUP_POLICY = (STALE_QUERY_THRESHOLD_DAYS = 30), DATA_FLUSH_INTERVAL_SECONDS = 900, INTERVAL_LENGTH_MINUTES = 60, MAX_STORAGE_SIZE_MB = 1000, QUERY_CAPTURE_MODE = AUTO, SIZE_BASED_CLEANUP_MODE = AUTO, MAX_PLANS_PER_QUERY = 200, WAIT_STATS_CAPTURE_MODE = ON)
GO
USE [CovidProject]
GO
/****** Object:  Table [dbo].[CovidDeath]    Script Date: 20-10-2023 05:34:42 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CovidDeath](
	[iso_code] [nvarchar](255) NULL,
	[continent] [nvarchar](255) NULL,
	[location] [nvarchar](255) NULL,
	[date] [date] NULL,
	[population] [float] NULL,
	[total_cases] [float] NULL,
	[new_cases] [float] NULL,
	[new_cases_smoothed] [float] NULL,
	[total_deaths] [float] NULL,
	[new_deaths] [float] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[CovidVaccinations]    Script Date: 20-10-2023 05:34:42 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CovidVaccinations](
	[iso_code] [nvarchar](255) NULL,
	[continent] [nvarchar](255) NULL,
	[location] [nvarchar](255) NULL,
	[date] [date] NULL,
	[total_tests] [float] NULL,
	[new_tests] [float] NULL,
	[positive_rate] [float] NULL,
	[tests_units] [nvarchar](255) NULL,
	[total_vaccinations] [float] NULL,
	[people_vaccinated] [float] NULL,
	[new_vaccinations] [float] NULL
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[percent_Population_vaccination]    Script Date: 20-10-2023 05:34:42 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create view [dbo].[percent_Population_vaccination] as
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
GO
USE [master]
GO
ALTER DATABASE [CovidProject] SET  READ_WRITE 
GO
