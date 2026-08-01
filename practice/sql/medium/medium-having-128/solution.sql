-- Xom Data · Employees averaging over 5 overtime hours
-- Problem: https://xomdata.com/practice/medium-having-128
-- Solved: 2026-08-01


-- select full_name, employee_code, avg (work_days) as x
--over(partition by employee_code)
with tmp as (
select full_name, employee_code, avg((work_days))  as  avg_work_days, avg ((overtime_hours))  as avg_overtime_hours, avg ((net_salary)) avg_salary
 ,round (avg ((overtime_hours)) / avg ((work_days)) ,4) overtime_intensity

from employees emp
left join attendance att 
on emp.id = att.employee_id
left join payroll py
on emp.id = py.employee_id
group by full_name, employee_code
)
select full_name,	employee_code,	avg_work_days,	avg_overtime_hours,	avg_salary,overtime_intensity
,rank () over(order by overtime_intensity desc) intensity_rank
, NTILE(4) OVER (ORDER BY overtime_intensity DESC) AS workload_quartile
from tmp 
where avg_overtime_hours > 5 and avg_work_days >= 18
order by  intensity_rank asc, employee_code asc


-- with tmp as (
-- select full_name, employee_code, avg(work_days) over(partition by employee_code) as  avg_work_days, avg (overtime_hours) as avg_overtime_hours, avg (net_salary) avg_salary,
-- round (avg (overtime_hours) / avg (work_days),4) overtime_intensity
-- from employees emp
-- left join attendance att 
-- on emp.id = att.employee_id
-- left join payroll py
-- on emp.id = py.employee_id
-- group by full_name, employee_code

-- )



-- select full_name,	employee_code,	avg_work_days,	avg_overtime_hours,	avg_salary,overtime_intensity,
-- rank () over(order by overtime_intensity desc) intensity_rank
-- , NTILE(4) OVER (ORDER BY overtime_intensity DESC) AS workload_quartile
-- from tmp 
-- -- where avg_overtime_hours > 5 and avg_work_days > 18
-- order by  intensity_rank asc, employee_code asc
