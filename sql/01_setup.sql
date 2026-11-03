-- Run with psql from the repository root:
-- psql -d salary_portfolio -f sql/01_setup.sql
-- The \copy meta-command reads the local CSV; PostgreSQL COPY FROM would read a server path.
DROP SCHEMA IF EXISTS salary_portfolio CASCADE;
CREATE SCHEMA salary_portfolio;
SET search_path TO salary_portfolio;

CREATE TABLE salary_raw (
  source_row_id INTEGER,
  age NUMERIC,
  gender TEXT,
  education_level TEXT,
  job_title TEXT,
  years_experience NUMERIC,
  salary NUMERIC,
  country TEXT,
  race TEXT
);

\copy salary_raw FROM 'Salary_Data_Based_country_and_race.csv' WITH (FORMAT csv, HEADER true, NULL '');

\echo 'Raw rows loaded:'
SELECT COUNT(*) AS raw_rows FROM salary_raw;
\echo 'Run psql -d salary_portfolio -f sql/02_clean_and_model.sql next.'
