SELECT
    s1.sankey_cat AS "Funder",
    s2.sankey_cat AS "Recipient",
    ROUND(SUM(CASE WHEN sf."year" BETWEEN 2016 AND 2019 THEN sf.value ELSE 0 END)) AS "Total Value (2016-2019)",
    ROUND(SUM(CASE WHEN sf."year" BETWEEN 2020 AND 2022 THEN sf.value ELSE 0 END)) AS "Total Value (2020-2022)"
FROM
    flows_to_stakeholder_origins_direct_credit ftsodc
JOIN
    simple_flows sf ON ftsodc.flow_id = sf.sf_id
JOIN
    stakeholders s1 ON ftsodc.stakeholder_id = s1.id
JOIN
    flows_to_stakeholder_targets_direct_credit ftstdc ON sf.sf_id = ftstdc.flow_id
JOIN
    stakeholders s2 ON ftstdc.stakeholder_id = s2.id
WHERE 
    sf.flow_type = 'disbursed_funds' 
    AND sf."year" BETWEEN 2016 AND 2022
    AND s1.sankey_cat IS NOT NULL
    AND s2.sankey_cat IS NOT NULL
GROUP BY
    s1.sankey_cat, s2.sankey_cat
ORDER BY
    "Total Value (2016-2019)" DESC;
