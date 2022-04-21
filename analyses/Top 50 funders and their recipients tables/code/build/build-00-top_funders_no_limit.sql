CREATE
OR REPLACE VIEW public.top_funders_no_limit AS WITH children AS (
    SELECT
        ctpdc.child_id
    FROM
        children_to_parents_direct_credit ctpdc
    WHERE
        ctpdc.child_id <> ctpdc.parent_id
)
SELECT
    funder.id AS "Funder ID",
    funder.name AS "Funder name",
    sum(
        CASE
            WHEN sf.flow_type = 'disbursed_funds' :: flow_types THEN sf.value
            ELSE 0 :: double precision
        END
    ) AS "Total disbursed for capacity (USD, nominal)",
    funder.sankey_cat AS "Category (country, international, or philanthropy)",
    array_agg(DISTINCT recipient.id) AS "Recipient IDs",
    sum(
        CASE
            WHEN sf.flow_type = 'committed_funds' :: flow_types THEN sf.value
            ELSE 0 :: double precision
        END
    ) AS "Total committed for capacity (USD, nominal)"
FROM
    simple_flows sf,
    projects p,
    stakeholders funder,
    stakeholders recipient,
    flows_to_stakeholder_origins_direct_credit ftsodc,
    flows_to_stakeholder_targets_direct_credit ftstdc
WHERE
    ftsodc.flow_id = sf.sf_id
    AND ftsodc.stakeholder_id = funder.id
    AND ftstdc.stakeholder_id = recipient.id
    AND ftstdc.flow_id = ftsodc.flow_id
    AND (
        sf.flow_type = ANY (
            ARRAY ['disbursed_funds'::flow_types, 'committed_funds'::flow_types]
        )
    )
    AND sf.response_or_capacity = 'capacity' :: response_or_capacity_vals
    AND NOT (
        funder.id IN (
            SELECT
                children.child_id
            FROM
                children
        )
    )
    AND funder.name :: text <> 'Not reported' :: text
    AND recipient.name :: text <> 'Not reported' :: text
    AND sf.project_id = p.id
    AND (
        p.inclusion_decision <> 'EXCLUDE' :: inclusion_decision
        OR p.inclusion_decision IS NULL
    )
GROUP BY
    funder.id,
    funder.name
ORDER BY
    (
        sum(
            CASE
                WHEN sf.flow_type = 'disbursed_funds' :: flow_types THEN sf.value
                ELSE 0 :: double precision
            END
        )
    ) DESC;