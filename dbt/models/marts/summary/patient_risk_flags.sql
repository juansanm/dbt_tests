with conds as (
    select
        pc.patient_id,
        count(distinct pc.condition_id) as n_conditions
    from {{ ref('stg_patient_conditions') }} pc
    group by pc.patient_id
),

labs as (
    select
        pr.patient_id,
        count(*) filter (where pr.out_of_range) as n_abnormal_labs
    from {{ ref('patient_results') }} pr
    group by pr.patient_id
),

base as (
    select
        coalesce(c.patient_id, l.patient_id) as patient_id,
        coalesce(c.n_conditions, 0)         as n_conditions,
        coalesce(l.n_abnormal_labs, 0)      as n_abnormal_labs
    from conds c
    full outer join labs l
      on c.patient_id = l.patient_id
)

select
    patient_id,
    n_conditions,
    n_abnormal_labs,
    case
        when n_abnormal_labs >= 3
          or n_conditions    >= 5
        then true
        else false
    end as high_risk_flag
from base
