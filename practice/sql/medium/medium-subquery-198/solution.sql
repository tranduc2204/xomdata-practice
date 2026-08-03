-- Xom Data · Top 10 most-borrowed books
-- Problem: https://xomdata.com/practice/medium-subquery-198
-- Solved: 2026-08-03

with book_info as(
select bk.id as book_id, title, author_id, publisher_id, genre_id, full_name, publisher_name, genre_name
from books bk
left join authors au
on bk.author_id = au.id
left join publishers pu 
on bk.publisher_id =  pu.id
left join genres gen
on gen.id = bk.genre_id
), tmp as (
select inf.*, re.status
from book_loans bl
left join book_info inf
on inf.book_id = bl.book_id
left join reservations re 
on re.book_id == inf.book_id
), tmp1 as (
select title, full_name as authors, publisher_name, genre_name, count (*) borrow_count, status
--  , sum (
--     case 
--         when status = 'ready_pickup' then 1
--         else 0
--     end
--   ) as pending_reservation
from tmp
group by title, authors, publisher_name, genre_name, status
), tmp2 as (
select title, authors, publisher_name, genre_name,borrow_count
 , sum (
    case 
        when status = 'ready_pickup' then 1
        else 0
    end
  ) as pending_reservation

from tmp1
group by title, authors, publisher_name, genre_name,borrow_count
)
select title, authors, publisher_name, genre_name,borrow_count, pending_reservation, borrow_count + pending_reservation as engagement
, dense_rank () over(order by borrow_count + pending_reservation desc) overall_rank
, rank () over(partition by genre_name order by borrow_count + pending_reservation desc) rank_in_genre
from tmp2
order by overall_rank asc , title asc 
limit 10
