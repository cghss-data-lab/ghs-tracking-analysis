# Top 30 country funder disbursed normalized by GDP per capita
This analysis generates a table of top donor name (country only), total disbursed, GDP per capita, and total disbursed divided by GDP per capita

## Methodology narrative
A SQL query joins stakeholders to flows that they funded. Only "direct" flows are considered, i.e., not flows where the funder was part of a group of stakeholders among which individual amounts were not specified. Only top-level stakeholders, i.e., ones that have no direct parents, are considered. Other filters are applied as listed below.

The query is filtered such that only flows that were `disbursed_funds` and `response` are included.

The sum of the flows is taken grouped by funder name, WHO region, and PHEIC name.

## List of filters
- Flow date is post-2013
- Flow type `disbursed_funds`
- Flow category `capacity`
- Funder flow assignment is `direct` (not `unknown`)
- Funder is among top 30 funders (by disbursements)
- Funder is of type `Country`
- Recipient is not `Not reported` (**Note: debatable whether this criterion should be used.**)

## Terminal command to run analysis
```bash
bash run.sh
```

## Key takeaways from latest results
- U.S. is the top donor overall, with $50 billion disbursed for capacity-building.
- Of the top governmental donors, major funders of capacity-building efforts are mostly members of the G20 with predictable exceptions (Netherlands, Norway, Finland, Denmark, Sweden, Spain, Belgium, Ireland).
- The only G20 entities not in the top 30 funders by committed funds are Argentina, Brazil, India, Indonesia, Mexico, Russia, and South Africa, which are all net recipients.
- NATO countries tend to be leaders in health security funding overall, as they make substantial disbursements relative to GDP.
