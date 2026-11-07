-- Xom Data · Which channel grows loyal customers
-- Problem: https://xomdata.com/practice/medium-repeat-003
-- Solved: 2026-11-07




with info_orders as (
select ord.order_id, cst.customer_id, customer_name, order_date, amount, customer_name, signup_date, channel
from orders ord 
left join customers cst 
    on ord.customer_id = cst.customer_id 
), total_customers as (
    select channel, count(distinct customer_id) total_customers 
    from info_orders
    group by channel 
), repare_info_customers as (
select distinct channel, customer_id, count(order_id) over(partition by channel,customer_id) repeat_customers
from info_orders
), repeat_customers as (
select channel, sum (
    case when repeat_customers >=2 
        then 1
    else 0
    end
) repeat_customers
from repare_info_customers
group by channel
)
select tc.channel, total_customers, repeat_customers, round ((repeat_customers * 1.0 / total_customers) * 100 ,2)repeat_rate_pct
from total_customers tc
left join repeat_customers rc 
    on tc.channel = rc.channel 
order by channel asc
