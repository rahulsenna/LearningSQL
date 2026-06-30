-- https://datalemur.com/questions/sql-bloomberg-stock-min-max-1

-- my solution
WITH Ranked AS (
    SELECT *,
        ROW_NUMBER() OVER (
            PARTITION BY ticker
            ORDER BY open DESC
        ) AS hi_o,
        ROW_NUMBER() OVER (
            PARTITION BY ticker
            ORDER BY open
        ) AS lo_o
    FROM stock_prices
)

SELECT
    hi.ticker,
    TO_CHAR(hi.date, 'Mon-YYYY') AS highest_mth,
    hi.open AS highest_open,
    TO_CHAR(lo.date, 'Mon-YYYY') AS lowest_mth,
    lo.open AS lowest_open
FROM Ranked hi
JOIN Ranked lo
    ON hi.ticker = lo.ticker
WHERE hi.hi_o = 1
  AND lo.lo_o = 1
ORDER BY hi.ticker;

--
-- Conditional Aggregation

SELECT
    ticker,
    MAX(CASE WHEN hi_o = 1
             THEN TO_CHAR(date, 'Mon-YYYY')
        END) AS highest_mth,

    MAX(CASE WHEN hi_o = 1
             THEN open
        END) AS highest_open,

    MAX(CASE WHEN lo_o = 1
             THEN TO_CHAR(date, 'Mon-YYYY')
        END) AS lowest_mth,

    MAX(CASE WHEN lo_o = 1
             THEN open
        END) AS lowest_open
FROM Ranked
GROUP BY ticker
ORDER BY ticker;

-- FIRST_VALUE()

WITH Prices AS (
    SELECT
        ticker,

        FIRST_VALUE(open) OVER (
            PARTITION BY ticker
            ORDER BY open DESC
        ) AS highest_open,

        FIRST_VALUE(date) OVER (
            PARTITION BY ticker
            ORDER BY open DESC
        ) AS highest_date,

        FIRST_VALUE(open) OVER (
            PARTITION BY ticker
            ORDER BY open
        ) AS lowest_open,

        FIRST_VALUE(date) OVER (
            PARTITION BY ticker
            ORDER BY open
        ) AS lowest_date
    FROM stock_prices
)

SELECT DISTINCT
    ticker,
    TO_CHAR(highest_date, 'Mon-YYYY') AS highest_mth,
    highest_open,
    TO_CHAR(lowest_date, 'Mon-YYYY') AS lowest_mth,
    lowest_open
FROM Prices
ORDER BY ticker;