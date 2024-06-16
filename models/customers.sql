
SELECT
    customers.customer_id,
    customers.first_name,
    customers.last_name,
    customer_orders.first_order,
    customer_orders.most_recent_order,
    customer_orders.number_of_orders,
    customer_payments.total_amount as customer_lifetime_value
FROM
    (
        SELECT * FROM {{ ref('stg_customers') }}
    ) AS customers
LEFT JOIN
    (
        SELECT
            customer_id,
            min(order_date) as first_order,
            max(order_date) as most_recent_order,
            count(order_id) as number_of_orders
        FROM
            (
                SELECT * FROM {{ ref('stg_orders') }}
            ) AS orders
        GROUP BY customer_id
    ) AS customer_orders
ON customers.customer_id = customer_orders.customer_id
LEFT JOIN
    (
        SELECT
            orders.customer_id,
            sum(amount) as total_amount
        FROM
            (
                SELECT * FROM {{ ref('stg_payments') }}
            ) AS payments
        LEFT JOIN
            (
                SELECT * FROM {{ ref('stg_orders') }}
            ) AS orders
        ON payments.order_id = orders.order_id
        GROUP BY orders.customer_id
    ) AS customer_payments
ON customers.customer_id = customer_payments.customer_id;

