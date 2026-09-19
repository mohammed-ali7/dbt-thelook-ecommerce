with orders as (
    select * from {{ ref('stg_orders') }}
),

order_items as (
    select * from {{ ref('stg_order_items') }}
),

order_items_summary as (
    select
        order_id,
        sum(sale_price) as gross_revenue,
        count(order_item_id) as actual_items_count
    from order_items
    group by 1
)

select
    o.order_id,
    o.user_id,
    o.order_status,
    o.order_created_at,
    o.shipped_at,
    o.delivered_at,
    o.returned_at,
    coalesce(s.gross_revenue, 0) as gross_revenue,
    coalesce(s.actual_items_count, 0) as total_items
from orders as o
left join order_items_summary as s
    on o.order_id = s.order_id
