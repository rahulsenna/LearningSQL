-- https://datalemur.com/questions/duplicate-job-listings
SELECT COUNT(DISTINCT company_id) AS duplicate_companies
FROM (
  SELECT company_id
  FROM job_listings
  GROUP BY company_id, title, description
  HAVING COUNT(*) > 1
) t;