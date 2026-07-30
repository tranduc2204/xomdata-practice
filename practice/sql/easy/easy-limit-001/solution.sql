-- Xom Data · 5 cheapest products
-- Problem: https://xomdata.com/practice/easy-limit-001
-- Solved: 2026-07-30

select name, price
from products 
order by price asc
limit 5
