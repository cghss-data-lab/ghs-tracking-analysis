# Highest-value donor-recipient subtotals
This analysis generates a table of funder name, funder category, funder region (WHO), PHEIC name, and percentage of all PHEIC funding.

## Methodology narrative
A SQL query joins stakeholders to flows that they funded. Only "direct" flows are considered, i.e., not flows where the funder was part of a group of stakeholders among which individual amounts were not specified. The flows are joined to the PHEIC(s) they funded.

The query is filtered such that only flows that were `disbursed_funds` and `response` are included.

The sum of the flows is taken grouped by funder name, WHO region, and PHEIC name.

## List of filters
- Flow type `disbursed_funds`
- Flow category `response`
- Funder flow assignment is `direct` (not `unknown`)

## Terminal command to run analysis
```bash
bash run.sh
```