-- Xom Data · Sales rankings with department names
-- Problem: https://xomdata.com/practice/medium-winjoin-001
-- Solved: 2026-10-27

-- Write your SQL here


select deps.dept_name, rank() over(partition by dept_name order by sales_amount desc) dept_rank, staff_name,sales_amount
from staff st
left join departments deps
on st.dept_id = deps.id 
order by dept_name asc,  dept_rank asc,  staff_name asc
