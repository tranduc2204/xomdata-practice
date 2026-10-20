-- Xom Data · Salary bands within each department
-- Problem: https://xomdata.com/practice/medium-denserank-002
-- Solved: 2026-10-20

-- Write your SQL here


select department, dense_rank () over(partition by department order by salary desc ) salary_tier, full_name, salary
from employees
order by department asc, salary desc, salary_tier asc , full_name asc
