-- Xom Data · Each aisle's best seller
-- Problem: https://xomdata.com/practice/medium-winjoin-003
-- Solved: 2026-10-20

-- Write your SQL here

with tmp as (
select cat.category_name, prd.product_name, prd.units_sold, rank ()over(partition by cat.category_name order by units_sold desc, prd.product_name asc) rk
from products prd 
left join categories cat 
on prd.category_id = cat.id 
)
select category_name, product_name, units_sold
from tmp 
where rk = 1
order by category_name asc
