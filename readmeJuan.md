# Healthcare Take-Home – dbt + DuckDB

This repo contains a small analytics pipeline for a synthetic healthcare dataset.  
The goal is to model patient activity and lab results for downstream BI use, using dbt on top of DuckDB.

---

## 1. Tech Stack

- **dbt Core** (DuckDB adapter)
- **DuckDB** as the analytical engine (`takehome.duckdb`)
- **Python** (for environment + dbt execution)
- **Source data**
  - CSVs already loaded into DuckDB under schema `raw`
  - JSON lab result files in `src_data/lab_results/*.json`

---

## 2. Data Modeling Approach

The project follows a classic **staging → intermediate → marts (silver/summary)** pattern.

### 2.1 Staging layer (`dbt/models/staging`, schema: `staging`)

First-pass standardisation of each raw table.  
All staging models are **views** on top of `raw.*`:

- `stg_patients`
- `stg_visits`
- `stg_conditions`
- `stg_documents`
- `stg_medications`
- `stg_med_admins`
- `stg_orders`
- `stg_patient_conditions`
- `stg_lab_results`  ← JSON parser for lab results

Key responsibilities:

- Rename technical IDs to business-friendly names (`id` → `patient_id`, `visit_id`, …).
- Derive basic timestamps (e.g. `updated_at` in `stg_patients`).
- Enforce simple types (dates, numerics, booleans).
- Keep the logic close to source while making the schema analytics-friendly.

`stg_lab_results` deserves special mention: it parses the nested JSON structure
using DuckDB’s JSON functions and flattens `testResults[]` into one row per component result.

### 2.2 Intermediate layer (`dbt/models/intermediate`, schema: `bronze`)

This layer joins multiple staging sources into reusable, denormalised tables.

- `patients`  
  Cleaned base patient dimension.

- `patient_medications`  
  Joins patients, conditions, orders, medications and administrations to expose which patients received which medication for which condition.

- `patient_results` (**incremental**)  
  Combines `stg_lab_results` and `stg_patients` to produce one row per patient / test / component:

  ```sql
  materialized = 'incremental'
  unique_key   = ['patient_id', 'result_date', 'component_name']
