-- https://datalemur.com/questions/sql-average-post-hiatus-1
SELECT 
    user_id, 
    MAX(post_date::date) - MIN(post_date::date) AS days_between 
FROM posts
WHERE post_date >= '2021-01-01' AND post_date < '2022-01-01'
GROUP BY user_id
HAVING MAX(post_date::date) > MIN(post_date::date);

-- WHERE DATE_PART('year', post_date) = 2021


SELECT * 
FROM (
  SELECT user_id, MAX(post_date::DATE) - MIN(post_date::DATE) as days_between FROM posts
  WHERE post_date >= '2021-01-01' AND post_date < '2022-01-01'
  GROUP BY user_id
) t
WHERE days_between > 0