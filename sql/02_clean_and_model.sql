-- Re-runnable cleaning and a small dimensional model for BI.
-- Assumes sql/01_setup.sql has loaded salary_portfolio.salary_raw.
SET search_path TO salary_portfolio;
DROP VIEW IF EXISTS v_salary_analysis CASCADE;
DROP TABLE IF EXISTS fact_salary CASCADE;
DROP TABLE IF EXISTS dim_education CASCADE;
DROP TABLE IF EXISTS dim_job CASCADE;
DROP TABLE IF EXISTS dim_country CASCADE;
DROP TABLE IF EXISTS salary_clean CASCADE;

CREATE TABLE salary_clean AS
WITH normalized AS (
  SELECT
    source_row_id,
    age,
    NULLIF(INITCAP(TRIM(gender)), '') AS gender,
    CASE
      WHEN LOWER(TRIM(education_level)) IN ('bachelor''s', 'bachelor''s degree') THEN 'Bachelor''s Degree'
      WHEN LOWER(TRIM(education_level)) IN ('master''s', 'master''s degree') THEN 'Master''s Degree'
      WHEN LOWER(TRIM(education_level)) = 'phd' THEN 'PhD'
      ELSE NULLIF(TRIM(education_level), '')
    END AS education_level,
    NULLIF(TRIM(job_title), '') AS job_title,
    years_experience,
    salary,
    NULLIF(TRIM(country), '') AS country,
    NULLIF(TRIM(race), '') AS race
  FROM salary_raw
)
SELECT *
FROM normalized
WHERE salary IS NOT NULL AND salary >= 0
  AND education_level IS NOT NULL
  AND job_title IS NOT NULL
  AND country IS NOT NULL
  AND (years_experience IS NULL OR years_experience >= 0);

ALTER TABLE salary_clean ADD PRIMARY KEY (source_row_id);

CREATE TABLE dim_country AS
SELECT ROW_NUMBER() OVER (ORDER BY country)::INTEGER AS country_id, country
FROM (SELECT DISTINCT country FROM salary_clean) x;
ALTER TABLE dim_country ADD PRIMARY KEY (country_id);
ALTER TABLE dim_country ADD UNIQUE (country);

CREATE TABLE dim_education AS
SELECT ROW_NUMBER() OVER (ORDER BY education_level)::INTEGER AS education_id, education_level
FROM (SELECT DISTINCT education_level FROM salary_clean) x;
ALTER TABLE dim_education ADD PRIMARY KEY (education_id);
ALTER TABLE dim_education ADD UNIQUE (education_level);

CREATE TABLE dim_job AS
SELECT ROW_NUMBER() OVER (ORDER BY job_title)::INTEGER AS job_id, job_title
FROM (SELECT DISTINCT job_title FROM salary_clean) x;
ALTER TABLE dim_job ADD PRIMARY KEY (job_id);
ALTER TABLE dim_job ADD UNIQUE (job_title);

CREATE TABLE fact_salary AS
SELECT
  s.source_row_id AS salary_record_id,
  c.country_id, e.education_id, j.job_id,
  s.salary, s.age, s.gender, s.years_experience, s.race
FROM salary_clean s
JOIN dim_country c USING (country)
JOIN dim_education e USING (education_level)
JOIN dim_job j USING (job_title);
ALTER TABLE fact_salary ADD PRIMARY KEY (salary_record_id);
ALTER TABLE fact_salary ADD FOREIGN KEY (country_id) REFERENCES dim_country(country_id);
ALTER TABLE fact_salary ADD FOREIGN KEY (education_id) REFERENCES dim_education(education_id);
ALTER TABLE fact_salary ADD FOREIGN KEY (job_id) REFERENCES dim_job(job_id);

CREATE VIEW v_salary_analysis AS
SELECT f.*, c.country, e.education_level, j.job_title
FROM fact_salary f
JOIN dim_country c USING (country_id)
JOIN dim_education e USING (education_id)
JOIN dim_job j USING (job_id);

SELECT COUNT(*) AS cleaned_rows FROM salary_clean;
SELECT COUNT(*) AS fact_rows FROM fact_salary;
