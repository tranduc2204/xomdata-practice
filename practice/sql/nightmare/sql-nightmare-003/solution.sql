-- Xom Data · 3-month consecutive disbursement rate by department
-- Problem: https://xomdata.com/practice/sql-nightmare-003
-- Solved: 2026-08-09




with tmp as (
select dept, month, sum(budget) over(partition by dept order by month asc  ROWS BETWEEN 2 preceding and CURRENT ROW) as roll3_budget, sum (actual) over(partition by dept order by month asc  ROWS BETWEEN 2 preceding and CURRENT ROW)  roll3_actual
from  budgets
order by month
)
select dept, month, roll3_budget, roll3_actual, ROUND ((cast (roll3_actual as real) /roll3_budget) * 100,2) as utilization_pct
from tmp
order by dept  asc, month asc
