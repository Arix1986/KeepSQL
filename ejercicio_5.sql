SELECT  
ivr_id,
MAX(CASE WHEN document_type != 'UNKNOWN' THEN document_type ELSE NULL END) AS document_type,
MAX(CASE WHEN document_identification != 'UNKNOWN' THEN document_identification ELSE NULL END) AS document_identification
FROM `keepcoding.ivr_details`
GROUP BY ivr_id