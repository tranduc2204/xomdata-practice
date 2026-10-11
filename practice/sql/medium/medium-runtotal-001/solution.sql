-- Xom Data · Class fund running total by day
-- Problem: https://xomdata.com/practice/medium-runtotal-001
-- Solved: 2026-10-11




-- Write your SQL here


select collect_date, amount, SUM(amount) OVER (
    ORDER BY collect_date
    ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
) running_total
from fund_log
order by collect_date
