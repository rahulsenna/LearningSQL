--https://datalemur.com/questions/time-spent-snaps
WITH SEND_OPEN_DATA AS (
SELECT 
  age_bucket,
  SUM(CASE WHEN activity_type = 'send' THEN time_spent END) AS send_time,
  SUM(CASE WHEN activity_type = 'open' THEN time_spent END) AS open_time,
  SUM(time_spent) AS total_time
FROM activities act
JOIN age_breakdown ab ON act.user_id = ab.user_ID
WHERE activity_type IN ('send', 'open')
GROUP BY ab.age_bucket)

SELECT
  age_bucket,
  ROUND(100.0*send_time/total_time,2) AS send_perc,
  ROUND(100.0*open_time/total_time,2) AS open_perc
FROM SEND_OPEN_DATA;