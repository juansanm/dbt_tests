
  
    
    

    create  table
      "takehome"."dev_bronze"."patients__dbt_tmp"
  
    as (
      
with 
pt as ( select * from "takehome"."dev_staging"."stg_patients" )
select
    * 
from pt
qualify 1 = row_number() over (
    partition by patient_id 
    order by updated_at desc
)
    );
  
  