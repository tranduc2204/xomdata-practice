-- Xom Data · Book count and average price by genre
-- Problem: https://xomdata.com/practice/medium-coalesce-040
-- Solved: 2026-08-03



with tmp as (
select genre_name, count (distinct bk.id) book_count, avg (price) avg_price, min (price) min_price, max (price) max_price, max (price)  - min (price)  as price_range

from books bk 
full join genres gen 
on bk.genre_id = gen.id
group by genre_name
)
select  genre_name,	coalesce(book_count,0) book_count,	coalesce(avg_price,0) avg_price,	coalesce (min_price,0) min_price,	coalesce(max_price,0) max_price,	coalesce (price_range,0)price_range
, rank () over(order by book_count desc)coverage_rank
, NTILE(3) OVER (
    
        ORDER BY book_count DESC
    ) AS library_focus
from tmp
