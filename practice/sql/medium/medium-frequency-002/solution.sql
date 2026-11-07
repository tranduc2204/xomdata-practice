-- Xom Data · Customers Who Hit Three Orders a Year
-- Problem: https://xomdata.com/practice/medium-frequency-002
-- Solved: 2026-11-07



with order_info as (
select *
from orders 
where order_date between '2024-01-01' and '2024-12-31'
)
, result as (
select customer_id , count (order_id) over(partition by customer_id) order_count
from order_info
)
select distinct customer_id, order_count
from result 
where order_count  >=3
