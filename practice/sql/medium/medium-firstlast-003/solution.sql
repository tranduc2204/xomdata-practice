-- Xom Data · What the First Impression Was Worth
-- Problem: https://xomdata.com/practice/medium-firstlast-003
-- Solved: 2026-09-29



with tmp as (
select customer_id, order_Date as first_order_date, amount as first_amount, row_number() over(partition by customer_id order by order_date asc, order_id asc) checkk
from orders
)
select customer_id, first_order_date, first_amount
from tmp 
where checkk =1
order by customer_id asc
