
  
  create view "takehome"."dev_staging"."stg_medications__dbt_tmp" as (
    select
    id   as medication_id,
    name as medication_name
from "takehome"."raw"."medications"
  );
