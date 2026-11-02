-- Xom Data · Diamond, Gold, or regular member
-- Problem: https://xomdata.com/practice/medium-classify-001
-- Solved: 2026-11-02


with tmp as (
select
    customer_id,
    sum(amount) as total_spent
from orders
group by customer_id 
)
select customer_id, total_spent, 
case 
    when total_spent >= 10000000
        then 'Diamond'
    when total_spent >= 3000000 and total_spent < 10000000
        then 'Gold'
    else 'Member'
end as tier
from tmp
