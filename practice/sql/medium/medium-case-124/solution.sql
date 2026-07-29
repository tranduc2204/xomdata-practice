-- Xom Data · Classify student academic performance
-- Problem: https://xomdata.com/practice/medium-case-124
-- Solved: 2026-07-29

with tmp as (select full_name, student_code, round (avg(final_score),2 ) avg_score, 
case 
    when avg(final_score) >= 9 then  'Excellent'
    when avg(final_score) >=8 and avg(final_score) < 9 then 'Good'
    when avg(final_score) >= 7 and avg(final_score) < 8 then 'Fair'
    when avg(final_score) >= 5 and avg(final_score) < 7 then 'Average'
    else 'Poor' 
end as grade
from students std 
left join scores sco
on std.id = sco.student_id 
group by full_name, student_code
)
select full_name, student_code, avg_score, grade, dense_rank () over( order by avg_score DESC ) class_rank
from tmp
