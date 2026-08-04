-- Xom Data · Consultation revenue by doctor
-- Problem: https://xomdata.com/practice/medium-join-141
-- Solved: 2026-08-04



with tmp as (
select faculty_name, full_name as  doctor_name, count (distinct med.id) as visit_count
, avg (visit_fee) avg_exam_fee, sum (visit_fee) as total_exam_fee
-- , rank () over(order by total_exam_fee desc) overall_rank
-- , rank () over(partition by faculty_name order by total_exam_fee desc) rank_in_faculty
from medical_visits med
left join doctors doc
on med.doctor_id = doc.id 
left join faculties fac 
on fac.id = doc.faculty_id
group by faculty_name, full_name 
)
select *
, rank () over(order by total_exam_fee desc) overall_rank
, rank () over(partition by faculty_name order by total_exam_fee desc) rank_in_faculty
from tmp 
order by total_exam_fee desc , doctor_name asc
