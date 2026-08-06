-- Xom Data · Revenue pivoted by product type
-- Problem: https://xomdata.com/practice/hard-pivot-001
-- Solved: 2026-08-06

-- with tmp as (
-- SELECT
--     strftime('%Y-%m', sale_date) AS month
--     ,SUM(
--         CASE
--             WHEN category = 'Electronics'
--             THEN cast (coalesce (amount,0) as real )
--             ELSE 0
--         END
--     ) AS electronics


--     ,SUM(
--         CASE
--             WHEN category = 'Clothing'
--             THEN cast (coalesce (amount,0) as real )
--             ELSE 0
--         END
--     ) AS clothing

--     ,SUM(
--         CASE
--             WHEN category = 'Food'
--             THEN cast (coalesce (amount,0) as real )
--             ELSE 0
--         END
--     ) AS food

-- FROM sales
-- GROUP BY strftime('%Y-%m', sale_date)
-- )
-- select month, electronics, clothing, food,cast (coalesce (electronics,0) as real ) +  cast (coalesce (clothing,0) as real ) + cast (coalesce (food,0) as real ) total
-- from tmp 
-- ORDER BY month asc;


SELECT
    strftime('%Y-%m', sale_date) AS month,

    SUM(
        CASE
            WHEN category = 'Electronics'
            THEN amount
            ELSE 0
        END
    ) AS electronics,

    SUM(
        CASE
            WHEN category = 'Clothing'
            THEN amount
            ELSE 0
        END
    ) AS clothing,

    SUM(
        CASE
            WHEN category = 'Food'
            THEN amount
            ELSE 0
        END
    ) AS food,

    SUM(amount) AS total

FROM sales

GROUP BY strftime('%Y-%m', sale_date)

ORDER BY month;
