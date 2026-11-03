-- Analytical queries on the reproducible cleaned model.
SET search_path TO salary_portfolio;

-- Sample sizes matter when comparing groups.
SELECT country, COUNT(*) AS records, ROUND(AVG(salary), 0) AS average_salary
FROM v_salary_analysis GROUP BY country ORDER BY records DESC;

-- Highest mean salaries among UK job titles with >= 5 observations.
SELECT job_title, COUNT(*) AS sample_size,
       ROUND(AVG(salary), 0) AS avg_salary,
       ROUND(AVG(years_experience), 1) AS avg_years_experience
FROM v_salary_analysis
WHERE country = 'UK'
GROUP BY job_title
HAVING COUNT(*) >= 5
ORDER BY avg_salary DESC LIMIT 10;

SELECT education_level, COUNT(*) AS sample_size,
       ROUND(AVG(salary), 0) AS avg_salary
FROM v_salary_analysis
GROUP BY education_level ORDER BY avg_salary DESC;

SELECT country, gender, COUNT(*) AS sample_size,
       ROUND(AVG(salary), 0) AS avg_salary
FROM v_salary_analysis
WHERE gender IS NOT NULL
GROUP BY country, gender ORDER BY country, avg_salary DESC;

WITH experience_groups AS (
  SELECT CASE
    WHEN years_experience IS NULL THEN 'Unknown'
    WHEN years_experience < 3 THEN '0-2 years'
    WHEN years_experience < 6 THEN '3-5 years'
    WHEN years_experience < 11 THEN '6-10 years'
    ELSE '11+ years'
  END AS experience_bucket,
  CASE
    WHEN years_experience IS NULL THEN 5
    WHEN years_experience < 3 THEN 1
    WHEN years_experience < 6 THEN 2
    WHEN years_experience < 11 THEN 3
    ELSE 4
  END AS sort_order,
  salary
  FROM v_salary_analysis
)
SELECT experience_bucket, COUNT(*) AS sample_size,
       ROUND(AVG(salary), 0) AS avg_salary
FROM experience_groups
GROUP BY experience_bucket, sort_order
ORDER BY sort_order;

-- Country-specific Data Analyst averages should be labelled sample estimates.
SELECT country, COUNT(*) AS sample_size, ROUND(AVG(salary), 0) AS avg_salary
FROM v_salary_analysis
WHERE job_title = 'Data Analyst'
GROUP BY country ORDER BY country;
