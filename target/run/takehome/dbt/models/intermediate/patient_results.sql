
        
            delete from "takehome"."dev_bronze"."patient_results" as DBT_INCREMENTAL_TARGET
            using "patient_results__dbt_tmp20251120211539481087"
            where (
                
                    "patient_results__dbt_tmp20251120211539481087".patient_id = DBT_INCREMENTAL_TARGET.patient_id
                    and 
                
                    "patient_results__dbt_tmp20251120211539481087".result_date = DBT_INCREMENTAL_TARGET.result_date
                    and 
                
                    "patient_results__dbt_tmp20251120211539481087".component_name = DBT_INCREMENTAL_TARGET.component_name
                    
                
                
            );
        
    

    insert into "takehome"."dev_bronze"."patient_results" ("patient_id", "first_name", "last_name", "gender", "date_of_birth", "result_date", "component_name", "component_units", "result_value", "component_ref_lo", "component_ref_hi", "out_of_range")
    (
        select "patient_id", "first_name", "last_name", "gender", "date_of_birth", "result_date", "component_name", "component_units", "result_value", "component_ref_lo", "component_ref_hi", "out_of_range"
        from "patient_results__dbt_tmp20251120211539481087"
    )
  