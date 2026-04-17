-- https://datalemur.com/questions/sql-avg-review-ratings
SELECT
  EXTRACT(MONTH from submit_date) as mth,
  product_id,
  ROUND(AVG(stars),2) as avg_stars
FROM reviews
GROUP BY mth, product_id
ORDER BY mth, product_id;