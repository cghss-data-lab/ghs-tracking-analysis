WITH top_level_stakeholder_ids AS (
    SELECT
        DISTINCT parent_id
    FROM
        children_to_parents_direct_credit
    WHERE
        parent_id NOT IN (
            SELECT
                DISTINCT child_id
            FROM
                children_to_parents_direct_credit
            WHERE
                parent_id != child_id
        )
)
select
	funder.name as "Funder name",
    sum(sf.value) AS "Total disbursed (nom. USD)"
FROM
    stakeholders funder
    JOIN flows_to_stakeholder_origins_direct_credit ftsodc ON ftsodc.stakeholder_id = funder.id
    JOIN flows_to_stakeholder_targets_direct_credit ftstdc ON ftstdc.flow_id = ftsodc.flow_id
    JOIN stakeholders target ON target.id = ftstdc.stakeholder_id
    JOIN simple_flows sf ON sf.sf_id = ftsodc.flow_id
WHERE
    funder.sankey_cat  = 'Country'
    AND target.sankey_cat = 'Country'
    AND funder.id IN (
        SELECT
            *
        FROM
            top_level_stakeholder_ids
    )
    AND target.id IN (
        SELECT
            *
        FROM
            top_level_stakeholder_ids
    )
    AND sf.flow_type = 'disbursed_funds'
    AND sf.response_or_capacity = 'response'
    AND sf."year" BETWEEN 2014
    AND 3000
GROUP BY
    funder.name
ORDER BY
    "Total disbursed (nom. USD)" DESC
