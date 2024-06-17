WITH customers_data AS (
    SELECT * FROM {{ ref('customers') }}
)
SELECT
    *
FROM
    customers_data
WHERE
    last_name IS NULL OR last_name = ''
