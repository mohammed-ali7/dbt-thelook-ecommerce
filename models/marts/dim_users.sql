with users as (
    select * from {{ ref('stg_users') }}
),

orders as (
    select * from {{ ref('stg_orders') }}
),

user_orders_summary as (
    select
        user_id,
        min(order_created_at) as first_order_at,
        max(order_created_at) as most_recent_order_at,
        count(order_id) as total_orders
    from orders
    group by 1
)

select
    u.user_id,
    u.first_name,
    u.last_name,
    u.email,
    u.age,
    u.gender,
    u.country,
    u.account_created_at,
    coalesce(s.total_orders, 0) as total_orders,
    s.first_order_at,
    s.most_recent_order_at
from users as u
left join user_orders_summary as s 
    on u.user_id = s.user_id
