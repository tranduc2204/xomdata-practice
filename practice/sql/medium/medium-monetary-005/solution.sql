-- Xom Data · Miếng bánh doanh thu của từng khách
-- Problem: https://xomdata.com/practice/medium-monetary-005
-- Solved: 2026-09-07



with total_spent_cus
as (
select customer_id, sum (amount) total_spent
from orders
group by customer_id 
), total_all as (
    select sum (amount) as all_amount
    from orders
)
select customer_id, total_spent, round (cast (total_spent as real ) /  all_amount * 100,2 ) as revenue_share_pct
from total_spent_cus
cross join total_all
order by round (cast (total_spent as real ) /  all_amount * 100,2 )  desc, customer_id  asc
