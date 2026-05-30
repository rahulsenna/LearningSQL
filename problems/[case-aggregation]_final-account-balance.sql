-- https://datalemur.com/questions/final-account-balance
SELECT 
  account_id, 
  SUM(CASE
    WHEN transaction_type = 'Withdrawal' THEN -amount
    ELSE amount
  END) as final_balance
FROM transactions

GROUP BY account_id;