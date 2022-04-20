# Top 50 funders and their recipients table
This analysis generates a table of the top 50 funders in the GHS Tracking dataset and all of the recipients they fund. Their names, funding pathway categories, and identity as a funder/recipient are output.

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
TODO