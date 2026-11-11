-- Xom Data · Which channel produces loyal customers
-- Problem: https://xomdata.com/practice/medium-repeat-005
-- Solved: 2026-11-11






with count_customer as (
    select channel, count(distinct ord.customer_id) customers
    from orders ord 
    left join customers cst 
    on ord.customer_id = cst.customer_id 
    group by channel
), pre_count_loyal_customer  as (
    select distinct channel, ord.customer_id , count (order_id) over(partition by channel, ord.customer_id ) count_loyal_customers
    from orders ord 
    left join customers cst 
    on ord.customer_id = cst.customer_id 
),  count_loyal_customer as (
select channel,
    sum (
            case
                when count_loyal_customers >=3 then 1
                else 0
            end
    ) as quantity_loyal_perchann
from pre_count_loyal_customer
group by channel
)
select cl.channel, customers, quantity_loyal_perchann as loyal_customers,  round ((quantity_loyal_perchann * 1.0 / customers) * 100,2) as loyal_rate_pct
from count_loyal_customer cl join count_customer cc on cl.channel= cc.channel
-- select *
-- from  pre_count_loyal_customer

order by round ((quantity_loyal_perchann * 1.0 / customers) * 100,2) desc, channel asc
