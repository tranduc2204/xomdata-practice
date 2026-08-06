-- Xom Data · Top 3 products by sales in each category
-- Problem: https://xomdata.com/practice/hard-topn-001
-- Solved: 2026-08-06



with tmp as (
select category, name as product_name, units_sold , dense_rank () over(partition by category order by units_sold desc)  rank_in_cat 
from products

)
select category, product_name, units_sold, rank_in_cat
from tmp
where rank_in_cat <=3
order by category asc , rank_in_cat asc ,  product_name asc
