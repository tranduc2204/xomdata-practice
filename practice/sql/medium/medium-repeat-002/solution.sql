-- Xom Data · What share of customers does the shop retain
-- Problem: https://xomdata.com/practice/medium-repeat-002
-- Solved: 2026-11-05

with total_customer as (
    select count (distinct customer_id) as total_customer
    from orders
), order_customer as (
select 
    customer_id, count (*) rk 
from orders 
group by customer_id 
), customer_repeat as (
select 
    customer_id,
        case
            when rk >1 
                then 1
        else 
            0
    end as repeat_cus
from order_customer
), result as (
select sum (repeat_cus) customer_repeat
from customer_repeat
)
select round(customer_repeat*1.0  / total_customer * 100.0,2) repeat_rate_pct
from result 
cross join total_customer
