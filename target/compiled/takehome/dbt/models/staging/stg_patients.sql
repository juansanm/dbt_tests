select
    id as patient_id,
    coalesce(
        date_deactivated,
        date_activated,
        date_of_death,
        date_of_birth
    )                                    as updated_at,
    first_name,
    last_name,
    ssn,
    date_of_birth,
    gender,
    race,
    ethnicity,
    smoker,
    drinks_per_week,
    date_of_death,
    date_activated,
    date_deactivated
from "takehome"."raw"."patients"