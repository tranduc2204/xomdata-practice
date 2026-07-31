-- Xom Data · Average score per subject
-- Problem: https://xomdata.com/practice/medium-groupby-027
-- Solved: 2026-07-31

with tmp as (
select subject_name, credits,count(subject_id)  as student_count 
, round (avg(final_score),2) as avg_score
,sum (
    case 
        when final_score >= 5 then 1
        else 0
    end
) count_5 

from grades gr 
left join subjects sb 
on gr.subject_id = sb.id
group by subject_name, credits
)


select subject_name, credits, student_count, avg_score, round ((cast (sum (count_5) over(partition by subject_name) as real ) /  sum (student_count) over(partition by subject_name)) * 100,2) pass_rate, rank () over (order by avg_score desc) rank_by_avg, ntile(4) over(order by avg_score desc, subject_name ASC) as difficulty_quartile
-- , sum(count_5) over(), sum (student_count) over()
--, sum (count_5) over(partition by subject_name), sum (student_count) over(partition by subject_name)
from tmp
group by subject_name, credits, student_count, avg_score
order by rank_by_avg asc, subject_name asc


-- with tmp as (
-- select subject_name, credits, count(*) as student_count
-- , round (avg(final_score),2) as avg_score
-- ,
-- sum (
--     case 
--         when final_score >= 5 then 1
--         else 0
--     end
-- ) over() as count_5, count (*) over() as total_count
-- from grades gr 
-- left join subjects sb 
-- on gr.subject_id = sb.id
-- group by subject_name, credits
-- ) 

-- select subject_name,credits,student_count,avg_score,round ((cast (count_5 as real ) / total_count) * 100,2) as pass_rate, rank () over (order by avg_score desc) rank_by_avg, ntile(4) over(order by avg_score desc, subject_name ASC) as difficulty_quartile
-- from tmp
-- order by rank_by_avg asc , subject_name asc
