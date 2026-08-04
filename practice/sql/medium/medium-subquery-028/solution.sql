-- Xom Data · Students above the subject average
-- Problem: https://xomdata.com/practice/medium-subquery-028
-- Solved: 2026-08-04


with tmp as (
select full_name, subject_name, final_score, round (avg (final_score) over(partition by subject_name),2) subject_avg 
, round (final_score - avg (final_score) over(partition by subject_name),2) as diff_from_avg
from grades gr
left join subjects sub
on gr.subject_id = sub.id
left join students st 
on st.id = gr.student_id
)
select *
from tmp 
where final_score > subject_avg
order by diff_from_avg desc , full_name asc
