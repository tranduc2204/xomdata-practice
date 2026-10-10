-- Xom Data · Ba mươi ngày vắng bóng
-- Problem: https://xomdata.com/practice/medium-recency-002
-- Solved: 2026-10-10

with orderss as (
select *, rank () over(partition by customer_id order by order_Date desc, amount desc) checkk
from orders
)

,tmp as (
select *, '2024-06-30' as date_check
from orderss
where checkk = 1
) 
, tmp1 as (
select *,     JULIANDAY(date_check)
    - JULIANDAY(order_date) as  count_check
from tmp) 
select customer_id, order_date as last_order_date--, count_check
from tmp1
where count_check > 30
