WITH CTE AS (
  SELECT
    ivr_id,
    CASE 
        WHEN phone_number = 'UNKNOWN' THEN 9999999
        ELSE CAST(phone_number AS INT64)
    END AS phone_number,
    start_date,
    LEAD(start_date) OVER (PARTITION BY CASE WHEN phone_number = 'UNKNOWN' THEN 9999999 ELSE CAST(phone_number AS INT64) END ORDER BY start_date) AS next_start_date,
    LAG(start_date) OVER (PARTITION BY CASE WHEN phone_number = 'UNKNOWN' THEN 9999999 ELSE CAST(phone_number AS INT64) END ORDER BY start_date) AS previous_start_date
   FROM `keepcoding.ivr_calls`
   
)

SELECT 
  ivr_id,
  phone_number,
  start_date,
  (CASE 
        WHEN phone_number=9999999 THEN 0
        WHEN next_start_date IS NOT NULL AND DATETIME_DIFF(next_start_date, start_date, HOUR) <= 24 THEN 1
        ELSE 0
      END) AS cause_recall_phone_24H,
  (CASE 
        WHEN phone_number=9999999 THEN 0
        WHEN previous_start_date IS NOT NULL AND DATETIME_DIFF(start_date, previous_start_date, HOUR) <= 24 THEN 1
        ELSE 0
      END) AS repeated_phone_24H
 
FROM CTE

ORDER BY  CTE.phone_number DESC, CTE.start_date