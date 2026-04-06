-- https://datalemur.com/questions/matching-skills

SELECT candidate_id FROM candidates
WHERE skill IN('Python', 'Tableau', 'PostgreSQL')
GROUP BY candidate_id 
HAVING count(skill) = 3;
