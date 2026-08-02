-- Xom Data · Showtime count and average ticket price per film
-- Problem: https://xomdata.com/practice/medium-join-076
-- Solved: 2026-08-02




with tmp as (
select movie_name, genres, count (st.id) showtime_count, round (avg(ticket_price),0) avg_ticket_price
from showtimes st--, dense_rank () over(partition by genres order by )
left join movies mv
on st.movie_id = mv.id
group by movie_name, genres
), tmp1 as (
select *
,dense_rank () over(partition by genres order by avg_ticket_price desc) rank_in_genre
from tmp
), tmp2 as (select movie_name, genres
from tmp1
where rank_in_genre = 1
)
select tmp1.*, tmp2.movie_name as top_movie_in_genre
from tmp1 
left join tmp2 on tmp1.genres = tmp2.genres
