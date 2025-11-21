
  
  create view "takehome"."dev_staging"."stg_patient_conditions__dbt_tmp" as (
    select
    id                     as patient_condition_id,
    patient_id,
    condition_id,
    coalesce(date_ended, date_started) as updated_at,
    date_started,
    date_ended
from "takehome"."raw"."patient_conditions"
  );
