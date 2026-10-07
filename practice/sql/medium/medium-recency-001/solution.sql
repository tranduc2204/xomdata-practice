-- Xom Data · Bao lâu rồi khách chưa quay lại
-- Problem: https://xomdata.com/practice/medium-recency-001
-- Solved: 2026-10-07



with tmp as (
select *, row_number () over(partition by customer_id order by order_Date desc) rankk
from orders
), tmp1  as (
select *, '2024-06-30' as now 
from tmp 
where rankk = 1
)
select customer_id, order_Date as last_order_date, CAST(julianday(now) - julianday(order_Date) AS INTEGER) as days_since
from tmp1
order by CAST(julianday(now) - julianday(order_Date) AS INTEGER)  asc
