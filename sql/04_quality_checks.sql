-- Run after 02_clean_and_model.sql. All assertions should return 'PASS'.
SET search_path TO salary_portfolio;

SELECT 'raw_count' AS test,
       CASE WHEN COUNT(*) = 6704 THEN 'PASS' ELSE 'FAIL' END AS status,
       COUNT(*)::TEXT AS observed FROM salary_raw
UNION ALL
SELECT 'clean_count', CASE WHEN COUNT(*) = 6698 THEN 'PASS' ELSE 'FAIL' END,
       COUNT(*)::TEXT FROM salary_clean
UNION ALL
SELECT 'fact_matches_clean', CASE WHEN
  (SELECT COUNT(*) FROM fact_salary) = (SELECT COUNT(*) FROM salary_clean)
  THEN 'PASS' ELSE 'FAIL' END,
  (SELECT COUNT(*) FROM fact_salary)::TEXT
UNION ALL
SELECT 'no_missing_dimensions', CASE WHEN COUNT(*) = 0 THEN 'PASS' ELSE 'FAIL' END,
       COUNT(*)::TEXT FROM fact_salary
       WHERE country_id IS NULL OR education_id IS NULL OR job_id IS NULL
UNION ALL
SELECT 'unique_source_ids', CASE WHEN COUNT(*) = COUNT(DISTINCT source_row_id)
  THEN 'PASS' ELSE 'FAIL' END, COUNT(*)::TEXT FROM salary_clean
UNION ALL
SELECT 'valid_salary', CASE WHEN COUNT(*) = 0 THEN 'PASS' ELSE 'FAIL' END,
       COUNT(*)::TEXT FROM salary_clean WHERE salary IS NULL OR salary < 0;

-- Inspect exclusion reasons (categories may overlap).
SELECT
 COUNT(*) AS raw_records,
 COUNT(*) FILTER (WHERE salary IS NULL OR salary < 0) AS invalid_salary,
 COUNT(*) FILTER (WHERE education_level IS NULL OR TRIM(education_level) = '') AS missing_education,
 COUNT(*) FILTER (WHERE job_title IS NULL OR TRIM(job_title) = '') AS missing_job,
 COUNT(*) FILTER (WHERE country IS NULL OR TRIM(country) = '') AS missing_country,
 COUNT(*) FILTER (WHERE years_experience < 0) AS invalid_experience
FROM salary_raw;
