-- Xom Data · Players with 3 or more goals
-- Problem: https://xomdata.com/practice/medium-having-187
-- Solved: 2026-08-02


-- with tmp as (
-- select tm.id as team_id, tm.team_name, tm.city, pl.id as player_id, full_name, positions--, g.id as goal_id, match_id
-- from teams tm 
-- right join players pl
-- on tm.id = pl.team_id
-- left join goals g
-- on g.player_id = pl.id
-- )select *
-- from tmp 
-- -- left join penalties pen 
-- -- on tmp.player_id =  pen.player_id

with tmp as (
select tm.id as team_id, tm.team_name, tm.city, pl.id as player_id, full_name, positions
from teams tm 
right join players pl
on tm.id = pl.team_id
), tmp1 as (select  team_id, team_name, city, tmp.player_id, full_name, positions, g.id as goal_id, g.match_id
from tmp 
left join goals g
on tmp.player_id = g.player_id
), tmp2 as (
select 
-- team_id, team_name, city, tmp1.player_id, full_name, positions, goal_id, match_id, pen.player_id as player_id_pen
full_name, positions, team_name, count (goal_id) goal_count, count ( distinct match_id) scoring_matches, count (distinct pen.id) cards_received
-- ,  coalesce (round ( cast (count ( distinct match_id) as real ) / count (goal_id) ,2),0) goals_per_match
,  coalesce (round ( cast (count (goal_id) as real ) / count (distinct match_id) ,2),0) goals_per_match
-- , rank () over(partition by match id order by count (*))
from tmp1
left join penalties pen  
on tmp1.player_id  = pen.player_id
group by full_name, positions, team_name
)
select full_name, positions, team_name,goal_count, scoring_matches,cards_received, goals_per_match
, rank () over( order by goals_per_match desc) efficiency_rank
, rank () over(order by goal_count desc) volume_rank
from tmp2
where goal_count >= 3 and cards_received <=5
order by efficiency_rank asc, full_name asc 
-- with tmp as (
-- select full_name, positions, team_name, count (g.id) goal_count, count ( distinct match_id) scoring_matches, count (pen.id) cards_received
-- , round (count ( distinct match_id) / count (g.id) ,2) goals_per_match
-- -- , rank () over(partition by match id order by count (*))
-- from teams tm 
-- right join players pl
-- on tm.id = pl.team_id
-- right join goals g
-- on g.player_id = pl.id
-- left join penalties pen
-- on pen.player_id = pl.id
-- group by full_name, positions, team_name
-- ),tmp1 as (
-- select full_name,positions,team_name,goal_count,scoring_matches, cards_received, goals_per_match
-- -- , round (scoring_matches / goal_count,2) goals_per_match
-- ,dense_rank () over(order by goals_per_match desc ) efficiency_rank
-- , rank () over(order by goal_count desc) volume_rank
-- from tmp 
-- )
-- select *
-- from tmp1 
-- where goal_count >= 3 and cards_received <=5
-- order by efficiency_rank asc, full_name asc
