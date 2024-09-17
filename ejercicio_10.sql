SELECT  
  ivr_id,
  IF(MAX(step_name = 'CUSTOMERINFOBYDNI.TX' AND step_result = 'OK'), 1, 0) AS info_by_dni_log
FROM `keepcoding.ivr_details`
GROUP BY ivr_id;