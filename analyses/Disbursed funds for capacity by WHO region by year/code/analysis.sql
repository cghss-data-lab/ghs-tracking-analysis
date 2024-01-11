SELECT s.region_who AS "Recipient WHO Region", sum(sf.value) AS "Total disbursed (nominal USD)", sf.year as "Year"
FROM stakeholders s
JOIN flows_to_stakeholder_targets_direct_credit ftstdc ON ftstdc.stakeholder_id = s.id
JOIN simple_flows sf ON sf.sf_id = ftstdc.flow_id
WHERE sf.flow_type = 'disbursed_funds'
AND sf.response_or_capacity = 'capacity'
and sf.year between 2016 and 2022
GROUP by sf.year, s.region_who;