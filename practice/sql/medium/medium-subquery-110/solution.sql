-- Xom Data · Employees paid above their department average
-- Problem: https://xomdata.com/practice/medium-subquery-110
-- Solved: 2026-08-03




with tmp as (
select full_name, dept_name, salary, round (avg (salary) over(partition by department_id) ,0) dept_avg_salary
, round (salary / avg (salary) over(partition by department_id) *100 - 100,2)  premium_pct
from employees emp 
left join departments dept 
on emp.department_id =  dept.id
group by full_name, dept_name, salary
)
select *
from tmp 
where salary > dept_avg_salary
order by premium_pct desc, dept_name asc
