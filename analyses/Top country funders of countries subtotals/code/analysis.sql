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
SELECT
    tf."Funder name" AS "Funder name (country only, from among top 50 only)",
    tf."Funder ID",
    sum(sf.value) AS "Total disb. to countries post-2013 for cap. (nom. USD)"
FROM
    top_funders tf
    JOIN flows_to_stakeholder_origins_direct_credit ftsodc ON ftsodc.stakeholder_id = tf."Funder ID"
    JOIN flows_to_stakeholder_targets_direct_credit ftstdc ON ftstdc.flow_id = ftsodc.flow_id
    JOIN stakeholders target ON target.id = ftstdc.stakeholder_id
    JOIN simple_flows sf ON sf.sf_id = ftsodc.flow_id
WHERE
    tf."Category (country, international, or philanthropy)" = 'Country'
    AND target.cat_analysis = 'Country'
    AND tf."Funder ID" IN (
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
    AND sf.response_or_capacity = 'capacity'
    AND sf."year" BETWEEN 2014
    AND 3000
GROUP BY
    tf."Funder name",
    tf."Funder ID"
ORDER BY
    "Total disb. to countries post-2013 for cap. (nom. USD)" DESC