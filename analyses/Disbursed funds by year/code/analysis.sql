WITH specified AS (
  SELECT sf.year AS "Year", ROUND(SUM(sf.value)) AS "Specified"
  FROM simple_flows sf
  WHERE sf.flow_type = 'disbursed_funds'
    AND sf.year BETWEEN 2016 AND 2022
    AND sf.response_or_capacity = 'capacity'
    -- 2 is unspecified tag, 4 is general IHR tag
    AND NOT sf.core_capacities @> ARRAY[2]::int[]
    AND NOT sf.core_capacities @> ARRAY[4]::int[]
  GROUP BY sf."year"
),
total AS (
  SELECT sf.year AS "Year", ROUND(SUM(sf.value)) AS "Total"
  FROM simple_flows sf
  WHERE sf.flow_type = 'disbursed_funds'
    AND sf.year BETWEEN 2016 AND 2022
    AND sf.response_or_capacity = 'capacity'
  GROUP BY sf."year"
),
response AS (
  SELECT sf.year AS "Year", ROUND(SUM(sf.value)) AS "Response"
  FROM simple_flows sf
  WHERE sf.flow_type = 'disbursed_funds'
    AND sf.year BETWEEN 2016 AND 2022
    AND sf.response_or_capacity = 'response'
  GROUP BY sf."year"
)
SELECT specified."Year", specified."Specified", total."Total" - specified."Specified" AS "Unspecified", response."Response"
FROM response
JOIN specified ON specified."Year" = response."Year"
JOIN total ON specified."Year" = total."Year";
