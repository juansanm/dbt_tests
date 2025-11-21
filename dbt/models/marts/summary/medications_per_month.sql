with med_admins as (
    select
        patient_id,
        medication_id,
        date_started
    from {{ ref('stg_med_admins') }}
    where date_started is not null
),
meds as (
    select
        medication_id,
        medication_name
    from {{ ref('stg_medications') }}
),
med_admins_month as (
    select
        date_trunc('month', date_started) as month,
        medication_id,
        patient_id
    from med_admins
)
select
    m.month,
    med.medication_id,
    med.medication_name,
    count(*)                     as administrations,
    count(distinct m.patient_id) as patients_treated
from med_admins_month m
join meds med
    on m.medication_id = med.medication_id
group by 1,2,3
order by 1,2
