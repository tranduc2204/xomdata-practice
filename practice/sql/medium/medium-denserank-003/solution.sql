-- Xom Data · Spending tiers of loyal customers
-- Problem: https://xomdata.com/practice/medium-denserank-003
-- Solved: 2026-10-30

-- Write your SQL here

with tmp as (
select customer_name, sum (amount) total_spent
from purchases
group by customer_name
), tmp1 as (
select *, dense_rank () over(order by total_spent desc) spend_tier

from tmp 
)
select *
from tmp1
order by spend_tier asc, customer_name asc
