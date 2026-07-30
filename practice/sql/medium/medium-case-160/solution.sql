-- Xom Data · Delivery performance by size class
-- Problem: https://xomdata.com/practice/medium-case-160
-- Solved: 2026-07-30



-- select vehicle_type, capacity_tons, truck_id, results
-- from deliveries deli
-- left join shipments sp 
-- on deli.shipment_id = sp.id
-- left join trucks trk
-- on trk.id = sp.truck_id


with tmp as (
select vehicle_type, capacity_tons, count (*) shipment_count, results,--, capacity_tons
sum(
    case when results == 'success' then 1
    else 0
    end 
) as delivered
from deliveries deli
left join shipments sp 
on deli.shipment_id = sp.id
left join trucks trk
on trk.id = sp.truck_id
group by vehicle_type, capacity_tons, results
), tmp1 as (
select vehicle_type, capacity_tons, sum(shipment_count) shipment_count, sum(delivered) delivered
,case 
    when capacity_tons >= 10 then 'Large Truck'
    when capacity_tons >=5 and capacity_tons < 10 then 'Medium Truck'
    else 'Small Truck'
end as size_class
from tmp
group by vehicle_type, capacity_tons
), tmp2 as (
select vehicle_type, capacity_tons,shipment_count, delivered, size_class
, round (cast (delivered as real) / shipment_count * 100 ,2) delivery_rate

from tmp1
), tmp3 as (
select vehicle_type, capacity_tons,shipment_count, delivered, size_class, delivery_rate
, rank () over(partition by size_class order by delivery_rate desc) rank_in_size 
from tmp2 
)
select vehicle_type, capacity_tons,shipment_count,  size_class,delivered, delivery_rate, rank_in_size
from tmp3
order by size_class asc, rank_in_size asc , vehicle_type asc 


-- with tmp as
-- (
-- select vehicle_type, capacity_tons, count(*) as shipment_count
-- , 
-- case 
--     when capacity_tons > 10 then 'Large Truck'
--     when capacity_tons >=5 and capacity_tons < 10 then 'Medium Truck'
--     else 'Small Truck'
-- end as size_class, results
-- -- , 
-- -- count(
-- --     case when results == 'success' then 1
-- --     else 0
-- --     end 
-- -- ) over ( partition by deli.id)as delivered
-- from deliveries deli
-- left join shipments sp 
-- on deli.shipment_id = sp.id
-- left join trucks trk
-- on trk.id = sp.truck_id
-- group by vehicle_type, capacity_tons, results
-- ), tmp1 as (
-- select vehicle_type, capacity_tons, sum(shipment_count) shipment_count, size_class, 
-- count(
--     case when results == 'success' then 1
--     else 0
--     end 
-- ) as delivered
-- from tmp
-- group by vehicle_type, capacity_tons,size_class
-- ), tmp2 as (
-- select vehicle_type, capacity_tons, shipment_count, size_class, delivered, round ((cast (delivered as real) / shipment_count)*100,2) as delivery_rate
-- from tmp1
-- )
-- select vehicle_type, capacity_tons, shipment_count, size_class, delivered, delivery_rate, rank () over(partition by size_class order by delivery_rate desc) as rank_in_size
-- from tmp2
-- order by  size_class asc, rank_in_size asc, vehicle_type asc
