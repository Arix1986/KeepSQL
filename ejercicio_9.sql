SELECT  
  ivr_id,
  IF(MAX(step_name = 'CUSTOMERINFOBYPHONE.TX' AND step_result = 'OK'), 1, 0) AS info_by_phone_log
FROM `keepcodign.Keepdataset.ivr_details`
GROUP BY ivr_id;