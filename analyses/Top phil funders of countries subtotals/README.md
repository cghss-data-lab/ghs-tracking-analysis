# Top phil funders of countries subtotals
This analysis generates a table of top funders (philanthropies only) and the total disbursed post-2013 for capacity to countries.

## Methodology narrative
A SQL query joins stakeholders (philanthropies only) to flows that they funded (countries only). Only "direct" flows are considered, i.e., not flows where the funder was part of a group of stakeholders among which individual amounts were not specified.

The query is filtered by flow date such that only flows occurring post-2013 are included and only flows with type `disbursed_funds` and `capacity` are included.

The sum of the flows is taken grouped by funder and recipient name.

## List of filters
- Flow date is post-2013
- Flow type `disbursed_funds`
- Flow category `capacity`
- Funder flow assignment is `direct` (not `unknown`)
- Funder category is `Philanthropy`
- Funder is "top-level" stakeholder (has no direct parents)
- Recipient category is `Country`
- Recipient is "top-level" stakeholder (has no direct parents)

## Terminal command to run analysis
```bash
bash run.sh
```

## Key takeaways from latest results
- This pathway (C) accounts for $17 billion in AHS disbursements – much smaller than the bilateral and IO/NGO channels (9.8% of total capacity funds).
- Currently, the Bill and Melinda Gates Foundation is the top donor for this pathway, contributing $16.4 billion (96% of the channel) to recipients globally.
- The present dataset captures only two other philanthropies (King Salman Humanitarian Aid and Relief Centre, The Power of Nutrition) among the top 50 funders, which may indicate particularly low reporting capacity among these actors.
