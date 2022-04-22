# Highest-value donor-recipient subtotals
This analysis generates a table of top funders, their recipients, and the total disbursed post-2013 for capacity.

## Methodology narrative
A SQL query joins stakeholders to flows that they funded and, separately stakeholders to flows that they received. Only "direct" flows are considered, i.e., not flows where either the funder or the recipient was part of a group of stakeholders among which individual amounts were not specified.

The query is filtered by flow date such that only flows occurring post-2013 are included and only flows with type `disbursed_funds` and `capacity` are included.

The sum of the flows is taken grouped by funder and recipient name.

## List of filters
- Flow date is post-2013
- Flow type `disbursed_funds`
- Flow category `capacity`
- Funder/Recipient flow assignment is `direct` (not `unknown`)

## Terminal command to run analysis
```bash
bash run.sh
```

## Key takeaways from latest results
- The largest individual donor-recipient flow is from the U.S.to the Global Fund (excluding 'Not reported'), with $11.3 billion disbursed. 
- The largest bilateral donor-recipient flow is from the U.S. to South Africa, at $3.6B, followed by U.S. to Nigeria ($2.7B), and U.S. to Kenya ($2.7B). 
- The Global Fund has given the largest sums of money to countries that the U.S. supports bilaterally in large capacities (i.e. Nigeria, Tanzania, Mozambique, Uganda).
- Other top donor-recipient channels include the Bill & Melinda Gates Foundation to Low and middle-income countries (LMICs) ($8.9B),the United Kingdom to LMICs ($3.3B), and the U.S. to LMICs ($2.9B). This finding speaks to the large sums of reported funds which do not provide granular information about the recipient.
