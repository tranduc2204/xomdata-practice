-- Xom Data · One-time buyers vs. repeat customers
-- Problem: https://xomdata.com/practice/medium-repeat-001
-- Solved: 2026-11-05



with tmp as (
select customer_id, count(*) rk 
from orders 
group by customer_id 
), tmp1 as (
select *, 
case 
    when rk >1 
        then 'repeat'

    else 'one-time'
end as customer_type
from tmp 
)
select customer_type, count (*) as customer_count
from tmp1
group by customer_type
