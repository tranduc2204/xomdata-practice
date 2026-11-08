-- Xom Data · Customer Shopping Tenure
-- Problem: https://xomdata.com/practice/medium-cohort-006
-- Solved: 2026-11-08


--(EXTRACT(year FROM AGE(end_date, start_date)) * 12) + EXTRACT(month FROM AGE(end_date, start_date)) AS total_months
with tmp as (
select customer_id, to_char (min(order_date)::date, 'YYYY-mm') as first_month, to_char(max(order_date)::date,'YYYY-mm') as last_month 
,(
            (EXTRACT(YEAR FROM MAX(order_date)::date) - EXTRACT(YEAR FROM MIN(order_date)::date)) * 12 +
            (EXTRACT(MONTH FROM MAX(order_date)::date) - EXTRACT(MONTH FROM MIN(order_date)::date))
        ) AS tenure_months
from orders
group by customer_id


)
select *
from tmp 
order by tenure_months desc, customer_id  asc

--  (EXTRACT(YEAR FROM '2024-05-20'::date) - EXTRACT(YEAR FROM '2024-03-05'::date)) * 12 +
--     (EXTRACT(MONTH FROM '2024-05-20'::date) - EXTRACT(MONTH FROM '2024-03-05'::date)) AS so_thang;

-- -- Kết quả: 2
