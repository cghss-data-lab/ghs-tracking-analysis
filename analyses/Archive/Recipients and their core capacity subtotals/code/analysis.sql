SELECT ce.fullname AS "ce",
    cc.fullname AS "core capacity",
	s.name AS "recipient",
	s.subcat as "recipient category",
	sf.year as "year",
    round(sum(sf.value)) AS "value"
FROM simple_flows sf,
    flows_to_stakeholder_targets_direct_credit ftsodc,
    ccs_to_flows ctf,
    cc_to_ce ctc,
    core_elements ce,
    core_capacities cc,
	stakeholders s
WHERE sf.sf_id = ftsodc.flow_id
	AND s.id = ftsodc.stakeholder_id
    AND ctf.flow_id = sf.sf_id
    AND ctc.cc = ctf.cc_id
    AND ce.id = ctc.ce
    AND cc.id = ctc.cc
    AND sf.flow_type = 'disbursed_funds'
    AND sf.response_or_capacity = 'capacity'
	AND sf.year >= 2014
GROUP BY 
    cc.fullname,
    ce.fullname,
    sf.year,
    s.subcat,
	s.name
ORDER BY 1, 2, 5 desc,6 DESC;
