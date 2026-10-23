-- Xom Data · Top two films per genre, rank included
-- Problem: https://xomdata.com/practice/medium-topn-005
-- Solved: 2026-10-23


-- Write your SQL here


with tmp as (
select genre, rank () over(partition by genre order by revenue desc, title asc ) rank_in_genre,  title, revenue
from box_office
)
select * from tmp
where rank_in_genre <=2
