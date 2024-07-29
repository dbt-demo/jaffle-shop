{{ config(materialized='incremental', unique_key='customer_id') }}

with source as (

    {#-
    Normally we would select from the table here, but we are using seeds to load
    our data in this project
    #}
    select * from {{ ref('raw_customers') }}

),

renamed as (

    select
        id as customer_id,
        first_name,
        last_name

    from source

)

select * from renamed

{% if is_incremental() %}
  where customer_id > (select coalesce(max(customer_id), 0) from {{ this }})
{% endif %}
