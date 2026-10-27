-- Xom Data · The customer's joining month on every order
-- Problem: https://xomdata.com/practice/medium-cohort-001
-- Solved: 2026-10-27

-- Write your SQL here

with tmp as (
select *, FIRST_VALUE(order_date) over(partition by customer_name order by order_date asc) rk 
from orders 
)
select customer_name, order_date, to_char(rk::timestamp, 'YYYY-MM') cohort_month
from tmp
order by customer_name asc
