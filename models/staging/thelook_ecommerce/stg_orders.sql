with raw_orders as (
    select * from {{ source('thelook_ecommerce', 'orders') }}
)

select
    order_id,
    user_id,
    status as order_status,
    created_at as order_created_at,
    returned_at,
    shipped_at,
    delivered_at,
    num_of_item as total_items_in_order
from raw_orders
