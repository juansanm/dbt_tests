with patients as (
    select
        patient_id,
        date_of_birth,
        gender,
        race,
        ethnicity,
        smoker,
        drinks_per_week,
        date_activated,
        date_deactivated,
        date_of_death
    from "takehome"."dev_bronze"."patients"
)
select
    patient_id,
    gender,
    race,
    ethnicity,
    smoker,
    drinks_per_week,
    date_of_birth,
    date_activated,
    date_deactivated,
    date_of_death,
    date_diff('year', date_of_birth, current_date) as age,
    case
        when date_of_birth is null then 'unknown'
        when date_diff('year', date_of_birth, current_date) < 18 then '0-17'
        when date_diff('year', date_of_birth, current_date) between 18 and 34 then '18-34'
        when date_diff('year', date_of_birth, current_date) between 35 and 49 then '35-49'
        when date_diff('year', date_of_birth, current_date) between 50 and 64 then '50-64'
        else '65+'
    end as age_group
from patients