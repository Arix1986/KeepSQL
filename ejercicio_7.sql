SELECT  
ivr_id,
MAX(CASE WHEN billing_account_id != 'UNKNOWN' THEN billing_account_id ELSE NULL END) AS billing_account_id,
FROM `keepcoding.ivr_details`
GROUP BY ivr_id