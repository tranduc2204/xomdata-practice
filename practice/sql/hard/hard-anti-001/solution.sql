-- Xom Data · Customers silent for 90 days
-- Problem: https://xomdata.com/practice/hard-anti-001
-- Solved: 2026-08-05



with days_last  as (
select max (order_date) recent_date
from orders
), tmp as (
select user_id, order_date, recent_date--, julianday(recent_date) - julianday(order_date)
, rank () over (partition by user_id order by  order_date  desc) rank 
from orders 
cross join days_last 

)
select user_id, order_date last_order_date,julianday(recent_date) - julianday(order_date) days_since_last
from tmp
where rank = 1 and  julianday(recent_date) - julianday(order_date)  >= 90
order by  julianday(recent_date) - julianday(order_date) desc, user_id asc
