WITH core_capacity_sums AS (
    SELECT
        cc.name AS "Core Capacity",
        sf.year,
        ROUND(SUM(sf.value)) AS "Total disbursed"
    FROM
        simple_flows sf
        JOIN flows_to_stakeholder_origins_direct_credit ftsodc ON sf.sf_id = ftsodc.flow_id
        JOIN ccs_to_flows ctf ON ctf.flow_id = sf.sf_id
        JOIN core_capacities cc ON cc.id = ctf.cc_id
    WHERE
        sf.flow_type = 'disbursed_funds'
        AND sf.response_or_capacity = 'capacity'
        AND sf.year BETWEEN 2016 AND 2022
    GROUP BY
        cc.name, sf.year
)
SELECT
    year,
    SUM("Total disbursed") FILTER (WHERE "Core Capacity" = 'P.1') AS "P.1",
    SUM("Total disbursed") FILTER (WHERE "Core Capacity" = 'P.2') AS "P.2",
    SUM("Total disbursed") FILTER (WHERE "Core Capacity" = 'P.3') AS "P.3",
    SUM("Total disbursed") FILTER (WHERE "Core Capacity" = 'P.4') AS "P.4",
    SUM("Total disbursed") FILTER (WHERE "Core Capacity" = 'P.5') AS "P.5",
    SUM("Total disbursed") FILTER (WHERE "Core Capacity" = 'P.6') AS "P.6",
    SUM("Total disbursed") FILTER (WHERE "Core Capacity" = 'P.7') AS "P.7",
    SUM("Total disbursed") FILTER (WHERE "Core Capacity" = 'D.1') AS "D.1",
    SUM("Total disbursed") FILTER (WHERE "Core Capacity" = 'D.2') AS "D.2",
    SUM("Total disbursed") FILTER (WHERE "Core Capacity" = 'D.3') AS "D.3",
    SUM("Total disbursed") FILTER (WHERE "Core Capacity" = 'D.4') AS "D.4",
    SUM("Total disbursed") FILTER (WHERE "Core Capacity" = 'R.1') AS "R.1",
    SUM("Total disbursed") FILTER (WHERE "Core Capacity" = 'R.2') AS "R.2",
    SUM("Total disbursed") FILTER (WHERE "Core Capacity" = 'R.3') AS "R.3",
    SUM("Total disbursed") FILTER (WHERE "Core Capacity" = 'R.4') AS "R.4",
    SUM("Total disbursed") FILTER (WHERE "Core Capacity" = 'R.5') AS "R.5",
    SUM("Total disbursed") FILTER (WHERE "Core Capacity" = 'RE') AS "RE",
    SUM("Total disbursed") FILTER (WHERE "Core Capacity" = 'PoE') AS "PoE",
    SUM("Total disbursed") FILTER (WHERE "Core Capacity" = 'CE') AS "CE"
FROM
    core_capacity_sums
GROUP BY
    year
ORDER BY
    year;
