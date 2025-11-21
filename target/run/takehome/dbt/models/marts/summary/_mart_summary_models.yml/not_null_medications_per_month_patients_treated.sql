
    select
      count(*) as failures,
      count(*) != 0 as should_warn,
      count(*) != 0 as should_error
    from (
      
    
  
    
    



select patients_treated
from "takehome"."dev_silver"."medications_per_month"
where patients_treated is null



  
  
      
    ) dbt_internal_test