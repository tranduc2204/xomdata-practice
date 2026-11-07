-- Xom Data · The month that exploded with new customers
-- Problem: https://xomdata.com/practice/medium-active-003
-- Solved: 2026-11-07




with order_info as (
    select *, row_number () over(partition by customer_id order by order_date asc)  rk 
    from orders

), pre_result as(
select *
from order_info
where rk = 1
)

select TO_CHAR(order_date::DATE, 'YYYY-mm') as month,  count (*) as new_customers
from pre_result
group by TO_CHAR(order_date::DATE, 'YYYY-mm')
order by count (*) desc , TO_CHAR(order_date::DATE, 'YYYY-mm') asc 
limit 1
