CREATE
OR REPLACE VIEW public.top_funders_recipients AS WITH recipient_ids AS (
    SELECT
        DISTINCT unnest(top_funders."Recipient IDs") AS id
    FROM
        top_funders
),
funder_ids AS (
    SELECT
        top_funders."Funder ID"
    FROM
        top_funders
),
children AS (
    SELECT
        ctpdc.child_id
    FROM
        children_to_parents_direct_credit ctpdc
    WHERE
        ctpdc.child_id <> ctpdc.parent_id
)
SELECT
    recipient.id AS "Recipient ID",
    recipient.name AS "Recipient name",
    sum(
        CASE
            WHEN sf.flow_type = 'disbursed_funds' :: flow_types THEN sf.value
            ELSE 0 :: double precision
        END
    ) AS "Total disbursed for capacity (USD, nominal)",
    recipient.sankey_cat AS "Category (country, international, or philanthropy)",
    sum(
        CASE
            WHEN sf.flow_type = 'committed_funds' :: flow_types THEN sf.value
            ELSE 0 :: double precision
        END
    ) AS "Total committed for capacity (USD, nominal)"
FROM
    recipient_ids rids,
    stakeholders recipient,
    stakeholders funder,
    simple_flows sf,
    flows_to_stakeholder_origins_direct_credit ftsodc,
    flows_to_stakeholder_targets_direct_credit ftstdc,
    projects p
WHERE
    rids.id = recipient.id
    AND ftsodc.flow_id = sf.sf_id
    AND ftsodc.stakeholder_id = funder.id
    AND ftstdc.stakeholder_id = recipient.id
    AND ftstdc.flow_id = ftsodc.flow_id
    AND (
        sf.flow_type = ANY (
            ARRAY ['disbursed_funds'::flow_types, 'committed_funds'::flow_types]
        )
    )
    AND NOT (
        funder.id IN (
            SELECT
                children.child_id
            FROM
                children
        )
    )
    AND NOT (
        recipient.id IN (
            SELECT
                children.child_id
            FROM
                children
        )
    )
    AND funder.name :: text <> 'Not reported' :: text
    AND recipient.name :: text <> 'Not reported' :: text
    AND sf.response_or_capacity = 'capacity' :: response_or_capacity_vals
    AND sf.project_id = p.id
    AND (
        p.inclusion_decision <> 'EXCLUDE' :: inclusion_decision
        OR p.inclusion_decision IS NULL
    )
GROUP BY
    recipient.id,
    recipient.name,
    recipient.sankey_cat
ORDER BY
    (
        sum(
            CASE
                WHEN sf.flow_type = 'disbursed_funds' :: flow_types THEN sf.value
                ELSE 0 :: double precision
            END
        )
    ) DESC;