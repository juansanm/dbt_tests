
  
  create view "takehome"."dev_staging"."stg_conditions__dbt_tmp" as (
    select
    id   as condition_id,
    name as condition_name
from "takehome"."raw"."conditions"
  );
