-- Xom Data · How much is the first 90 days of life worth
-- Problem: https://xomdata.com/practice/hard-ltv-003
-- Solved: 2026-11-12



--order_date::date + INTERVAL '90 days' as future_date


with info_orders as (
select *, row_number() over(partition by customer_id order by order_date asc) rk

from orders     
), info_order_date_first as (
select *
from info_orders
where rk = 1
), info_customer_cohort as (
select ford.order_date, ord.customer_id,  ord.order_id,ord.amount ,
case 
    when ord.order_date::date - ford.order_date::date <= 90
        then 1
    else 0
end as column_check

from orders ord 
left join info_order_date_first ford on ord.customer_id  = ford.customer_id
), pre_result as (
select * , sum (amount) over(partition by customer_id) as amount_per_cus
--, avg(amount) over(partition by to_char(order_date::date, 'YYYY-mm'))  --order_date, count(distinct customer_id)
from info_customer_cohort
where column_check =1
),  result as (
select distinct to_char(order_date::date, 'YYYY-mm') as cohort_month, customer_id, amount_per_cus

--to_char(order_date::date, 'YYYY-mm') as cohort_month, customer_id , sum(amount_per_cus) over(partition by to_char(order_date::date, 'YYYY-mm')) as sum_total
from pre_result
)
select cohort_month, count (distinct customer_id) as cohort_size, round (sum(amount_per_cus) / count (distinct customer_id) ,2) avg_ltv_90d
from result 
group by cohort_month
order by cohort_size asc
