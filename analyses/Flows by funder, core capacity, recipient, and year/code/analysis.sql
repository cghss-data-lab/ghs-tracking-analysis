select
    sf.year as "Year",
    sf.response_or_capacity AS "Funding type",
    ce.fullname AS "Category",
    cc.fullname AS "Core capacity",
    f.name AS "Funder Name",
    f.subcat as "Funder Category",
    r.name AS "Recipient Name",
    r.subcat as "Recipient Category",
    SUM(sf.value) AS "Total Disbursed to Recipient"
FROM
    stakeholders r
    JOIN flows_to_stakeholder_targets_direct_credit ftstdc ON ftstdc.stakeholder_id = r.id
    JOIN simple_flows sf ON sf.sf_id = ftstdc.flow_id
    JOIN flows_to_stakeholder_origins_direct_credit ftsodc ON ftsodc.flow_id = ftstdc.flow_id
    JOIN stakeholders f ON f.id = ftsodc.stakeholder_id,
    ccs_to_flows ctf,
    cc_to_ce ctc,
    core_elements ce,
    core_capacities cc
WHERE
    sf.flow_type = 'disbursed_funds'
    AND r.subcat = 'country'
    AND sf.year >= 2014
    AND sf.year <= 2022
    AND ctf.flow_id = sf.sf_id
    AND ctc.cc = ctf.cc_id
    AND ce.id = ctc.ce
    AND cc.id = ctc.cc
GROUP BY
	r.name,
    f.name,
    cc.fullname,
    ce.fullname,
    sf.year,
    r.subcat,
    f.subcat,
    sf.response_or_capacity
ORDER BY
     "Year" desc,
     "Funder Name",
     "Total Disbursed to Recipient" desc;
