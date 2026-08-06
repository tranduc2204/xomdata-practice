-- Xom Data · Retention rate by signup-month cohort
-- Problem: https://xomdata.com/practice/hard-cohort-001
-- Solved: 2026-08-06





with tmp as (
select distinct sig.user_id, strftime ('%Y-%m', signup_date) signup_month, strftime ('%Y-%m', active_date)  active_month
from signups sig
left join activity  act 
on sig.user_id = act.user_id
)


select signup_month, active_month,
sum (case 
    when active_month >= signup_month then 1
    else 0 
end) as n_active

from tmp 
group by signup_month, active_month
having signup_month is not null and active_month is not null and n_active >= 1
order by signup_month asc , active_month asc
