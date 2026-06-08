-- https://datalemur.com/questions/sql-swapped-food-delivery
WITH data AS (SELECT * ,
LEAD(item) OVER () AS next_row,
LAG(item) OVER () AS prev_row
FROM orders)

SELECT 
order_id,
CASE 
  WHEN order_id % 2 != 0
    THEN COALESCE(next_row,item) 
    ELSE prev_row END as item
FROM data 

-- [.Official Solution ]

WITH order_counts AS (
  SELECT COUNT(order_id) AS total_orders 
  FROM orders
)

SELECT
  CASE
    WHEN order_id % 2 != 0 AND order_id != total_orders THEN order_id + 1
    WHEN order_id % 2 != 0 AND order_id = total_orders THEN order_id
    ELSE order_id - 1
  END AS corrected_order_id,
  item
FROM orders
CROSS JOIN order_counts
ORDER BY corrected_order_id;