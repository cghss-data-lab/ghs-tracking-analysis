# Top intl org funders of countries subtotals
This analysis generates a table of top funders (int'l orgs. only) and the total disbursed post-2013 for capacity to countries.

## Methodology narrative
A SQL query joins stakeholders (int'l orgs. only) to flows that they funded (countries only). Only "direct" flows are considered, i.e., not flows where the funder was part of a group of stakeholders among which individual amounts were not specified.

The query is filtered by flow date such that only flows occurring post-2013 are included and only flows with type `disbursed_funds` and `capacity` are included.

The sum of the flows is taken grouped by funder and recipient name.

## List of filters
- Flow date is post-2013
- Flow type `disbursed_funds`
- Flow category `capacity`
- Funder flow assignment is `direct` (not `unknown`)
- Funder category is `International`
- Funder is "top-level" stakeholder (has no direct parents)
- Recipient category is `Country`
- Recipient is "top-level" stakeholder (has no direct parents)

## Terminal command to run analysis
```bash
bash run.sh
```

## Key takeaways from latest results
- Among the top 50 funders overall, 27 stakeholders are international organizations (54%).
- Although we only track $13B contributed to international organizations by countries, more than $80B flows from international organizations back out to recipient countries. 
- Just 4 organizations contribute $69B, or 86% of the total disbursed by international organizations to countries. These include the Global Fund, World Bank, United Nations (and its agenecies), and GAVI.
