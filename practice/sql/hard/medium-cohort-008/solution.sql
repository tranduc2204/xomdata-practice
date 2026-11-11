-- Xom Data · Each cohort's size and first-month cash
-- Problem: https://xomdata.com/practice/medium-cohort-008
-- Solved: 2026-11-11



with orders_info as (
select order_id , customer_id , to_char(order_date::date, 'YYYY-mm') order_date, amount
from orders
), first_month_per_cus as (
select *, dense_rank () over(partition by customer_id order by order_date asc) rk 
from orders_info
)
select order_date cohort_month, count (distinct customer_id) cohort_size, sum (amount) as first_month_revenue
from first_month_per_cus
where rk = 1
group by order_date
