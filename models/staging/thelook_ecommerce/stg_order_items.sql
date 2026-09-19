with raw_order_items as (
    select * from {{ source('thelook_ecommerce', 'order_items') }}
)

select
    id as order_item_id,
    order_id,
    user_id,
    product_id,
    status as item_status,
    created_at as item_created_at,
    shipped_at as item_shipped_at,
    delivered_at as item_delivered_at,
    returned_at as item_returned_at,
    sale_price
from raw_order_items