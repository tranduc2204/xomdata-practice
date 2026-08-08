-- Xom Data · Median salary per department
-- Problem: https://xomdata.com/practice/sql-nightmare-002
-- Solved: 2026-08-08





-- select 

-- percentile_cont(0.50) WITHIN GROUP (ORDER BY salary) AS median

-- from employees 

-- -- 75000

select dept, percentile_cont(0.50) WITHIN GROUP ( ORDER BY salary) AS median_salary
from employees 
group by dept
