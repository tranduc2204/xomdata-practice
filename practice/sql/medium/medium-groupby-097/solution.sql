-- Xom Data · Top 10 most-engaged posts
-- Problem: https://xomdata.com/practice/medium-groupby-097
-- Solved: 2026-08-02


-- select *--full_name, post_type, post_date, sum (like_count) + sum (comment_count) + sum (share_count) total_interactions
-- from posts po
-- left join users u
-- on po.user_id = u.id
-- group by full_name, post_type, post_date

-- with tmp as (
-- select full_name, post_type, post_date, sum (like_count) + sum (comment_count) + sum (share_count) total_interactions
-- from posts po
-- left join users u
-- on po.user_id = u.id
-- group by full_name, post_type, post_date
-- )

-- select  full_name, post_type, post_date, total_interactions
-- , rank () over(order by total_interactions desc) overall_rank
-- , row_number() over(partition by full_name order by total_interactions desc, post_date asc) rank_in_author
-- , round (cast (total_interactions as real) / max (total_interactions) over() * 100,2) pct_of_top
-- from tmp

-- order by overall_rank asc , full_name asc, rank_in_author asc
-- limit 10 

WITH tmp AS (
    SELECT
        u.full_name,
        po.post_type,
        po.post_date,
        po.id,
        po.like_count
        + po.comment_count
        + po.share_count AS total_interactions
    FROM posts po
    JOIN users u
        ON po.user_id = u.id
)

SELECT
    full_name,
    post_type,
    post_date,
    total_interactions,

    RANK() OVER (
        ORDER BY total_interactions DESC
    ) AS overall_rank,

    ROW_NUMBER() OVER (
        PARTITION BY full_name
        ORDER BY total_interactions DESC,
                 post_date ASC
    ) AS rank_in_author,

    ROUND(
        total_interactions * 100.0
        / MAX(total_interactions) OVER ()
    , 2) AS pct_of_top

FROM tmp
ORDER BY
    overall_rank,
    full_name,
    rank_in_author
LIMIT 10;
