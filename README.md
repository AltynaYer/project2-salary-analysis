# Global Salary Analysis by Job Title & Country

**Tools:** PostgreSQL, Tableau  
**Dataset:** [Salary by Job Title and Country — Kaggle](https://www.kaggle.com/datasets/amirmahdiabbootalebi/salary-by-job-title-and-country)

## Business Problem
HR teams need to understand what drives salary differences across countries,
job titles, and education levels — to benchmark compensation and make
competitive offers. This analysis covers 6,700+ salary records across
USA, UK, Australia, Canada, and China.

## What I Did
- Loaded 6,704 salary records into PostgreSQL and cleaned dirty data:
  merged duplicate education labels (Bachelor's / Bachelor's Degree),
  fixed capitalisation inconsistencies, removed 3 NULL rows
- Identified top paying jobs per country using GROUP BY + AVG + HAVING
- Analysed how education level affects average salary
- Built an interactive Tableau dashboard with country filter —
  allows switching between all 5 countries in real time

## Key Findings
- Director of Data Science is the highest paying role in UK ($205K avg)
- PhD holders earn ~4× more than High School graduates on average
- Data Analyst average salary in UK: $122K
- Salary gap between countries is significant — USA leads overall

## Visualization
🔗 [View Interactive Dashboard on Tableau Public](https://public.tableau.com/app/profile/altynay.yerzhigitova/viz/SalaryAnalysisbyJobTitleandEducationLevel/SalaryAnalysisDashboard?publish=yes)

## Files
- `analysis.sql` — all SQL queries used in this project
- `Salary_Data_Based_country_and_race.csv` — raw dataset
- `education_by_country.csv` — aggregated education analysis