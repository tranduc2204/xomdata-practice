-- Xom Data · Rank hotels by room price within each destination
-- Problem: https://xomdata.com/practice/medium-join-155
-- Solved: 2026-08-03





select hotel_name, star_class, destination_name, count (distinct hr.id) room_count, min (nightly_rate) min_price, max(nightly_rate) max_price, avg(nightly_rate) avg_price, max(nightly_rate) - min(nightly_rate) as price_spread
, rank () over(partition by destination_name order by avg(nightly_rate) desc)  rank_in_destination
from hotel_rooms hr
left join hotels h
on hr.hotel_id = h.id
left join destinations des 
on des.id = h.destination_id
group by hotel_name, star_class, destination_name
having  count (distinct hr.id) >= 2
order by rank_in_destination asc, destination_name asc , hotel_name asc
