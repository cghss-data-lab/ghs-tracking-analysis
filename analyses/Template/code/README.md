# SQL query code for analysis
This directory contains at least `analysis.sql` and optionally `setup.sql`.
## `analysis.sql`
Must be SQL query returning a result set and not terminating with a semicolon, e.g.,
```sql
SELECT 1
```
The result set will be saved as a CSV (see [`../results/README.md`](../results/README.md) directory)
## `setup.sql` (optional)
Must be SQL query not terminating with a semicolon, intended to be data definition language, that completes any setup required for `analysis.sql` to work. Most commonly creates views. For example,
```sql
CREATE OR REPLACE VIEW public.test_view AS SELECT 1
```