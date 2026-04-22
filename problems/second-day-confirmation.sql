-- https://datalemur.com/questions/second-day-confirmation
SELECT 
  emails.user_id
FROM emails
JOIN texts ON emails.email_id = texts.email_id
WHERE texts.signup_action = 'Confirmed'AND 
(emails.signup_date + INTERVAL '1 day') = texts.action_date;