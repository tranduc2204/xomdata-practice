-- Xom Data · Countdown before losing a customer
-- Problem: https://xomdata.com/practice/medium-churn-003
-- Solved: 2026-11-05




with order_newest as (
    select *, row_number() over(partition by customer_id order by order_date desc) rk 
    from orders

), dayleft_info as (
select customer_id, '2024-06-30'::date - order_date::date as days_silent
from order_newest
where rk = 1
)
select customer_id, days_silent, 90 - days_silent as days_left
from dayleft_info 
where 90 - days_silent >=0

order by (90 - days_silent)  asc, customer_id  asc
