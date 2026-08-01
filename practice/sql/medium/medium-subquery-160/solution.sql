-- Xom Data · Low-activity users
-- Problem: https://xomdata.com/practice/medium-subquery-160
-- Solved: 2026-08-01



with tmp as (
select user_name, count (ord.id) order_count, sum (value) total_value, round (avg(value) ,2 ) avg_order_value 
from orders ord
right join users usr
on ord.user_id = usr.id
group by user_name
)



,  tmp1  as(
select user_name, order_count, total_value, avg_order_value-- avg_count,



, avg (total_value) over () as avg_all
from tmp

)
select user_name, order_count, total_value, avg_order_value
,case 
    when order_count = 0 then 'Inactive'
    when total_value < avg_all then 'Low'
    else 'Normal'
end as tier   --, avg_all
-- , activity_rank-- , avg_all
, rank () over(order by total_value asc) activity_rank
,  ROUND(
        PERCENT_RANK() OVER (ORDER BY total_value),
        2
    ) * 100 AS pct_above_peers
from tmp1
where order_count = 0 or total_value < avg_all
order by activity_rank asc, tier asc, user_name asc
