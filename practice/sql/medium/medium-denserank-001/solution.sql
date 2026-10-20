-- Xom Data · Price tiers for rooms on sale
-- Problem: https://xomdata.com/practice/medium-denserank-001
-- Solved: 2026-10-20

-- Write your SQL here


with tmp as (
select room_no, price, dense_rank () over( order by price desc) price_tier
from rooms
)

select *
from tmp
order by price_tier asc, room_no asc
