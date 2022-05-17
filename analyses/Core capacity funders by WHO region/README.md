# Template
This analysis generates a table showing the capacaties funded by each WHO region as a cumulative value and percentage of all capacity funding.

## Methodology narrative
A SQL query joins stakeholders to flows that they funded and aggregates by WHO region. Only "direct" flows are considered, i.e., not flows where the funder was part of a group of stakeholders among which individual amounts were not specified. The flows are joined to the core capacities they funded.

## List of filters
List the filter criteria used in the SQL query below.
- Flow type `disbursed funds`
- Funder flow assignment is `direct` (not `unknown`)

## Terminal command to run analysis
```bash
bash run.sh
```

## Key takeaways from latest results
List any key takeaways from your analysis of the results.
- Takeaway 1
- ...
- Takeaway N
