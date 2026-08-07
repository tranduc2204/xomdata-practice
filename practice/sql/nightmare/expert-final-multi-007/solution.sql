-- Xom Data · Top 2 salespeople by sales each month
-- Problem: https://xomdata.com/practice/expert-final-multi-007
-- Solved: 2026-08-06




with tmp as (
select month, employee_id, full_name, sum (revenue) over(partition by employee_id, month) total_sales
from sales sl
left join employees emp on sl.employee_id = emp.id
), tmp1 as (
select month, employee_id, full_name, total_sales, dense_rank () over(partition by month order by total_sales desc ) hang  
from tmp
)
select distinct month, hang, employee_id, full_name, total_sales
from tmp1 
where hang <=2
order by month asc, hang asc, employee_id asc
