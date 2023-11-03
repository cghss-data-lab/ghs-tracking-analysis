SELECT
    f.name AS "Funder Name",
    r.name AS "Recipient Name",
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
    AND r.subcat = 'country'
    AND sf.year >= 2014
GROUP BY
    r.name,
    f.name,
    e.name
ORDER BY
    "Total Disbursed to Recipient" DESC;
