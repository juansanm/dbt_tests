
    select
      count(*) as failures,
      count(*) != 0 as should_warn,
      count(*) != 0 as should_error
    from (
      
    
  
    
    



select high_risk_flag
from "takehome"."dev_silver"."patient_risk_flags"
where high_risk_flag is null



  
  
      
    ) dbt_internal_test