-- Xom Data · Each branch's two slowest months
-- Problem: https://xomdata.com/practice/medium-topn-004
-- Solved: 2026-10-23


-- Write your SQL here

with tmp as (
select *, row_number() over(partition by branch order by revenue asc ) rk 
from branch_monthly
)
select branch, month, revenue
from tmp
where rk <=2 
order by branch asc, revenue asc, month asc
