-- https://datalemur.com/questions/non-profitable-drugs
SELECT 
  manufacturer,
  COUNT(manufacturer) AS drug_count,
  SUM(cogs - total_sales)  AS total_loss
FROM pharmacy_sales
WHERE cogs > total_sales
GROUP BY manufacturer
ORDER BY total_loss DESC