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
)
SELECT s."Year", s."Specified", t."Total" - s."Specified" AS "Unspecified"
FROM specified s
JOIN total t ON s."Year" = t."Year";
