SELECT
    v.*,
    v."Stakeholder name" IN ('Norway', 'Denmark', 'Sweden', 'Finland') AS "Nordic?",
    tf."Total disbursed for capacity (USD, nominal)",
    stg.gdp AS "GDP per capita in current USD for 2020",
    CASE
        WHEN (
            stg.gdp > 0
            AND stg.gdp IS NOT NULL
        )
        AND (
            tf."Total disbursed for capacity (USD, nominal)" IS NOT NULL
        ) THEN (
            tf."Total disbursed for capacity (USD, nominal)" / stg.gdp
        )
        ELSE NULL
    END AS "Ratio of disbursed and GDP"
FROM
    venn_final v
    LEFT JOIN top_funders tf ON tf."Funder ID" = v."Stakeholder ID"
    LEFT JOIN "research".stakeholders_to_gdp stg ON stg.stakeholder_id = v."Stakeholder ID"
ORDER BY
    "Ratio of disbursed and GDP" DESC nulls last