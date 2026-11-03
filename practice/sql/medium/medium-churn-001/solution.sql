-- Xom Data · Labeling customers as retained or churned
-- Problem: https://xomdata.com/practice/medium-churn-001
-- Solved: 2026-11-03


with rank_order as (
select *, row_number () over(partition by customer_id order by order_date desc) rk 
from orders 
), tmp as (
select customer_id, order_date as last_order_date, '2024-06-30'::date - order_date::date count_day
from rank_order
where rk = 1
)
select customer_id, last_order_date, 
    case    
        when count_day <= 90
            then 'active'
        else 'churned'
    end as status
from tmp
