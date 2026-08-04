-- Xom Data · Multi-level profit margin analysis
-- Problem: https://xomdata.com/practice/hard-multicte-001
-- Solved: 2026-08-04



with tmp as (
select category, name as product_name, sum (quantity * price) as revenue, sum (unit_cost * quantity) cost
, sum (quantity * price) - sum (unit_cost * quantity) profit
from orders ord 
left join products prd 
on ord.product_id = prd.id
group by category, name
)
select category, product_name, revenue, cost , profit, round (cast (profit as real )/revenue * 100,2) margin_pct
, dense_rank () over (partition by category order by profit desc) rank_in_cat
, round (cast (profit as real ) / (max (profit) over(partition by category order by profit desc)) * 100 ,2)pct_of_top_in_cat
from tmp 
order by category asc, rank_in_cat asc, product_name asc

-- pct_of_top_in_cat
-- =
-- profit
-- /
-- max_profit_in_category
-- × 100
