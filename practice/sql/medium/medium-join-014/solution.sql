-- Xom Data · Stock-in history by supplier
-- Problem: https://xomdata.com/practice/medium-join-014
-- Solved: 2026-08-01



with tmp as (
select warehouse_name, count(stk.id) import_count, count(distinct prd.id) distinct_product_count, count (distinct suppliers) distinct_supplier_count, max (import_date) last_import_date
--,rank ()over(order by count(stk.id) desc) activity_rank
--,lag (warehouse_name) over(order by count(stk.id) desc)prev_warehouse
from stock_imports stk
left join warehouses wr 
on stk.warehouse_id = wr.id 
left join products prd 
on stk.product_id = prd.id
group by warehouse_name
-- order by activity_rank asc , warehouse_name asc
)
select warehouse_name,import_count,distinct_product_count,distinct_supplier_count,	last_import_date
--,	activity_rank -- ,	prev_warehouse
,rank ()over(order by import_count desc) activity_rank
,lag (warehouse_name) over(order by import_count desc)prev_warehouse
from tmp
