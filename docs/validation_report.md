# Validation report — 2026-11-03

## Dataset checks completed

Checks were executed against the committed source CSV using independent JavaScript calculations, matching the filtering and normalisation rules in `sql/02_clean_and_model.sql`.

| Check | Observed |
|---|---:|
| Raw records | 6,704 |
| Records retained | 6,698 |
| Records excluded | 6 |
| Duplicate source IDs among retained records | 0 |
| Missing source salary values | 5 |
| Missing source education values | 3 |
| Missing source job titles | 2 |
| Missing source country values | 0 |
| Negative source salaries | 0 |
| Negative source experience | 0 |
| Countries in retained data | 5 |
| Distinct job titles in retained data | 191 |
| Education categories after normalisation | 4 |
| UK Data Analyst observations | 66 |
| UK Data Analyst average salary | approximately 127,121 source salary units |

Missingness counts overlap and should not be added together to estimate excluded rows.

## PostgreSQL execution status

**NOT EXECUTED.** The available execution environment lacks a PostgreSQL server and `psql`, and cannot install packages from the network. Therefore SQL syntax, import behaviour, foreign keys, query outputs, and all `sql/04_quality_checks.sql` assertions still require PostgreSQL execution.

Run from repository root in a dedicated local PostgreSQL instance:

```bash
createdb salary_portfolio
psql -X -v ON_ERROR_STOP=1 -d salary_portfolio -f sql/01_setup.sql
psql -X -v ON_ERROR_STOP=1 -d salary_portfolio -f sql/02_clean_and_model.sql
psql -X -v ON_ERROR_STOP=1 -d salary_portfolio -f sql/04_quality_checks.sql
psql -X -v ON_ERROR_STOP=1 -d salary_portfolio -f sql/03_analysis.sql
```

All six checks in the quality-check query should return `PASS`. Any SQL error or `FAIL` means PostgreSQL verification has not passed.

## Interpretation

The reported averages are observations from a Kaggle dataset, not independently validated labour-market benchmarks. Source salary units and sampling methodology have not been verified.
