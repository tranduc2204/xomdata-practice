-- Xom Data · 4-step onboarding conversion rate
-- Problem: https://xomdata.com/practice/hard-funnel-001
-- Solved: 2026-08-08



with dim_event as (

    select 1 as id, 'signup' as evt_name
    union all 
    select  2 as id, 'verify_email' as evt_name
    union all 
    select 3 as id, 'first_login' as evt_name
    union all 
    select 4 as id, 'first_purchase' as evt_name
)

, tmp as (
select distinct d.id, d.evt_name, user_id
from dim_event d 
left join events e 
on d.evt_name = e.event_name

), tmp2 as (
select evt_name, coalesce (count (user_id),0) n_users
from tmp
group by evt_name
)

SELECT
    evt_name step,
    n_users,
    coalesce (ROUND(
                cast (n_users as real) * 100.0 /
                (
                    SELECT n_users
                    FROM tmp2
                    WHERE evt_name = 'signup'
                ),
                2
            ),0) AS conversion_pct
         
FROM tmp2
ORDER BY
    CASE evt_name
        WHEN 'signup' THEN 1
        WHEN 'verify_email' THEN 2
        WHEN 'first_login' THEN 3
        WHEN 'first_purchase' THEN 4
    END;
