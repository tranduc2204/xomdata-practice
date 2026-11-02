-- Xom Data · Three Freshness Circles of the Customer Base
-- Problem: https://xomdata.com/practice/medium-recency-004
-- Solved: 2026-11-02



with filter_cus as (
select *, row_number() over(partition by customer_id order by order_date desc) rk
from orders
), tmp as (
select *, CAST('2024-06-30' AS DATE) stone   from filter_cus
where rk = 1

), tmp1 as (
select *, (stone - cast(order_date as date)) as _count,
case 
    when (stone - cast(order_date as date)) <=30 then 'hot'
    when (stone - cast(order_date as date)) <=90 and (stone - cast(order_date as date)) >30 then 'warm'
    else  'cold'
end as freshness_bucket

from tmp 
)select freshness_bucket,count (*) customer_count
from tmp1
group by freshness_bucket
order by 
 CASE freshness_bucket
    WHEN 'hot'  THEN 1
    WHEN 'warm' THEN 2
    WHEN 'cold' THEN 3
    ELSE 4 -- Puts any other or unexpected values at the very end
END ASC, count (*)  desc
