-- https://datalemur.com/questions/spotify-streaming-history
WITH Weekly AS (
SELECT 
  user_id, song_id, COUNT(song_id) AS song_plays
FROM songs_weekly
WHERE listen_time <= '2022-08-05' 
GROUP BY user_id, song_id )

SELECT
  COALESCE(w.user_id,h.user_id) AS user_id, 
  COALESCE(w.song_id,h.song_id) AS song_id,  
  (COALESCE(h.song_plays,0) + COALESCE(w.song_plays,0)) AS song_plays
FROM songs_history h
FULL OUTER JOIN Weekly w 
ON w.user_id = h.user_id AND w.song_id = h.song_id
ORDER BY song_plays DESC


--- first solution 
WITH Weekly AS (
SELECT
user_id, song_id, song_plays
FROM
(
  SELECT 
    user_id, song_id
    ,count(*) OVER ( PARTITION BY user_id, song_id ) as song_plays
  
  FROM songs_weekly
  WHERE listen_time <= '2022-08-05'
  ) t
GROUP BY user_id, song_id, song_plays )

SELECT
COALESCE(w.user_id,h.user_id) as user_id, COALESCE(w.song_id,h.song_id) as song_id,  (COALESCE(h.song_plays,0) + COALESCE(w.song_plays,0)) as song_plays
FROM songs_history h
full outer JOIN Weekly w 
ON w.user_id = h.user_id AND w.song_id = h.song_id
ORDER BY song_plays DESC
