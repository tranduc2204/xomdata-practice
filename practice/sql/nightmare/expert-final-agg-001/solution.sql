-- Xom Data · Quarterly sales per employee (2024)
-- Problem: https://xomdata.com/practice/expert-final-agg-001
-- Solved: 2026-09-02

SELECT 
    employee_id,
    SUM(CASE WHEN quarter = 1 THEN revenue ELSE 0 END) AS Q1,
    SUM(CASE WHEN quarter = 2 THEN revenue ELSE 0 END) AS Q2,
    SUM(CASE WHEN quarter = 3 THEN revenue ELSE 0 END) AS Q3,
    SUM(CASE WHEN quarter = 4 THEN revenue ELSE 0 END) AS Q4
FROM sales
where year = 2024
GROUP BY employee_id
order by employee_id asc
