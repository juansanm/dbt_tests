select
    id                    as visit_id,
    visit_date            as updated_at,
    patient_condition_id,
    visit_date
from "takehome"."raw"."visits"