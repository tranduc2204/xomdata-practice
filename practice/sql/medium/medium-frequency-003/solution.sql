-- Xom Data · Each Customer's Golden Month
-- Problem: https://xomdata.com/practice/medium-frequency-003
-- Solved: 2026-11-07


with orders_info as (
    select order_id, customer_id, to_char(order_date::date, 'YYYY-mm') month_date
    from orders
), pre_result as (
select distinct  customer_id, month_date as best_month, count (order_id) over(partition by customer_id, month_date) orders_in_month
from orders_info
), result as (
select *, row_number() over(partition by customer_id order by orders_in_month desc, best_month asc) rk 
from pre_result 
)
select customer_id, best_month, orders_in_month
from result 
where rk = 1
