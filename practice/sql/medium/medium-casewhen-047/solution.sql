-- Xom Data · Portfolio profit/loss
-- Problem: https://xomdata.com/practice/medium-casewhen-047
-- Solved: 2026-08-04

-- -- Ban đầu mình cũng không biết về cổ phiếu, nên để cho bạn nào cần 
-- Lãi/lỗ tuyệt đối = (Giá hiện tại của cổ phiếu - Giá vốn trung bình) x Số lượng đang nắm 
-- Tỷ suất lãi/lỗ = (Giá hiện tại của cổ phiếu - Giá vốn trung bình) / Giá vốn trung bình Theo % thì nhớ nhân 100.00 để nó đổi thành số thực


with tmp as (
select stock_code, stock_quantity, avg_cost_price, current_price, 
( cast (current_price as real ) - avg_cost_price) * stock_quantity as profit_loss
, round ((cast (current_price as real) - avg_cost_price) /avg_cost_price * 100,2) profit_pct
from stocks stk
join categories cat on stk.id = cat.stock_id
)
select stock_code, stock_quantity, avg_cost_price, current_price, profit_loss,profit_pct
, case
    when profit_pct > 10 then 'Strong Gain'
    when profit_pct > 0 and profit_pct <= 10 then 'Mild Gain'
    when profit_pct = 0 then  'Break Even'
    when profit_pct < 0 and profit_pct > -10 then 'Mild Loss'
    else 'Strong Loss'

end  status
, rank () over(order by profit_pct desc) rank_by_pct
, sum (avg_cost_price * stock_quantity) over(order by profit_pct desc, stock_code asc )cumulative_invested
from tmp
order by rank_by_pct asc, stock_code asc
