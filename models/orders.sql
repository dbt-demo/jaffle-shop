{% set payment_methods = ['credit_card', 'coupon', 'bank_transfer', 'gift_card'] %}

{{ config(materialized='incremental', unique_key='order_id') }}

with orders as (

    select * from {{ ref('stg_orders') }}

),

payments as (

    select * from {{ ref('stg_payments') }}

),

order_payments as (

    select
        order_id,

        {% for payment_method in payment_methods -%}
        sum(case when payment_method = '{{ payment_method }}' then amount else 0 end) as {{ payment_method }}_amount,
        {% endfor -%}

        sum(amount) as total_amount

    from payments

    group by order_id

),

final as (

    select
        orders.order_id,
        orders.customer_id,
        orders.order_date,
        orders.status,

        {% for payment_method in payment_methods -%}

        order_payments.{{ payment_method }}_amount,

        {% endfor -%}

        order_payments.total_amount as amount

    from orders

    left join order_payments
        on orders.order_id = order_payments.order_id

),

select * from final

{% if is_incremental() %}
  where order_id > (select coalesce(max(order_id), 0) from {{ this }})
{% endif %}
