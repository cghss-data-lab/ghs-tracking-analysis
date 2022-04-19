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
),
results AS (
    SELECT
        s.id AS "Funder stakeholder ID",
        s.name AS "Funder name",
        s.cat_analysis AS "Funder analysis category",
        s.region_who AS "Funder WHO Region",
        s.region_geo AS "Funder geographic region",
        s.subregion_geo AS "Funder geographic sub-region",
        e.name AS "PHEIC name",
        sum(sf.value) AS "Total disbursed (nominal USD)"
    FROM
        stakeholders s
        JOIN flows_to_stakeholder_origins_direct_credit ftsodc ON ftsodc.stakeholder_id = s.id
        JOIN simple_flows sf ON sf.sf_id = ftsodc.flow_id
        JOIN events_to_flows etf ON etf.flow_id = sf.sf_id
        JOIN EVENTS e ON e.id = etf.event_id
    WHERE
        sf.flow_type = 'disbursed_funds'
        AND sf.response_or_capacity = 'response'
        AND s.id IN (
            SELECT
                *
            FROM
                top_level_stakeholder_ids
        )
    GROUP BY
        s.id,
        s.name,
        e.name,
        s.region_who,
        s.region_geo,
        s.subregion_geo
    ORDER BY
        "PHEIC name",
        "Total disbursed (nominal USD)" DESC
)
SELECT
    *,
    ROUND(
        (
            "Total disbursed (nominal USD)" / sum("Total disbursed (nominal USD)") over (
                ORDER BY
                    "PHEIC name"
            )
        ) :: numeric * 100.0,
        2
    ) AS "Percentage of disbursements for this PHEIC"
FROM
    results