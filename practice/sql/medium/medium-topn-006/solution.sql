-- Xom Data · Valedictorian, salutatorian, and the score gap
-- Problem: https://xomdata.com/practice/medium-topn-006
-- Solved: 2026-10-30

-- Write your SQL here

with rank_top1_2 as (
select id as student_id,class_name, student_name, score, row_number() over(partition by class_name order by score desc, student_name asc) position
, max(score) over(partition by class_name order by score desc) score_max
from students
)
select class_name, position,  student_name, score, score_max - score as behind_top
from rank_top1_2 
where position <=2
