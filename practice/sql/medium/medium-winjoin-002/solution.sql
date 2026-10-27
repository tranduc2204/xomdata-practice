-- Xom Data · The customer's total next to every order
-- Problem: https://xomdata.com/practice/medium-winjoin-002
-- Solved: 2026-10-27

-- Write your SQL here


select customer_name, order_date, amount, sum (amount) over(partition by customer_id) customer_total
from orders ord 
left join customers cst
on ord.customer_id = cst.id
order by customer_name
