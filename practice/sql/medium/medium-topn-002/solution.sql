-- Xom Data · Top three sellers per category
-- Problem: https://xomdata.com/practice/medium-topn-002
-- Solved: 2026-10-19



with tmp as (
select  category, product_name, units_sold, row_number () over(partition by  trim(category) order by units_sold desc, category asc, product_name asc ) checkk
from menu_sales
)
select  category, product_name, units_sold
from tmp 
where checkk <=3 
order by  category asc,units_sold desc, product_name asc
