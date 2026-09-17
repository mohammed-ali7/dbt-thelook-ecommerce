with raw_users as (
    select * from {{ source('thelook_ecommerce', 'users') }}
)

select
    id as user_id,
    first_name,
    last_name,
    email,
    age,
    gender,
    country,
    created_at as account_created_at
from raw_users