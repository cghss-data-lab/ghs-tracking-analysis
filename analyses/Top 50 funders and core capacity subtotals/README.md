# Top 50 funders and core capacity subtotals
This analysis generates a table of funder name, funder category, funder region (WHO), core capacity name, and percentage of all core capacity funding.

## Methodology narrative
A SQL query joins stakeholders to flows that they funded. Only "direct" flows are considered, i.e., not flows where the funder was part of a group of stakeholders among which individual amounts were not specified. The flows are joined to the core capacity they funded. The sum of the flows is taken grouped by funder name, WHO region, and core capacity name.


## List of filters
List the filter criteria used in the SQL query below.
- Flow type `disbursed_funds`
- Funder in 'Top 50 funders'
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
