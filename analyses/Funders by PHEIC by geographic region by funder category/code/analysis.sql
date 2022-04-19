SELECT
    s.id AS "Funder stakeholder ID",
    s.name AS "Funder name",
    s.region_who AS "Funder WHO Region",
    s.region_geo AS "Funder geographic region",
    s.subregion_geo AS "Funder geographic sub-region",
    e.name AS "PHEIC name",
    sum(sf.value) AS "Total disbursed (nominal USD)"
FROM
    stakeholders s
    JOIN flows_to_stakeholder_origins_direct_credit ftsodc ON ftsodc.stakeholder_id = s.id
    JOIN simple_flows sf ON sf.sf_id = ftsodc.flow_id
    JOIN events_to_flows etf ON etf.flow_id = sf.sf_id
    JOIN EVENTS e ON e.id = etf.event_id
WHERE
    sf.flow_type = 'disbursed_funds'
    AND sf.response_or_capacity = 'response'
GROUP BY
    s.id,
    s.name,
    e.name,
    s.region_who,
    s.region_geo,
    s.subregion_geo
ORDER BY
    "PHEIC name",
    "Total disbursed (nominal USD)" DESC