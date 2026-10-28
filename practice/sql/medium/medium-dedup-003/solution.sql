-- Xom Data · Latest readings and over-limit alerts
-- Problem: https://xomdata.com/practice/medium-dedup-003
-- Solved: 2026-10-28

-- Write your SQL here


with tmp as (
select *, row_number() over(partition by sensor_name order by reading_date desc) rk 
from readings re
left join sensors se 
on re.sensor_id = se.id 
)
select sensor_name, reading_date, temp_c, max_temp, 
case 
    when temp_c <= max_temp then 'Normal'
    else 'Alert'
end as status
from tmp
where rk = 1
