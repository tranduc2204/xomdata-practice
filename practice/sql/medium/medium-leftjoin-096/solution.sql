-- Xom Data · Accounts with no posts
-- Problem: https://xomdata.com/practice/medium-leftjoin-096
-- Solved: 2026-08-03



select full_name,username,  account_type, row_number() over(order by created_at asc, full_name asc) signup_order
, NTILE(4) OVER (
    ORDER BY created_at asc
)tenure_quartile
from users 
where id not in (select distinct user_id from posts)
order by created_at asc
