-- https://datalemur.com/questions/sql-histogram-tweets
SELECT
  tweet_count AS tweet_bucket,
  COUNT(user_id) AS users_num
FROM (
  SELECT 
      user_id, 
      COUNT(tweet_id) AS tweet_count 
  FROM tweets
  WHERE DATE_PART('year', tweet_date) = 2022
  GROUP BY user_id
  ) AS total_tweets
GROUP BY tweet_bucket;