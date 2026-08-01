-- Xom Data · Transaction count and amount by month
-- Problem: https://xomdata.com/practice/medium-datefunction-045
-- Solved: 2026-08-01


with tmp as (
select strftime('%Y-%m', transaction_date) as month, count (*) transaction_count, sum (amount) total_amount
from transactions
group by strftime('%Y-%m', transaction_date)
), tmp1 as (
select month, transaction_count, total_amount, lag (total_amount) over (order by month) prev
from tmp 
order by month
)select month, transaction_count, total_amount, total_amount - prev  as mom_delta
from tmp1
