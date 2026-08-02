-- Xom Data · Candidates not yet interviewed
-- Problem: https://xomdata.com/practice/medium-leftjoin-031
-- Solved: 2026-08-02



-- select full_name, email, application_date
-- from candidates can
-- join interviews inte
-- on can.id = inte.candidate_id
with tmp as (
select full_name, email, application_date, row_number() over(order by application_date asc, full_name asc) queue_position

from candidates
where id not in (select distinct candidate_id from interviews)
)
select *
, round (PERCENT_RANK() over(order by queue_position asc) * 100,2)  older_than_pct
from tmp
order by queue_position asc
