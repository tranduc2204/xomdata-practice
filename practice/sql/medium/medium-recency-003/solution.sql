-- Xom Data · Customer Freshness Leaderboard
-- Problem: https://xomdata.com/practice/medium-recency-003
-- Solved: 2026-11-05



with order_filter as (
select *, row_number() over(partition by customer_id  order by order_date desc) rk
from orders
), ranking as(
select *, rank () over(order by order_date desc) as rkk
from order_filter
where rk=1
)
select customer_id, order_date as last_order_date, rkk as freshness_rank
from ranking
