{{ config(materialized='incremental', unique_key='customer_id') }}

select
    id as customer_id,
    first_name,
    last_name
from {{ ref('raw_customers') }}
{% if is_incremental() %}
  where customer_id > (select coalesce(max(customer_id), 0) from {{ this }})
{% endif %}
