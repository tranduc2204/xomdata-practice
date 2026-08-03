-- Xom Data · Goals and cards by team
-- Problem: https://xomdata.com/practice/medium-join-186
-- Solved: 2026-08-03


with info_player as(
select t.id as team_id , team_name, city, p.id as player_id
from teams t
join players p 
on t.id = p.team_id 
), tmp as (
select team_id, team_name, city, inf.player_id, g.id as goal_id
from goals g 
full join info_player inf 
on g.player_id = inf.player_id
), tmp1 as (
select team_id, team_name, city, t.player_id,  goal_id, p.id as penalty_id
from tmp t
full join penalties p
on t.player_id = p.player_id
)
select team_name, city, count (distinct player_id) player_count, count ( distinct goal_id) total_goals_scored, count  ( distinct penalty_id) penalty_count, round (cast (count ( distinct goal_id) as real ) / count (distinct player_id),2) goals_per_player


, round (cast (count ( distinct penalty_id) as real ) / count (distinct player_id),2) cards_per_player
, rank () over(order by count (goal_id)  desc) scoring_rank
,     SUM(count ( distinct goal_id)) OVER (
        ORDER BY count (goal_id) DESC
    ) AS cumulative_goals
from tmp1
where team_name is not null
group by team_name, city, team_id


-- select *--team_name, city, count (distinct player_id) player_count, count ( goal_id) over(partition by team_name) total_goals_scored, count  (penalty_id) penalty_count
-- from tmp1
-- group by team_name, city
