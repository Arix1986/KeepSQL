SELECT  
ivr_id,
MAX(CASE WHEN customer_phone != 'UNKNOWN' THEN customer_phone ELSE NULL END) AS customer_phone,
FROM `keepcoding.ivr_details`
GROUP BY ivr_id