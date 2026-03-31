# Global Salary Analysis by Job Title & Country

**Tools:** PostgreSQL, Power BI  
**Dataset:** [Salary by Job Title and Country — Kaggle](https://www.kaggle.com/datasets/amirmahdiabbootalebi/salary-by-job-title-and-country)

## Business Problem
HR teams need to understand what drives salary differences across countries,
job titles, education levels, and experience — to make competitive offers
and identify pay equity issues.

## What I Did
- Loaded 6,704 salary records across 5 countries into PostgreSQL
- Identified top 10 highest paying jobs per country
- Analysed how education level and years of experience affect salary
- Compared gender pay gap across countries using GROUP BY and AVG

## Key Findings
- Data Scientist avg salary in UK: $165,898
- PhD holders earn 2x more than High School graduates
- 10+ years experience correlates with 60% higher salary
- Gender pay gap exists across all 5 countries

## Files
- `analysis.sql` — all SQL queries used in this project
