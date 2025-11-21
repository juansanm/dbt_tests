
  
  create view "takehome"."dev_staging"."stg_med_admins__dbt_tmp" as (
    select
    patient_id,
    patient_condition_id,
    medication_id,
    coalesce(date_stopped, date_started) as updated_at,
    date_started,
    date_stopped,
    dosage
from "takehome"."raw"."med_admins"
  );
