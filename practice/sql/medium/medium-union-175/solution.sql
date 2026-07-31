-- Xom Data · Summary of issues to handle
-- Problem: https://xomdata.com/practice/medium-union-175
-- Solved: 2026-07-30

with complaints_v1 as (
select 'Complaint' as type, coalesce (sum (
    case 
        when status = 'Pending' then 1 
        else 0
    end 
),0) as quantity
from complaints 
)

, orders_v1 as (select 'Cancelled Order' as type, 
coalesce (sum (
    case 
        when status = 'Cancelled' then 1 
        else 0
    end 
),0) as quantity
from orders 
), products_v1 as (
select 'Out of Stock Product' as type, 
coalesce(sum (
    case 
        when status = 'Out of Stock' then 1
        else 0
    end 
),0) as quantity
from products
), tmp as (select *
from complaints_v1
union all 
select *
from orders_v1
union all 
select *
from products_v1
), tmp1 as (
select type, quantity, sum (quantity) over() quantity_All
from tmp
), tmp2 as (
select type,quantity, cast (quantity as real) / quantity_All * 100 as pct_of_total
from tmp1
), tmp3 as (
select type, quantity, pct_of_total,rank() over(order by coalesce (quantity,0) desc) as rank_pos, sum (pct_of_total) over() total_ 
from tmp2
), tmp4 as (
select type, quantity, pct_of_total, rank_pos, cast (pct_of_total as real) / total_ * 100 as perce
from tmp3
)
-- select coalesce(type,NULL ) type , coalesce (quantity,0) quantity, coalesce (round (pct_of_total,2),0) pct_of_total, rank_pos
-- ,  
--             coalesce (round ( SUM(perce) OVER (
--                 ORDER BY rank_pos asc  , type asc
--                 ROWS BETWEEN UNBOUNDED PRECEDING
--                 AND CURRENT ROW
--             ),2),0) as cumulative_pct
          
-- from tmp4
--  order by cumulative_pct asc, type asc
, tmp5 as (select  type , quantity,  round (pct_of_total,2) pct_of_total, rank_pos
,  
             round ( SUM(perce) OVER (
                ORDER BY rank_pos asc  , type asc
                ROWS BETWEEN UNBOUNDED PRECEDING
                AND CURRENT ROW
            ),2) as cumulative_pct
          
from tmp4
 order by cumulative_pct asc, type asc
)
select *--type ,coalesce(quantity,0)quantity , coalesce(pct_of_total,0) pct_of_total, rank_pos , coalesce (cumulative_pct,100 ) cumulative_pct
from tmp5
