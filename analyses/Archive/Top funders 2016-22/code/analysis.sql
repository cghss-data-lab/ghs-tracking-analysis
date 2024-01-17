
with all_countries as(
		-- All the stakeholders which are "countries"
	SELECT id FROM stakeholders 
		WHERE subcat = 'country' 
		AND iso3 IS NOT null
		AND "show"
), all_orgs as(
	-- all the organizations which should become pages
	SELECT id FROM stakeholders 
		JOIN children_to_parents_direct_credit 
		ON stakeholders.id = children_to_parents_direct_credit.parent_id
		WHERE stakeholders.cat != 'government' and stakeholders.subcat != 'sub-organization'
		AND stakeholders.iso3 IS NULL
		AND child_id = parent_id
)
-- All transaction pairs for selected stakeholders
SELECT
    s1.name AS "Funder",
    SUM(sf.value) AS "Total value",
    (SUM(sf.value) * 100 / SUM(SUM(sf.value)) OVER ()) AS "Percent of Total Funding"
FROM
    flows_to_stakeholder_origins_direct_credit ftsodc
JOIN
    simple_flows sf ON ftsodc.flow_id = sf.sf_id
JOIN
    stakeholders s1 ON ftsodc.stakeholder_id = s1.id
WHERE 
    sf.flow_type = 'disbursed_funds' 
    AND sf."year" BETWEEN 2016 AND 2022
    AND (
    	s1.id in (select * from all_countries) or s1.id in (select * from all_orgs)
    	)
GROUP BY
    s1.name
ORDER BY
    "Total value" DESC;