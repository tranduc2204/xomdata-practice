-- Xom Data · Salary by department and title
-- Problem: https://xomdata.com/practice/medium-join-126
-- Solved: 2026-08-03



with emp_info as (
select emp.id as employee_id, department_id, position_id, department_name, position_name
from employees emp 
left join departments dept
on emp.department_id = dept.id 
left join positions pos
on emp.position_id  = pos.id
), tmp as (
select emp.employee_id, department_id, position_id, department_name, position_name, net_salary
from payroll pay 
left join  emp_info emp 
on pay.employee_id = emp.employee_id
), tmp1 as (
select department_name, position_name, count (distinct employee_id) employee_count, avg (net_salary) as avg_salary,
min (net_salary) min_salary, max (net_salary) as max_salary, max (net_salary) - min (net_salary) as salary_spread,
-- avg (net_salary) over(partition by department_name) as  deprank 
rank  () over(partition by department_name order by avg (net_salary) desc) as  rank_in_dept 
from tmp 
group by department_name, position_name
)
select *
from tmp1
order by department_name asc, rank_in_dept asc , position_name asc
