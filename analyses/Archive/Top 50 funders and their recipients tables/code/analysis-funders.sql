SELECT
    *
FROM
    top_funders_no_limit tfnl
WHERE
    tfnl."Category (country, international, or philanthropy)" IS NOT NULL
LIMIT
    50