# Top 50 funders and their recipients tables
This analysis generates tables of (1) the top 50 funders in the GHS Tracking dataset and (2) all of the recipients they fund. Their names, funding pathway categories, and identity as a funder/recipient are output.

## Methodology narrative
TODO

## List of filters
- Flow date is post-2013
- Flow type `disbursed_funds`
- Flow category `capacity`
- Flow form is `financial`
- Funder flow assignment is `direct` (not `unknown`)
- Funder is among top 50 funders (by disbursements)
- Recipient is not `Not reported`

## Terminal command to run analysis
```bash
bash run.sh
```

## Key takeaways from latest results
- U.S. is the top donor overall, with $56 billion disbursed. This accounts for 32% of total health security capacity-building contributions.
- The United Kingdom (7) and Germany (10) are the only other countries in the top 10 funders.
- International and philanthropic partners make up a large portion of the top 10 funders, including the Global Fund (2), the Bill & Melinda Gates Foundation (3), World Bank (4), United Nations (6), Global Alliance for Vaccines and Immunization (7), and Asian Development Bank (8).
- A number of unexpected entities made the top 50 funders, including King Salman Humanitarian Aid and Relief Centre, Plan International, Sightsavers, MSI Reproductive Choices, Malaria Consortium, Crown Agents Limited, Save the Children, Abt Associates Inc, Palladium International Limited, International Labour Organization (ILO), The Power of Nutrition, Options Consultancy Services, Action Against Hunger, Oxfam International, Concern Worldwide, and Rutgers. Several of these organizations do not have a central focus on global health security or health system capacity.
- Meanwhile, organizations such as the Skoll Foundation, Rockefeller Foundation, Resolve to Save Lives, Coalition for Epidemic Preparedness Innovations, and other well-known entities in the space did not break into the top 50 funders. This is not for a lack of financing in global health security, but more likely, a lack of public reporting and aid transparency.
