
  
    
    

    create  table
      "takehome"."dev_silver"."lab_results__dbt_tmp"
  
    as (
      select *
from "takehome"."dev_staging"."stg_lab_results"
    );
  
  