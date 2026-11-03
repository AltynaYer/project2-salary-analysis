# Global Salary Analysis | SQL, Data Quality & BI Modelling

**Portfolio status:** PostgreSQL analysis and reproducible modelling scripts supplied. Existing Tableau dashboard published. Power BI model guide supplied; **Power BI report not yet built or validated**.

## Business question
How do observed salaries vary across job titles, countries, education and experience in this dataset? This exploratory case demonstrates a reporting workflow; the data should **not** be treated as representative salary-market benchmarks.

**Source:** [Salary by Job Title and Country — Kaggle](https://www.kaggle.com/datasets/amirmahdiabbootalebi/salary-by-job-title-and-country)  
**Source snapshot:** 6,704 records; 6 records lack at least one required analytical field, leaving 6,698 under the documented cleaning rules.  
**Tools:** PostgreSQL, SQL, Tableau; Power BI modelling guide and DAX measures.

## What the project demonstrates
- Documented import and repeatable data cleaning
- Education-label standardisation, null and invalid-value checks, row-count reconciliation
- Fact/dimension model: salary observations with country, job and education dimensions
- Grouped salary summaries with sample sizes, minimum sample threshold for UK job ranking, and experience bands
- Tableau visual exploration and a planned Power BI report with explicit DAX measures

## Run locally
Requires PostgreSQL and `psql`. Create a database named `salary_portfolio`, then run these **from the repository root**:

```bash
createdb salary_portfolio
psql -d salary_portfolio -v ON_ERROR_STOP=1 -f sql/01_setup.sql
psql -d salary_portfolio -v ON_ERROR_STOP=1 -f sql/02_clean_and_model.sql
psql -d salary_portfolio -v ON_ERROR_STOP=1 -f sql/04_quality_checks.sql
psql -d salary_portfolio -v ON_ERROR_STOP=1 -f sql/03_analysis.sql
```

The first script resets the `salary_portfolio` schema; use a dedicated database, **not a database containing other work**. Import uses a relative path to the committed CSV. Re-running setup and modelling resets the project tables.

## Visualisations
- [Existing Tableau Public dashboard](https://public.tableau.com/app/profile/altynay.yerzhigitova/viz/SalaryAnalysisbyJobTitleandEducationLevel/SalaryAnalysisDashboard?publish=yes)
- [Power BI model, DAX and report-building instructions](powerbi/README.md) — report construction and validation pending

## Project files
- [Raw CSV](Salary_Data_Based_country_and_race.csv)
- [Import](sql/01_setup.sql), [cleaning and dimensional model](sql/02_clean_and_model.sql)
- [Analytical queries](sql/03_analysis.sql), [quality checks](sql/04_quality_checks.sql)
- [Data dictionary and limitations](docs/data_dictionary.md)
- [Original analysis queries](analysis.sql) — historical first iteration; use `sql/03_analysis.sql` for the updated model
- [Education summary](education_by_country.csv) — historical output; rebuild and verify against cleaned data before reporting

## Interpretation
Averages here describe observations in the supplied dataset. Collection method, currency comparability, dates and country-level representativeness have not been independently validated. Differences across education levels or countries are **associations, not causal estimates**.

## Verification status
CSV row counts and required-field missingness were independently inspected. PostgreSQL scripts and Power BI measures still need execution in their respective applications; do not claim a fully tested dashboard until these checks pass.
