
  
  create view "takehome"."dev_staging"."stg_lab_results__dbt_tmp" as (
    with raw_json as (
    select *
    from read_json_auto('src_data/lab_results/*.json')
),
flattened as (
    select
        testId::bigint            as test_id,
        orderId::bigint           as order_id,
        patientId::bigint         as patient_id,
        cast(resultDate as date)  as result_date,
        json_extract(value, '$.componentName')::varchar   as component_name,
        json_extract(value, '$.componentRefHi')::double   as component_ref_hi,
        json_extract(value, '$.componentRefLo')::double   as component_ref_lo,
        json_extract(value, '$.componentUnits')::varchar  as component_units,
        json_extract(value, '$.resultValue')::double      as result_value
    from raw_json
    cross join json_each(testResults)
)
select *
from flattened
  );
