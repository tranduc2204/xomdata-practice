-- Xom Data · Khách phủ sóng nhiều tháng nhất
-- Problem: https://xomdata.com/practice/medium-frequency-005
-- Solved: 2026-09-05




with tmp as (
select order_id, customer_id, strftime('%Y-%m', order_date) time
from orders
)
select customer_id, count (distinct time) active_months, count (time)  total_orders
from tmp
group by customer_id
order by count (distinct time) desc, customer_id  asc
