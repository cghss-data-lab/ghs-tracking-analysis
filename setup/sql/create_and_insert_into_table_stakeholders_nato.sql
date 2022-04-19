CREATE TABLE research.stakeholders_nato (
    stakeholder_id integer PRIMARY KEY REFERENCES stakeholders (id)
);

CREATE TABLE
INSERT INTO
    research.stakeholders_nato
SELECT
    s.id
FROM
    stakeholders s
WHERE
    s.name IN (
        'Albania',
        'Belgium',
        'Bulgaria',
        'Canada',
        'Croatia',
        'Czech Republic',
        'Denmark',
        'Estonia',
        'France',
        'Germany',
        'Greece',
        'Hungary',
        'Iceland',
        'Italy',
        'Latvia',
        'Lithuania',
        'Luxembourg',
        'Montenegro',
        'Netherlands',
        'North Macedonia',
        'Norway',
        'Poland',
        'Portugal',
        'Romania',
        'Slovakia',
        'Slovenia',
        'Spain',
        'Turkey',
        'United Kingdom',
        'United States of America'
    );