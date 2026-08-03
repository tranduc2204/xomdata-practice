-- Xom Data · Products more expensive than the category average
-- Problem: https://xomdata.com/practice/medium-subquery-103
-- Solved: 2026-08-03




with tmp as (
select distinct avg(price) over(partition by category) avg_price, category
from products
)
select product_name, prd.category, price,  round (price - t.avg_price,0) as diff_from_avg  --
, round ((price - t.avg_price)/t. avg_price* 100,2) as pct_above
from products prd
cross join tmp t
on prd.category = t.category
where prd.price > t.avg_price
order by pct_above desc, product_name asc



-- select product_name, category, price, round (price - tmp.avg_price,0) as diff_from_avg 

-- from products prd
-- cross join tmp 
-- -- where price >= tmp.avg_price
