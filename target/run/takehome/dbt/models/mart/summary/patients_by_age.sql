
  
  create view "takehome"."dev"."patients_by_age__dbt_tmp" as (
    /*
    This model should work.
*/


with

pt as ( select * from "takehome"."dev_bronze"."patients" ),

pt_age as (

    select
        patient_id, 
        datediff('years', pt.date_of_birth, current_date()) as age_years

    from pt

)

select 
    age_years, 
    count(distinct patient_id) as patient_count

from pt_age

group by age_years
  );
