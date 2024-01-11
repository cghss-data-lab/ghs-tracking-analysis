SELECT s.region_who AS "Recipient WHO Region", sum(sf.value) AS "Total disbursed for COVID-19", sf.year as "Year"
FROM stakeholders s
JOIN flows_to_stakeholder_targets_direct_credit ftstdc ON ftstdc.stakeholder_id = s.id
JOIN simple_flows sf ON sf.sf_id = ftstdc.flow_id
JOIN events_to_flows etf ON etf.flow_id = sf.sf_id
JOIN events e ON e.id = etf.event_id
WHERE sf.flow_type = 'disbursed_funds'
AND sf.response_or_capacity = 'response'
and e.name = '2019-2022 COVID-19 Pandemic'
and sf.year between 2020 and 2022
GROUP by sf.year, s.region_who;