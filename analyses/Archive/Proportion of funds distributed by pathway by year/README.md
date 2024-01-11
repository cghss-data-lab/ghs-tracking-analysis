# Proportion of funds distributed by pathway by year
This analysis generates a table of funder category, recipient category, amount distributed by year, and percentage of total distributions to that pathway over time.

## Methodology narrative
A SQL query joins stakeholders to flows which they funded and the corresponding recipients. Only "direct" flows are considered, i.e., not flows where the funder was part of a group of stakeholders among which individual amounts were not specified. The flows are grouped by funder category, recipient category, and year disbursed.

## List of filters
List the filter criteria used in the SQL query below.
- Flow type `disbursed_funds`
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
