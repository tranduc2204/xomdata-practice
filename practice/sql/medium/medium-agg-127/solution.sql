-- Xom Data · Top 10 highest-paid employees and their leave days
-- Problem: https://xomdata.com/practice/medium-agg-127
-- Solved: 2026-08-03



with emp_info as (
select emp.id as employee_id, full_name, employee_code, department_id, department_name
from employees emp
left join departments dept 
on emp.department_id = dept.id
), tmp as (
select  emp.employee_id, full_name, employee_code, department_id, department_name, net_salary--, status
from emp_info emp 
left join payroll pay 
on emp.employee_id =  pay.employee_id

-- left join leaves lea
-- on emp.employee_id =  lea.employee_id
), tmp1 as (
select employee_id, full_name, employee_code, department_id, department_name, sum (net_salary) total_received_salary
from tmp
group by employee_id, full_name, employee_code, department_id, department_name
), tmp2 as (
select full_name, employee_code, department_name, total_received_salary
,count (
    case 
        when status = 'duyet' then 1
        
    end 
)  leave_count

from tmp1
left join leaves l 
on tmp1.employee_id = l.employee_id
group by full_name, employee_code, department_name, total_received_salary
)


select full_name, employee_code, department_name, total_received_salary, leave_count
, round ((cast (total_received_salary as real ) / avg (total_received_salary) over(partition by department_name))*100 - 100,2)   as pct_above_dept_avg

from tmp2
order by total_received_salary desc, employee_code asc
