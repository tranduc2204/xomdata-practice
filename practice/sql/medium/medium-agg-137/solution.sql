-- Xom Data · Investor trade summary
-- Problem: https://xomdata.com/practice/medium-agg-137
-- Solved: 2026-08-03

-- Summarize buy/sell totals per investor
-- SELECT
--   full_name,
--   segment
-- FROM investors i
-- JOIN trades t ON t.investor_id = i.id
-- GROUP BY i.id;
with tmp as (
select full_name, segment, count (distinct t.id) total_trades
, coalesce (sum (
  case 
    when side = 'buy' then amount
  end 
),0) as total_bought
, coalesce(sum (
  case 
    when side = 'sell' then amount
  end 
),0) as total_sold
-- , coalesce(
--   cast (sum (
--   case 
--     when side = 'buy' then amount
--   end 
-- ) as real ) 
-- - sum (
--   case 
--     when side = 'sell' then amount
--   end 
-- )
-- ,0) as net_position
, amount, side
FROM investors i
JOIN trades t ON t.investor_id = i.id
group by full_name, segment, amount, side
)
, tmp1 as (
select full_name,	segment,	sum(total_trades) total_trades,	sum(total_bought) total_bought,	sum(total_sold) total_sold

from tmp
group by full_name,	segment
), tmp2 as (
select full_name, segment, total_trades, total_bought , total_sold 
, coalesce(
  cast (total_bought as real ) - total_sold, 0)
as net_position
from tmp1 
)
select full_name,	segment,	total_trades,	total_bought,	total_sold,	net_position
, case 
  when total_bought > total_sold then 'Bull'
  when total_bought < total_sold then 'Bear'
  else 'Neutral'
  end as stance
, dense_rank () over(partition by segment order by total_bought + total_sold desc ) rank_in_segment
from tmp2
order by total_bought + total_sold desc, full_name asc
