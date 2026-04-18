--https://datalemur.com/questions/sql-well-paid-employees
SELECT emp.employee_id, emp.name as employee_name
FROM employee emp
JOIN employee mgr on emp.manager_id = mgr.employee_id
where mgr.salary < emp.salary