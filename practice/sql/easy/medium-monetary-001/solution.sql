-- Xom Data · Ai đã tiêu vượt mốc năm triệu
-- Problem: https://xomdata.com/practice/medium-monetary-001
-- Solved: 2026-09-06


with tmp as (
    select customer_id, sum (amount) as total_spent
    from orders
    group by customer_id
)
select customer_id, total_spent, 
case 
    when  total_spent >= 5000000 then 'VIP'
    else 'Standard'
end as segment
from tmp
