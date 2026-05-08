-- https://datalemur.com/questions/sql-top-three-salaries
SELECT department_name,name, salary
FROM ( SELECT 
  name,salary,department_id,
  DENSE_RANK() OVER (
    partition BY department_id
    ORDER BY salary DESC
  ) as rank
FROM employee) e
JOIN department d
  ON d.department_id = e.department_id
where rank <= 3
ORDER BY department_name, salary DESC, name