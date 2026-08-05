-- Xom Data · Detect anomalous days vs the average
-- Problem: https://xomdata.com/practice/hard-anomaly-001
-- Solved: 2026-08-05




-- select date, value, avg (value) oveR() mean
-- from daily_metrics
-- group by date, value

with tmp as (
    select avg (value) as mean_value
    from daily_metrics
)
, tmp1 as (
select  
round (
    sqrt (
        avg(
            (value - mean_value)
            * (value - mean_value)
        )
    )
,2)stddev
from daily_metrics
cross join tmp
-- group by date, value
)
, tmp2 as (
select date, value, mean_value, stddev
,iif (stddev ==0, 0, round ((value -  mean_value) / stddev ,2)) z_score
-- , round ((value -  mean_value) / stddev ,2) z_score
from daily_metrics
cross join tmp
cross join tmp1
)
select date, value, round (mean_value,2) as mean, stddev,z_score
, case
    when z_score > 2 then 'high'
    when z_score < -2 then 'low'
    when z_score = 0 then 'normal'
    else 'normal'
end as flag
from tmp2
order by date asc


-- σ = √(
--       Σ(x - μ)²
--       / n
--     )
