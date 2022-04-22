WITH by_region AS (
    SELECT
        coalesce(
            upper(d."Funder WHO Region" :: text),
            'Undefined'
        ) AS "Funder WHO Region",
        d."PHEIC name",
        sum(d."Total disbursed (nominal USD)") AS "Total disbursed (nominal USD)"
    FROM
        pheic_funders_by_region d
    GROUP BY
        d."Funder WHO Region",
        d."PHEIC name"
)
SELECT
    *,
    round(
        100 *(
            "Total disbursed (nominal USD)" / (
                sum("Total disbursed (nominal USD)") over (PARTITION by "PHEIC name")
            )
        ) :: numeric,
        2
    ) AS "Percentage of total disbursed for PHEIC (nominal USD)"
FROM
    by_region
ORDER BY
    2,
    3 DESC