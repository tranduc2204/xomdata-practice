-- Xom Data · The size of each customer cohort
-- Problem: https://xomdata.com/practice/medium-cohort-004
-- Solved: 2026-11-05




with order_info as (
SELECT *, row_number() over(partition by customer_id order by order_date asc) rk
FROM orders 
)
select to_char(order_date::timestamp,'YYYY-mm') cohort_month, count (*) as cohort_size
from order_info
where rk = 1
group by to_char(order_date::timestamp,'YYYY-mm')
order by to_char(order_date::timestamp,'YYYY-mm')  asc
