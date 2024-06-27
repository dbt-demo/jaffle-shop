WITH orders AS (
    SELECT * FROM {{ ref('orders') }}
),
customers AS (
    SELECT * FROM {{ ref('customers') }}
)
SELECT
    o.order_id,
    o.customer_id,
    o.order_date,
    o.status,
    c.first_name,
    c.last_name,
    c.customer_lifetime_value
FROM orders o
JOIN customers c ON o.customer_id = c.customer_id
