# Code files
`setup.sh` creates or replaces necessary views that `analyze.sql` depends on by calling these build SQL files.
- `setup-00-top_funders_no_limit.sql` creates a view of the top funders in descending order of amount disbursed.
- `setup-01-top_funders_recipients.sql` creates a view of the top funders' recipients.

`analyze.sql` generates the analysis output.

# TODO
- Populate files
- For database: Rename attribute `sankey_cat` to `funding_pathway` or `pathway`