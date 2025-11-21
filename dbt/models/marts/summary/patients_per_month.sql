with patients as (
    select
        patient_id,
        date_activated,
        gender
    from {{ ref('patients') }}
    where date_activated is not null
),
patients_by_month as (
    select
        date_trunc('month', date_activated)                           as month,
        count(*)                                                      as new_patients,
        count(distinct case when gender = 'M' then patient_id end)    as new_patients_male,
        count(distinct case when gender = 'F' then patient_id end)    as new_patients_female
    from patients
    group by 1
)
select *
from patients_by_month
order by month
