-- Xom Data · Who stayed loyal all quarter
-- Problem: https://xomdata.com/practice/medium-active-004
-- Solved: 2026-09-13







with tmp as (
select distinct  customer_id, strftime ('%Y-%m', order_date) month_year
from orders
), tmp1 as (
select *, row_number() over(partition by customer_id ) rankk 
from tmp 
)
select distinct customer_id 
from tmp1 
where rankk =3
