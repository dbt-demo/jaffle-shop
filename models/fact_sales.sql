WITH orders AS (
    SELECT
        o.order_id,
        o.customer_id,
        o.order_date,
        o.status,
        o.total_amount,
        c.first_name,
        c.last_name,
        c.email,
        c.address,
        c.city,
        c.state,
        c.zip,
        p.payment_date,
        p.amount AS payment_amount,
        p.payment_method
    FROM {{ ref('dim_orders') }} o
    LEFT JOIN {{ ref('dim_customers') }} c ON o.customer_id = c.customer_id
    LEFT JOIN {{ ref('dim_payments') }} p ON o.order_id = p.order_id
)
SELECT
    order_id,
    customer_id,
    order_date,
    status,
    total_amount,
    first_name,
    last_name,
    email,
    address,
    city,
    state,
    zip,
    payment_date,
    payment_amount,
    payment_method
FROM orders
