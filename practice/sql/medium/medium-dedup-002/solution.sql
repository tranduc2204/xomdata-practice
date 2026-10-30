-- Xom Data · The current price of each product
-- Problem: https://xomdata.com/practice/medium-dedup-002
-- Solved: 2026-10-30

-- Write your SQL here

with tmp as (
select *, row_number() over(partition by product_name order by effective_date desc ) rk 
from price_history
)
select product_name, price, effective_date
from tmp 
where rk =1
order by product_name asc
