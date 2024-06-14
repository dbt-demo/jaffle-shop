select
    c.customer_id,
    c.first_name,
    c.last_name,
    co.first_order,
    co.most_recent_order,
    co.number_of_orders,
    cp.total_amount as customer_lifetime_value
from {{ ref('stg_customers') }} c
left join (
    select
        customer_id,
        min(order_date) as first_order,
        max(order_date) as most_recent_order,
        count(order_id) as number_of_orders
    from {{ ref('stg_orders') }}
    group by customer_id
) co on c.customer_id = co.customer_id
left join (
    select
        o.customer_id,
        sum(p.amount) as total_amount
    from {{ ref('stg_payments') }} p
    left join {{ ref('stg_orders') }} o on p.order_id = o.order_id
    group by o.customer_id
) cp on c.customer_id = cp.customer_id
