-- Xom Data · Average Orders per Customer by Channel
-- Problem: https://xomdata.com/practice/medium-frequency-006
-- Solved: 2026-11-11




select channel, count(distinct ord.customer_id) customers, count (order_id) total_orders,  round (count (order_id) *1.0 / count(distinct ord.customer_id),2) as orders_per_customer
from orders ord
left join customers cst 
on ord.customer_id = cst.customer_id 
group by channel

order by round (count (order_id) *1.0 / count(distinct ord.customer_id),2) desc, channel asc
