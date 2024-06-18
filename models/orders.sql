{% set payment_methods = ['credit_card', 'coupon', 'bank_transfer', 'gift_card'] %}
select
    orders.order_id,
    orders.customer_id,
    orders.order_date,
    orders.status,
    {% for payment_method in payment_methods -%}
    sum(case when payments.payment_method = '{{ payment_method }}' then payments.amount else 0 end) as {{ payment_method }}_amount,
    {% endfor -%}
    sum(payments.amount) as total_amount
from {{ ref('stg_orders') }} as orders
left join {{ ref('stg_payments') }} as payments
    on orders.order_id = payments.order_id
group by orders.order_id, orders.customer_id, orders.order_date, orders.status
