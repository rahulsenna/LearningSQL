-- https://datalemur.com/questions/frequent-callers
WITH Call_Data AS (
SELECT 
  policy_holder_id,
  COUNT ( DISTINCT case_id) AS call_count
FROM callers
GROUP BY policy_holder_id
)

SELECT COUNT(*)
FROM Call_DATA
WHERE call_count >= 3