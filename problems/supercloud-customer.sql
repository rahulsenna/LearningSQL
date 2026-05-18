-- https://datalemur.com/questions/supercloud-customer
SELECT customer_id
FROM
  (
  SELECT 
    customer_id, 
    count(DISTINCT product_category)  
  FROM customer_contracts c
  JOIN products p 
  ON c.product_id = p.product_id
  GROUP BY customer_id
  ) t
WHERE count = (SELECT count(DISTINCT product_category) FROM products)