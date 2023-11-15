SELECT
    f.name AS "Funder Name",
    f.region_who as "Funder WHO",
    r.name AS "Recipient Name",
    r.region_who as "Recipient WHO",
    e.name AS "PHEIC Name",
    SUM(sf.value) AS "Total Disbursed to Recipient"
FROM
    stakeholders r
    JOIN flows_to_stakeholder_targets_direct_credit ftstdc ON ftstdc.stakeholder_id = r.id
    JOIN simple_flows sf ON sf.sf_id = ftstdc.flow_id
    JOIN flows_to_stakeholder_origins_direct_credit ftsodc ON ftsodc.flow_id = ftstdc.flow_id
    JOIN stakeholders f ON f.id = ftsodc.stakeholder_id
    JOIN events_to_flows etf ON etf.flow_id = sf.sf_id
    JOIN events e ON e.id = etf.event_id
WHERE
    sf.flow_type = 'disbursed_funds'
    AND sf.response_or_capacity = 'response'
GROUP BY
    r.name,
    r.region_who,
    f.name,
    f.region_who,
    e.name
ORDER BY
    "Total Disbursed to Recipient" DESC;
