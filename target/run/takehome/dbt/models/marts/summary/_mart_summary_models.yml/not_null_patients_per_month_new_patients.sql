
    select
      count(*) as failures,
      count(*) != 0 as should_warn,
      count(*) != 0 as should_error
    from (
      
    
  
    
    



select new_patients
from "takehome"."dev_silver"."patients_per_month"
where new_patients is null



  
  
      
    ) dbt_internal_test