WITH CTE AS (
SELECT 
ivr_id,
CASE 
    WHEN phone_number = 'UNKNOWN' THEN 9999999
    ELSE CAST(phone_number AS INT64)
    END AS phone_number,
ivr_result,
(CASE 
     WHEN  STARTS_WITH(vdn_label, 'ATC') THEN 'FRONT'
     WHEN  STARTS_WITH(vdn_label, 'TECH') THEN 'TECH'
     WHEN  vdn_label = 'ABSORPTION' THEN 'ABSORPTION'
     ELSE 'RESTO'
     END
   ) as vdn_aggregation,
 start_date,
 end_date,
 total_duration,
 customer_segment,
 ivr_language,
 steps_module,
 module_aggregation,
 MAX(CASE WHEN document_type != 'UNKNOWN' THEN document_type ELSE NULL END) AS document_type,
 MAX(CASE WHEN document_identification != 'UNKNOWN' THEN document_identification ELSE NULL END) AS document_identification,
 MAX(CASE WHEN billing_account_id != 'UNKNOWN' THEN billing_account_id ELSE NULL END) AS billing_account_id,
 MAX(CASE WHEN customer_phone != 'UNKNOWN' THEN customer_phone ELSE NULL END) AS customer_phone,
 MAX(IF(step_name = 'CUSTOMERINFOBYDNI.TX' AND step_result = 'OK', 1, 0)) AS info_by_dni_lg,
 MAX(IF(module_name = 'AVERIA_MASIVA', 1, 0)) AS masiva_lg,
 MAX(IF(step_name = 'CUSTOMERINFOBYPHONE.TX' AND step_result = 'OK', 1, 0)) AS info_by_phone_lg
 
FROM `keepcoding.ivr_details`
GROUP BY 
  ivr_id,
  phone_number,
  ivr_result,
  vdn_label,
  start_date,
  end_date,
  total_duration,
  customer_segment,
  ivr_language,
  steps_module,
  module_aggregation),
 CTE1 AS(
  SELECT CTE.*,
  LEAD(start_date) OVER (PARTITION BY phone_number ORDER BY start_date) AS next_start_date,
  LAG(start_date) OVER (PARTITION BY phone_number ORDER BY start_date) AS previous_start_date
  FROM CTE
 )
SELECT 
ivr_id,
phone_number,
ivr_result,
vdn_aggregation,
 start_date,
 end_date,
 total_duration,
 customer_segment,
 ivr_language,
 steps_module,
 module_aggregation,
 document_type,
 document_identification,
 customer_phone,
 billing_account_id,
 masiva_lg,
 info_by_phone_lg,
 info_by_dni_lg,

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
 
FROM CTE1

ORDER BY  CTE1.phone_number DESC, CTE1.start_date
---------------------------------------- EJ 13 ----------------------
CREATE TEMP FUNCTION func_clean_input_int(param INT64) AS (
  CASE
    WHEN param is NULL THEN  -9999999 ELSE param END
);

WITH CTE AS(
  SELECT 1 AS id, 100 AS value
  UNION ALL
  SELECT 2 AS id, NULL AS value
  UNION ALL
  SELECT 3 AS id, 300 AS value
)
SELECT
  id,
  func_clean_input_int(value) AS cleaned_value
FROM CTE;