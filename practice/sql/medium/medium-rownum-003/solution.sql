-- Xom Data · Visit number within each day
-- Problem: https://xomdata.com/practice/medium-rownum-003
-- Solved: 2026-10-10

-- Write your SQL here



select checkin_date, row_number() over(partition by checkin_date order by checkin_time asc, member_name asc ) visit_no, member_name, checkin_time
from checkins
