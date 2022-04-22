# Top country funders of intl orgs subtotals
This analysis generates a table of top funders (country only) and the total disbursed post-2013 for capacity to international organizations.

## Methodology narrative
A SQL query joins stakeholders (country only) to flows that they funded (int'l orgs. only). Only "direct" flows are considered, i.e., not flows where the funder was part of a group of stakeholders among which individual amounts were not specified.

The query is filtered by flow date such that only flows occurring post-2013 are included and only flows with type `disbursed_funds` and `capacity` are included.

The sum of the flows is taken grouped by funder and recipient name.

## List of filters
- Flow date is post-2013
- Flow type `disbursed_funds`
- Flow category `capacity`
- Funder flow assignment is `direct` (not `unknown`)
- Funder category is `Country`
- Funder is "top-level" stakeholder (has no direct parents)
- Recipient category is `International`
- Recipient is "top-level" stakeholder (has no direct parents)

## Terminal command to run analysis
```bash
bash run.sh
```

## Key takeaways from latest results
- We have captured $13B flowing from countries to international orgs, but know $80B flows out of international orgs in total.  This demonstrates the difficulty of documenting dollars end-to-end. 
- The United States, United Kingdom, European Union, and Germany are the top contributors to international organizations. This aligns with similar findings about top donors overall and top bilateral donors.
- The top country funders of international organizations are also the top 20 country funders for health security capacity overall. 
