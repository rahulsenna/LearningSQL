-- https://datalemur.com/questions/sql-ibm-db2-product-analytics
SELECT unique_queries, COUNT(*) AS employee_count
FROM(
  SELECT
  employees.employee_id,
  SUM(CASE 
    WHEN queries.query_starttime >= '07/01/2023'
    AND queries.query_starttime < '10/01/2023' THEN 1
    ELSE 0
  END) AS unique_queries
  FROM employees
  LEFT JOIN queries ON employees.employee_id = queries.employee_id
  GROUP BY employees.employee_id
  ORDER BY unique_queries
) t
GROUP BY unique_queries;

-- [ official solution ]

WITH employee_queries AS (
  SELECT 
    e.employee_id,
    COALESCE(COUNT(DISTINCT q.query_id), 0) AS unique_queries
  FROM employees AS e
  LEFT JOIN queries AS q
    ON e.employee_id = q.employee_id
      AND q.query_starttime >= '2023-07-01T00:00:00Z'
      AND q.query_starttime < '2023-10-01T00:00:00Z'
  GROUP BY e.employee_id
)

SELECT
  unique_queries,
  COUNT(employee_id) AS employee_count
FROM employee_queries
GROUP BY unique_queries
ORDER BY unique_queries;