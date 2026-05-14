-- https://datalemur.com/questions/signup-confirmation-rate


SELECT ROUND(count(DISTINCT t.email_id) * 1.0 / count(e.email_id), 2)
FROM emails e
LEFT JOIN texts t ON e.email_id = t.email_id AND t.signup_action = 'Confirmed'


-- stupid version
WITH Confirmed_Table AS (
SELECT email_id
FROM texts
WHERE signup_action = 'Confirmed'
)

SELECT ROUND(count(c.email_id) * 1.0 / count(*),2) as confirm_rate
FROM Confirmed_Table c
right JOIN emails e ON e.email_id = c.email_id
