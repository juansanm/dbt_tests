select
    id            as order_id,
    patient_id,
    condition_id,
    order_date    as updated_at,
    order_date
from "takehome"."raw"."orders"