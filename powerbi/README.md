# Power BI dashboard build guide

**Status:** model specification and measures supplied; a tested `.pbix` file has not been created yet.

## Import
1. Run the PostgreSQL scripts from the repository root as described in the main README.
2. In Power BI Desktop: **Get data → PostgreSQL database**. Connect to your local database `salary_portfolio`.
3. Import the four tables in schema `salary_portfolio`: `fact_salary`, `dim_country`, `dim_job`, `dim_education`. Choose **Import** mode.
4. In Model view create three one-to-many, single-direction relationships:
   - `dim_country[country_id]` (1) → `fact_salary[country_id]` (*)
   - `dim_job[job_id]` (1) → `fact_salary[job_id]` (*)
   - `dim_education[education_id]` (1) → `fact_salary[education_id]` (*)
5. Hide the surrogate key columns from Report view. Keep numerical salary as a decimal or whole number. Do not add salaries together to represent compensation.

## Measures (DAX)
```dax
Salary Records = COUNTROWS(fact_salary)

Average Salary = AVERAGE(fact_salary[salary])

Median Salary = MEDIAN(fact_salary[salary])

Average Experience = AVERAGE(fact_salary[years_experience])

Records with Experience = COUNT(fact_salary[years_experience])
```

## Suggested report page
- KPI cards: Salary Records, Average Salary, Median Salary
- Bar chart: Average Salary by country (dim_country[country])
- Bar chart: Average Salary by education (dim_education[education_level])
- Bar chart: Average Salary by job title; filter to sufficiently sampled titles
- Slicers: country, education level and job title
- Tooltip: Salary Records for each group, to expose small samples
- Footer: 'Exploratory analysis of a Kaggle dataset; salary units, sampling and representativeness are unverified.'

## Validate before sharing
- The overall Salary Records card must match the cleaned SQL row count.
- Country-filtered record counts and average salaries must match `sql/03_analysis.sql`.
- Selecting one education level should filter all visuals without duplicating rows.
- Add a screenshot in `powerbi/screenshots/` and a tested `.pbix` file only after building it in Desktop.

No Power BI workbook or screenshot is claimed as completed by this guide.
