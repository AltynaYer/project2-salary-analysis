# Data dictionary and assumptions

## Source
`Salary_Data_Based_country_and_race.csv` from the Kaggle dataset linked in the main README. 6,704 source records. Original first column is an unnamed row identifier; loaded as `source_row_id`.

| Field | Meaning | Handling |
|---|---|---|
| source_row_id | Row identifier from CSV | Primary key after validation |
| age | Reported age | Kept as provided; not used in current claims |
| gender | Reported gender | Trimmed, standardised capitalisation |
| education_level | Reported education category | Bachelor's and Master's variants unified; 'phD' mapped to 'PhD' |
| job_title | Reported job title | Whitespace trimmed; no unverified semantic recoding |
| years_experience | Reported experience | Missing retained; negative values excluded |
| salary | Reported salary | Missing or negative values excluded; units/currency unverified |
| country | Country label | Trimmed; required |
| race | Source category | Preserved; no conclusions drawn |

## Cleaning and grain
One source row corresponds to one salary observation. The model excludes observations with missing/invalid salary, missing education, missing job title or country, and negative experience. It retains missing experience as Unknown for experience grouping.

Expected result for the committed source snapshot: **6,704 raw rows; 6 excluded; 6,698 clean rows**. These counts were checked against the source CSV fields; run SQL assertions after import to confirm PostgreSQL behaviour.

## Model
`fact_salary` holds one row per clean salary observation. `dim_country`, `dim_job` and `dim_education` hold unique lookup values. Keys are generated on each rebuild and should not be treated as stable identifiers across different dataset versions.

## Interpretation limitations
This dataset is suitable for demonstrating SQL, modelling and exploratory reporting. Its sampling, currency consistency, collection dates and representativeness have not been established. Do not use its means as official national salary benchmarks or infer causal effects of education, gender or country from unadjusted averages.
