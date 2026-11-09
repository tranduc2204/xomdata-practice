-- Xom Data · Ward headcount next to each nurse
-- Problem: https://xomdata.com/practice/medium-winagg-005
-- Solved: 2026-11-09

-- Write your SQL here

 
select ward, nurse_name, count (id) over(partition by ward) team_size
from roster 
order by ward asc, nurse_name asc
