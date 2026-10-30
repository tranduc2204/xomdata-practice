-- Xom Data · Each customer's latest contact number
-- Problem: https://xomdata.com/practice/medium-dedup-001
-- Solved: 2026-10-30

-- Write your SQL here


with tmp as (
select *, row_number() over(partition by customer_name order by updated_date desc) rk 
from contact_updates
)
select customer_name, phone, updated_date
from tmp 
where rk = 1
order by customer_name asc
