-- Xom Data · Chuỗi tháng ghé đều dài nhất
-- Problem: https://xomdata.com/practice/hard-streak-001
-- Solved: 2026-10-09




with month_purchase as (
select distinct customer_id,DATE(order_date, 'start of month') AS month--, STRFTIME('%Y-%m', order_date) AS month
from orders
)
, tmp as (
select customer_id, month, lag(month) over(partition by customer_id order by month) pre_month
from month_purchase
), tmp1 as (
select customer_id, month, pre_month, 
CASE
    WHEN pre_month = DATE(month, '-1 month')
    THEN 0
    ELSE 1
END AS new_streak
from tmp
), tmp2 as (
select *,

SUM(new_streak) OVER (
    PARTITION BY customer_id
    ORDER BY month
    ROWS BETWEEN UNBOUNDED PRECEDING
        AND CURRENT ROW
) AS streak_id
from tmp1
), tmp3 as (
SELECT distinct 
    customer_id,
    COUNT(*) AS longest_streak
FROM tmp2
GROUP BY customer_id, streak_id
-- 
), tmp4 as (
select *, rank() over(partition by customer_id order by longest_streak desc) rk
from tmp3
)
select customer_id, longest_streak
from tmp4
where rk = 1
ORDER BY longest_streak desc, customer_id asc;
