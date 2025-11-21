{{ config(
    materialized = 'incremental',
    unique_key   = ['patient_id', 'result_date', 'component_name'],
    on_schema_change = 'sync'
) }}
with labs as (
    select
        lr.patient_id,
        lr.result_date,
        lr.component_name,
        lr.component_units,
        lr.result_value,
        lr.component_ref_lo,
        lr.component_ref_hi,
        case
            when lr.result_value < lr.component_ref_lo
              or lr.result_value > lr.component_ref_hi
            then true
            else false
        end as out_of_range
    from {{ ref('stg_lab_results') }} lr

    {% if is_incremental() %}
    -- sólo traer resultados nuevos
    where lr.result_date >
          (select coalesce(max(result_date), date '1900-01-01') from {{ this }})
    {% endif %}
),

patients as (
    select
        patient_id,
        first_name,
        last_name,
        gender,
        date_of_birth
    from {{ ref('stg_patients') }}
)

select
    p.patient_id,
    p.first_name,
    p.last_name,
    p.gender,
    p.date_of_birth,
    l.result_date,
    l.component_name,
    l.component_units,
    l.result_value,
    l.component_ref_lo,
    l.component_ref_hi,
    l.out_of_range
from labs l
left join patients p
    on p.patient_id = l.patient_id
