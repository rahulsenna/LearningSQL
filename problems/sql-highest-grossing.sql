-- https://datalemur.com/questions/sql-highest-grossing
SELECT category, product, total_spend
FROM (
  SELECT 
  category, product, SUM(spend) as total_spend,
  RANK() OVER ( PARTITION BY category
                ORDER BY SUM(spend) DESC ) as ranking
  FROM product_spend
  WHERE transaction_date >= '2022-01-01' AND transaction_date < '2023-01-01'
  GROUP BY category, product
)t 
WHERE ranking < 3
