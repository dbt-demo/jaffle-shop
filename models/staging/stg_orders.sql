{{ config(materialized='incremental', unique_key='order_id') }}

with source as (

    {#-
    Normally we would select from the table here, but we are using seeds to load
    our data in this project
    #}
    select * from {{ ref('raw_orders') }}

),

renamed as (

    select
        id as order_id,
        user_id as customer_id,
        order_date,
        status

    from source

)

select * from renamed

{% if is_incremental() %}
  where order_id > (select coalesce(max(order_id), 0) from {{ this }})
{% endif %}
