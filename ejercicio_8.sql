SELECT  
   ivr_id,
  IF(MAX(module_name = 'AVERIA_MASIVA'), 1, 0) AS masiva_lg
FROM `keepcoding.ivr_details`
GROUP BY ivr_id;