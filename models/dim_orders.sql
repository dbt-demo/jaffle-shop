WITH source AS (
    SELECT
        order_id,
        customer_id,
        order_date,
        status,
        total_amount,
        created_at,
        updated_at
    FROM {{ ref('stg_orders') }}
),
changes AS (
    SELECT
        order_id,
        customer_id,
        order_date,
        status,
        total_amount,
        created_at,
        updated_at,
        ROW_NUMBER() OVER (PARTITION BY order_id ORDER BY updated_at DESC) AS row_num
    FROM source
)
SELECT
    order_id,
    customer_id,
    order_date,
    status,
    total_amount,
    created_at,
    updated_at,
    CASE
        WHEN row_num = 1 THEN 'Y'
        ELSE 'N'
    END AS current_record
FROM changes
