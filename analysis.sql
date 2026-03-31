-- 1. Count of records by country
SELECT country, COUNT(*) AS total_rows
FROM salaries
GROUP BY country
ORDER BY total_rows DESC;

-- 2. Top 10 highest paying jobs in UK
SELECT
  job_title,
  ROUND(AVG(salary), 0)           AS avg_salary,
  COUNT(*)                        AS num_employees,
  ROUND(AVG(years_experience), 1) AS avg_experience
FROM salaries
WHERE country = 'UK'
GROUP BY job_title
HAVING COUNT(*) >= 5
ORDER BY avg_salary DESC
LIMIT 10;

-- 3. Impact of education level on salary
SELECT
  education_level,
  ROUND(AVG(salary), 0)           AS avg_salary,
  COUNT(*)                        AS num_employees
FROM salaries
GROUP BY education_level
ORDER BY avg_salary DESC;

-- 4. Salary gap between genders by country
SELECT
  country,
  gender,
  ROUND(AVG(salary), 0)           AS avg_salary,
  COUNT(*)                        AS num_employees
FROM salaries
GROUP BY country, gender
ORDER BY country, avg_salary DESC;

-- 5. Does experience predict salary?
SELECT
  CASE
    WHEN years_experience < 3  THEN '0-2 years'
    WHEN years_experience < 6  THEN '3-5 years'
    WHEN years_experience < 11 THEN '6-10 years'
    ELSE                            '10+ years'
  END                             AS experience_bucket,
  ROUND(AVG(salary), 0)           AS avg_salary,
  COUNT(*)                        AS num_employees
FROM salaries
GROUP BY experience_bucket
ORDER BY avg_salary DESC;
