-- Xom Data · High-rated sellers with many orders
-- Problem: https://xomdata.com/practice/medium-having-019
-- Solved: 2026-08-01


with tmp as (
select store_name, reputation_score, count(*) order_count, rank () over(order by count(*) desc) rank_by_orders
-- , sum(count(*) ) OVER (
--         ORDER BY count(*) desc 
--     ) AS cumulative_orders
from orders ord  
left join sellers sl
on ord.seller_id = sl.id 
group by store_name, reputation_score
), tmp2 as (
select store_name, reputation_score, order_count, rank_by_orders--, cumulative_orders 
, sum(order_count) OVER (
    
        ORDER BY order_count desc 
        ROWS BETWEEN UNBOUNDED PRECEDING
                 AND CURRENT ROW
    ) AS cumulative_orders
from tmp
)

select store_name, reputation_score, order_count, rank_by_orders, cumulative_orders 
from tmp2
where reputation_score >= 4.5 and order_count >= 3
order by rank_by_orders asc, store_name asc
