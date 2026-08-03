-- Xom Data · Top 10 highest-profit dishes
-- Problem: https://xomdata.com/practice/medium-agg-147
-- Solved: 2026-08-03





select dish_name, category_name, sum  ( quantity) as total_sold
, sum (unit_price * quantity) as revenue

, sum (unit_price * quantity) - sum (cost_price* quantity ) profit
, round (cast (sum (unit_price * quantity) - sum (cost_price* quantity ) as real)  / sum (unit_price * quantity)  * 100,2) as margin_pct
, rank () over (order by sum (unit_price * quantity) - sum (cost_price* quantity ) desc ) rank_by_profit
, rank () over (order by cast (sum (unit_price * quantity) - sum (cost_price* quantity ) as real)  / sum (unit_price * quantity)  * 100 desc ) rank_by_margin
from orders ord 
left join order_items ord_it
on ord.id = ord_it.order_id
left join dishes dis
on ord_it.dish_id =  dis.id
left join categories cat 
on dis.category_id =  cat.id
where status = 'Completed'
group by dish_name, category_name
order by profit desc , dish_name asc
