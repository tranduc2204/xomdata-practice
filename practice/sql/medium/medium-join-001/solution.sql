-- Xom Data · Customer spending per order
-- Problem: https://xomdata.com/practice/medium-join-001
-- Solved: 2026-08-01


with tmp as (
select full_name, count (ord.id) order_count, sum (total_amount) total_spending, avg(total_amount) avg_order_value
--, ROW_NUMBER() over(order by total_amount desc )
from orders ord
full join customers cst 
on ord.customer_id = cst.id 
group by full_name
)
select full_name,order_count, total_spending, avg_order_value
, ROW_NUMBER() over(order by total_spending desc ) spending_rank
from tmp
order by spending_rank asc
