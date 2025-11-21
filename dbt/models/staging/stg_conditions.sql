select
    id   as condition_id,
    name as condition_name
from {{ source('raw', 'conditions') }}
