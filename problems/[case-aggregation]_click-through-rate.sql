-- https://datalemur.com/questions/click-through-rate
SELECT
  app_id,
  ROUND(
  SUM(CASE WHEN event_type = 'click' THEN 100.0 END) /
  SUM(CASE WHEN event_type = 'impression' THEN 1.0 END)
  , 2)
FROM events
WHERE timestamp >= '2022-01-01' AND timestamp <  '2023-01-01'
GROUP BY app_id;