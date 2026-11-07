-- Xom Data · The blacklist of long-silent customers
-- Problem: https://xomdata.com/practice/medium-churn-004
-- Solved: 2026-11-07



with info_order_newest as (
select *, row_number() over(partition by customer_id order by order_date desc) rk 
from orders 
), blacklist_info as (
select customer_id, order_date as last_order_date, '2024-06-30'::date - order_date::date  as days_silent
from info_order_newest
where rk = 1
)
select *
from blacklist_info
where days_silent > 90 
order by days_silent desc, customer_id asc
