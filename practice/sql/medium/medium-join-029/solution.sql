-- Xom Data · Instructor teaching load
-- Problem: https://xomdata.com/practice/medium-join-029
-- Solved: 2026-08-04



with tmp as (

select full_name,  academic_degree, count (sub.lecturer_id) subjects_taught
, rank () over(order by count (sub.lecturer_id) desc) workload_rank

from subjects sub 
left join lecturers lec
on sub.lecturer_id =  lec.id
group by full_name,  academic_degree
)
select full_name,  academic_degree, subjects_taught, workload_rank
, sum (subjects_taught) over(order by subjects_taught desc  ROWS BETWEEN UNBOUNDED PRECEDING
             AND CURRENT ROW) cumulative_subjects
from tmp
group by full_name,  academic_degree, subjects_taught, workload_rank
