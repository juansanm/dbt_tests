
    select
      count(*) as failures,
      count(*) != 0 as should_warn,
      count(*) != 0 as should_error
    from (
      
    
  
    
    

with all_values as (

    select
        age_group as value_field,
        count(*) as n_records

    from "takehome"."dev_silver"."patients_by_age"
    group by age_group

)

select *
from all_values
where value_field not in (
    '0-17','18-34','35-49','50-64','65+','unknown'
)



  
  
      
    ) dbt_internal_test