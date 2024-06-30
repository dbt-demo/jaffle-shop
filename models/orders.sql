{% set payment_methods = ['credit_card', 'coupon', 'bank_transfer', 'gift_card'] %}

with orders as (
    select *
    from {{ ref('stg_orders') }}
),
order_payments as (
    select
        order_id,
        count(*) as number_of_payments
    from {{ ref('stg_payments') }}
    group by order_id
),
final as (
    select
        orders.order_id,
        orders.customer_id,
        orders.order_date,
        orders.status,
        order_payments.number_of_payments
    from orders
    left join order_payments
    on orders.order_id = order_payments.order_id
)
select * from final
