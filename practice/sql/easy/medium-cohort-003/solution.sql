-- Xom Data · Tháng chào sân của từng khách
-- Problem: https://xomdata.com/practice/medium-cohort-003
-- Solved: 2026-09-06


with tmp as (
select *, row_number() over(partition by customer_id order by order_date asc) checkk, strftime('%Y-%m', order_Date) cohort_month
from orders
)
select customer_id, cohort_month
from tmp 
where checkk = 1
order by cohort_month asc
