-- Xom Data · Monthly income and expense report
-- Problem: https://xomdata.com/practice/medium-groupby-080
-- Solved: 2026-08-04


with tmp as (
select strftime('%Y-%m', transaction_date) as month
, coalesce (sum (
    case 
        when type = 'Thu' then amount
    end 
),0) total_income
, coalesce (sum (
    case
        when type = 'Chi' then amount
    end
),0) total_expense
from transactions
group by strftime('%Y-%m', transaction_date)
), tmp1 as (
select month, total_income, total_expense, total_income - total_expense as balance
, SUM( cast (total_income as real ) - total_expense) OVER (
        ORDER BY month
    ) AS cumulative_balance
-- , case 
--     when total_income > total_expense then 'Surplus'
--     when total_income <  total_expense then 'Deficit'
--     else 'Balanced'
from tmp
group by month, total_income, total_expense, total_income - total_expense
)

select month, coalesce (total_income,0)total_income, coalesce(total_expense,0)total_expense, coalesce(balance,0) balance, coalesce(cumulative_balance,0)cumulative_balance
, case 
    when total_income > total_expense then 'Surplus'
    when total_income <  total_expense then 'Deficit'
    else 'Balanced'
end status
from tmp1 
order by month asc
