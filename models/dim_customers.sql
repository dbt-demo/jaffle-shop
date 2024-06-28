WITH source AS (
    SELECT
        customer_id,
        first_name,
        last_name,
        email,
        address,
        city,
        state,
        zip,
        created_at,
        updated_at
    FROM {{ ref('stg_customers') }}
),
changes AS (
    SELECT
        customer_id,
        first_name,
        last_name,
        email,
        address,
        city,
        state,
        zip,
        created_at,
        updated_at,
        ROW_NUMBER() OVER (PARTITION BY customer_id ORDER BY updated_at DESC) AS row_num
    FROM source
)
SELECT
    customer_id,
    first_name,
    last_name,
    email,
    address,
    city,
    state,
    zip,
    created_at,
    updated_at,
    CASE
        WHEN row_num = 1 THEN 'Y'
        ELSE 'N'
    END AS current_record
FROM changes
