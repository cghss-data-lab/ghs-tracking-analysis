SELECT sf.year as "Year", ROUND(SUM(sf.value)) AS "Total Disbursed"
FROM simple_flows sf
WHERE sf.flow_type = 'disbursed_funds'
  AND sf.year BETWEEN 2016 AND 2022
  AND sf.response_or_capacity = 'capacity'
  AND NOT sf.core_capacities @> ARRAY[2]::int[]
  AND NOT sf.core_capacities @> ARRAY[4]::int[]
 group by sf."year";
