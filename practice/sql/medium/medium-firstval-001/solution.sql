-- Xom Data · The category's flagship next to each item
-- Problem: https://xomdata.com/practice/medium-firstval-001
-- Solved: 2026-10-28

-- Write your SQL here

with tmp as (
    select distinct category, id, row_number() over(partition by category order by price desc, product_name asc) rk 
    from catalog
), top_price as (
select category, id as product_id 
from tmp
where rk =1
)
, tmp1 as (
select cat.*, top_.product_id 
from catalog cat
left join top_price top_
on cat.category = top_.category 
), tmp2 as (
select tmp1.category, tmp1.product_name, tmp1.price, cat.product_name as top_product, row_number() over(partition by tmp1.category order by tmp1.price desc, tmp1.product_name asc ) rk
from tmp1
left join catalog cat
on tmp1.product_id  = cat.id 

)
select category, product_name, price, top_product
from tmp2
order by category asc, rk asc, product_name asc
