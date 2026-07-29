-- Xom Data · Classify products by sales velocity
-- Problem: https://xomdata.com/practice/medium-case-110
-- Solved: 2026-07-29

with tmp as (
select name, categories, sum(quantity) total_sold,
case 
    when sum(quantity) >= 100 then 'Best Seller'
    when sum(quantity) >= 50 and sum(quantity) < 100 then 'Average'
    else  'Slow Mover'
end as classification,
dense_rank () over (partition by categories order by sum(quantity)  desc) as rank_in_cat--, sum () over(partitoin by categories)
from transactions trans
left join products prd 
on trans.product_id  = prd.id
group by name, categories
), tmp1 as (
select name, categories,  total_sold,classification, rank_in_cat, sum (total_sold) over(partition by categories) as total
from tmp 
)
select name, categories,  total_sold,classification, rank_in_cat, round((cast(total_sold as real) / total) * 100,2) as pct_of_cat_total
from tmp1
