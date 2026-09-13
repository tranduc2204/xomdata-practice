-- Xom Data · Bao lâu thì khách quyết định quay lại lần hai
-- Problem: https://xomdata.com/practice/medium-gap-002
-- Solved: 2026-09-13





with filter_orders as (
select *,row_number () over(partition by customer_id order by order_date asc ) rank_day
from orders
), tmp as (
select *
from filter_orders
where rank_day <=2
), tmp1 as (
select *, lead(order_date) over(partition by customer_id order by order_Date) second_order_date
from tmp
)
select customer_id, order_date as first_order_date, second_order_date 
  ,CAST(julianday(second_order_date) - julianday(order_date) AS INTEGER) AS days_between

from tmp1
where rank_day = 1 and second_order_date is not null
