-- Xom Data · Sales champion of each region
-- Problem: https://xomdata.com/practice/medium-topn-001
-- Solved: 2026-10-23

-- Write your SQL here

with tmp as (
select *, row_number () over(partition by region order by sales_amount desc, rep_name asc) as rk
from reps 
)
select region, rep_name, sales_amount
from tmp
where rk = 1
order by region asc, substr(rep_name, 1, 1) asc
