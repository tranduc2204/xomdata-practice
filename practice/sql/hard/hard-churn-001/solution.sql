-- Xom Data · Churned and returning customers
-- Problem: https://xomdata.com/practice/hard-churn-001
-- Solved: 2026-08-06



with tmp as (
select id, user_id, order_date, lead (order_date) over(partition by user_id order by order_date asc) next_ord 
from orders
)
select user_id, order_date prev_order,next_ord next_order, julianday(next_ord) - julianday(order_date) gap_days
from tmp
where  julianday(next_ord) - julianday(order_date) >= 90
order by julianday(next_ord) - julianday(order_date)  desc, user_id asc
