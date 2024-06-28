WITH source AS (
    SELECT
        payment_id,
        order_id,
        payment_date,
        amount,
        payment_method,
        created_at,
        updated_at
    FROM {{ ref('stg_payments') }}
),
changes AS (
    SELECT
        payment_id,
        order_id,
        payment_date,
        amount,
        payment_method,
        created_at,
        updated_at,
        ROW_NUMBER() OVER (PARTITION BY payment_id ORDER BY updated_at DESC) AS row_num
    FROM source
)
SELECT
    payment_id,
    order_id,
    payment_date,
    amount,
    payment_method,
    created_at,
    updated_at,
    CASE
        WHEN row_num = 1 THEN 'Y'
        ELSE 'N'
    END AS current_record
FROM changes
