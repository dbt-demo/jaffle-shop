{{ config(materialized='incremental', unique_key='order_id') }}

select
    id as order_id,
    user_id as customer_id,
    order_date,
    status
from {{ ref('raw_orders') }}

{% if is_incremental() %}
  where order_id > (select coalesce(max(order_id), 0) from {{ this }})
{% endif %}
