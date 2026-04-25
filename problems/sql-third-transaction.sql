-- https://datalemur.com/questions/sql-third-transaction
SELECT user_id, spend, transaction_date
FROM
  ( SELECT *,
    ROW_NUMBER() OVER (
      PARTITION BY user_id
      ORDER BY transaction_date
  ) AS rn
  FROM transactions
  ) t
WHERE rn = 3;