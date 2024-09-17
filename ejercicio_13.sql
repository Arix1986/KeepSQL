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