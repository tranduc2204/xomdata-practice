-- Xom Data · Which Channel Is Keeping Its Warmth
-- Problem: https://xomdata.com/practice/medium-recency-005
-- Solved: 2026-11-05




with info_order_new as (
select  ord.customer_id, channel, '2024-06-30'::date -  max(order_Date::date) days_silent
from orders ord 
join customers cst 
on ord.customer_id = cst.customer_id
group by ord.customer_id, channel
)
select channel,count (customer_id) as customers,
    
    round (avg(days_silent),2) as avg_days_silent
from info_order_new
group by 
    channel
order by round (avg(days_silent),2) asc, channel asc
