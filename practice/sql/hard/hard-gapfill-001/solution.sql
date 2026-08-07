-- Xom Data · Daily revenue including zero-sale days
-- Problem: https://xomdata.com/practice/hard-gapfill-001
-- Solved: 2026-08-07



-- with mindate as (
-- select min (date) as min_date 
-- from daily_revenue 
-- )
-- , maxdate as (
--    select max (date) as max_date 
--     from daily_revenue  
-- )

-- select min_date, max_date, julianday(max_date) - julianday(min_date) date_diff
-- from mindate cross join maxdate



WITH RECURSIVE dates AS (

    SELECT min(date) AS dt
    from daily_revenue

    UNION ALL

    SELECT date(dt, '+1 day')
    FROM dates
    cross join (select max (date) as date_mx from daily_revenue)
    WHERE dt < date_mx
)
select d.dt as date, sum (coalesce(amount,0)) revenue
from daily_revenue dr
full join dates d on dr.date = d.dt
group by d.dt
order by d.dt asc
