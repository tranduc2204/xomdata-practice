-- Xom Data · Shift bonus for every top performer
-- Problem: https://xomdata.com/practice/medium-topn-003
-- Solved: 2026-10-19

-- Write your SQL here

with tmp as (
select store, staff_name, orders_served, dense_rank () over(partition by store order by orders_served desc) rankk 
from shift_stats
)
select store, staff_name, orders_served
from tmp 
where rankk = 1
order by store asc, staff_name asc
