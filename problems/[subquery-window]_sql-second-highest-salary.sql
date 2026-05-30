-- https://datalemur.com/questions/sql-second-highest-salary
SELECT salary
FROM
  ( SELECT *,
    DENSE_RANK() OVER
    ( ORDER BY salary DESC ) AS rn
    FROM employee
  ) t
WHERE rn = 2

----------[ Official]----------------------------------------
SELECT MAX(salary) AS second_highest_salary
FROM employee
WHERE salary < (
    SELECT MAX(salary)
    FROM employee
);