-- Xom Data · Suppliers that deliver late frequently
-- Problem: https://xomdata.com/practice/medium-having-162
-- Solved: 2026-08-02



with tmp as (
select supplier_name, material_type, count (pu.id) as purchase_count, sum (total_value) as total_purchase_value,
ROUND(
    AVG(
        julianday(actual_receipt)
        - julianday(expected_receipt)
    ),
    2
) AS avg_late_days
, round (sum (
    cast (case 
    when actual_receipt <= expected_receipt then 1
    else 0 
    end as real )) / count (*) * 100,2) as on_time_rate 

from purchase_orders pu
left join suppliers sup 
on pu.supplier_id = sup.id
group by supplier_name, material_type
)
select supplier_name,material_type,	purchase_count,	total_purchase_value,avg_late_days, on_time_rate
, rank () over(order by avg_late_days desc) late_rank
, NTILE(4) OVER (
    ORDER BY avg_late_days DESC
) risk_tier
from tmp
where purchase_count >= 3 and avg_late_days  >0
order by late_rank asc, supplier_name asc
-- group by supplier_name,material_type,	purchase_count,	total_purchase_value,avg_late_days
