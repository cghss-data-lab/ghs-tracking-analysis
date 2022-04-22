# Funders by PHEIC by geographic region by funder category
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

## Key takeaways from latest results
- African nations collectively responded to the 2014-16 outbreak of Ebola in West Africa, while Asian nations have contributed proportionally more to COVID-19 response than previous PHEICs. These findings build the foundations for understanding when and why countries become involved with financing, and particularly, how PHEICs motivate response funding so as to improve resource allocation in the future.
- We identified over $56 billion disbursed during PHEICs, though our topline estimates are consistently lower than numbers reported in the literature for each PHEIC. 
- International organizations and philanthropies (Bill & Melinda Gates Foundation, U.N., GAVI, World Bank, WHO) drove the response to the polio PHEIC, collectively disbursing over 55% of funds allocated to this event. For most other PHEICs, countries were the primary funders for response.
- The United States was the top funder for all PHEICs, besides polio (BMGF, $1.7B or 18.67% of all funds) and COVID-19 (GAVI, $7.0B). The U.S. gave $6.4B, or 23% of all funds, for Ebola in West Africa, $11M or 0.12% to respond to Zika, and $211M or 2% for Ebola in the DRC. There were too few H1N1 funds captured to assess top donors.
