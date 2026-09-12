-- Xom Data · New customers and returning customers each month
-- Problem: https://xomdata.com/practice/hard-cohort-003
-- Solved: 2026-09-12





with tmp_return  as (
select    strftime ('%Y-%m', order_Date) order_date, customer_id 
from orders
), tmp_return1 as (
select distinct order_Date, customer_id 
from tmp_return
), tmp_return2 as (
select order_Date, customer_id , row_number () over (partition by customer_id order by order_date asc) checkk
from tmp_return1  
), tmp_return3 as (
select order_Date, customer_id
from tmp_return2
where checkk >1
)

, tmp_return4 as (
select order_date, count (*) quantity
from tmp_return3
group by order_Date
)


, tmp as  
(
    SELECT 
        customer_id,
        strftime ('%Y-%m',MIN(order_date)) AS first_order_date
    FROM 
        orders
    GROUP BY 
        customer_id
), tmp1 as (
 select count (customer_id) new_customers, first_order_date
from tmp
group by first_order_date
)
select iif (first_order_date is null,order_date, iif (order_date is null,first_order_date,order_date   ) ) as month, 
coalesce (new_customers,0) new_customers, coalesce (quantity,0) as returning_customers
from tmp_return4 a
full join tmp1 b on a.order_date = b.first_order_date
order by month asc
