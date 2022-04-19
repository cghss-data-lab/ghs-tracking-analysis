SELECT
    v.*,
    v."Stakeholder name" IN ('Norway', 'Denmark', 'Sweden', 'Finland') AS "Nordic?",
    tf."Total disbursed for capacity (USD, nominal)"
FROM
    venn_final v
    LEFT JOIN top_funders tf ON tf."Funder ID" = v."Stakeholder ID"