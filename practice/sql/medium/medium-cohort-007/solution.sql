-- Xom Data · Who Joined During Promo Season
-- Problem: https://xomdata.com/practice/medium-cohort-007
-- Solved: 2026-10-17





with  rank_customer as (
select order_id, customer_id, order_date, amount, rank() over(partition by customer_id order by order_date asc) rk
from orders
), count_sl as (
    select customer_id, count (*) countt
    from orders
    where order_date between '2024-03-01' and '2024-03-31'
    group by customer_id
)
-- select customer_id, order_date as first_order_date
-- from rank_customer
-- where rk = 1 and order_date between '2024-03-01' and '2024-03-31'
, tmp as (
select *
from rank_customer
where rk = 1 and order_date between '2024-03-01' and '2024-03-31'
)
select a.customer_id, order_date as first_order_date, b.countt as campaign_orders
from tmp a
left join count_sl b
    on a.customer_id = b.customer_id
