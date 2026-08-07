-- Xom Data · Total sales by org branch
-- Problem: https://xomdata.com/practice/hard-hierarchical-001
-- Solved: 2026-08-07




-- -- WITH RECURSIVE agen AS (
-- --     select id, name, manager_id, direct_sales , sum (direct_sales) team_total
-- --     from agents
-- --     group by 
-- --     union all 

-- --     select a.id, a.name, a.manager_id, a.direct_sales ,sum (direct_sales) team_total
-- --     FROM agents a
-- --     JOIN agen o
-- --       ON a.manager_id = o.id
    

-- -- )select *
-- -- from agen















-- WITH RECURSIVE org AS (

--     SELECT
--         id,
--         name,
--         manager_id,
--         direct_sales
--     FROM agents
--     WHERE manager_id IS NULL

--     UNION ALL

--     SELECT
--         e.id,
--         e.name,
--         e.manager_id,
--         e.direct_sales
--     FROM agents e
--     JOIN org o
--       ON e.manager_id = o.id
--     group by  e.id,
--         e.name,
--         e.manager_id,
--         e.direct_sales
-- )
-- -- , tmp1 as (
-- -- select distinct manager_id, coalesce(sum (direct_sales),0) total  --over(partition by manager_id)
-- -- from org
-- -- group by manager_id
-- -- )

-- -- select o.id as  agent_id, o.name as agent_name, o.direct_sales , coalesce(t.total,0)  + o.direct_sales team_total
-- -- from org o
-- -- left join tmp1 as t
-- -- on o.id = t.manager_id
-- -- order by coalesce(t.total,0)  + o.direct_sales desc , agent_id asc


-- select *
-- from org








WITH RECURSIVE org AS (

    SELECT
        id AS ancestor,
        id AS descendant
    FROM agents

    UNION ALL

    SELECT
        o.ancestor,
        a.id
    FROM org o
    JOIN agents a
      ON a.manager_id = o.descendant
)

SELECT
    a.id AS agent_id,
    a.name AS agent_name,
    a.direct_sales,
    SUM(d.direct_sales) AS team_total
FROM agents a
JOIN org o
  ON a.id = o.ancestor
JOIN agents d
  ON d.id = o.descendant
GROUP BY
    a.id,
    a.name,
    a.direct_sales
order by SUM(d.direct_sales) desc , agent_id asc
