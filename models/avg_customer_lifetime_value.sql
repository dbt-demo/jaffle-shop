WITH customer_lifetime_values AS (
    SELECT
        customer_lifetime_value
    FROM {{ ref('customers') }}
)

SELECT
    AVG(customer_lifetime_value) AS avg_customer_lifetime_value
FROM customer_lifetime_values
