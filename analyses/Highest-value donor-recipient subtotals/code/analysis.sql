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
    tf."Funder name" AS "Funder name (from among top 50 only)",
    tf."Category (country, international, or philanthropy)" AS "Funder category (country, international, or philanthropy)",
    tf."Funder ID",
    target.name AS "Recipient name",
    target.cat_analysis AS "Recipient category (country, international, or philanthropy)",
    target.id AS "Recipient ID",
    sum(sf.value) AS "Total disbursed post-2013 for capacity (nominal USD)"
FROM
    top_funders tf
    JOIN flows_to_stakeholder_origins_direct_credit ftsodc ON ftsodc.stakeholder_id = tf."Funder ID"
    JOIN simple_flows sf ON sf.sf_id = ftsodc.flow_id
    JOIN flows_to_stakeholder_targets_direct_credit ftstdc ON ftstdc.flow_id = sf.sf_id
    JOIN stakeholders target ON target.id = ftstdc.stakeholder_id
WHERE
    target.id IN (
        SELECT
            *
        FROM
            top_level_stakeholder_ids
    )
    AND tf."Funder ID" IN (
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
    target.name,
    tf."Funder ID",
    target.id,
    tf."Category (country, international, or philanthropy)",
    target.cat_analysis
ORDER BY
    "Total disbursed post-2013 for capacity (nominal USD)" DESC