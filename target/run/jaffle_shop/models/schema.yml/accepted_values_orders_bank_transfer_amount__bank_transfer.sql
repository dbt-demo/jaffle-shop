select
      count(*) as failures,
      count(*) != 0 as should_warn,
      count(*) != 0 as should_error
    from (
      
    
    

with all_values as (

    select
        bank_transfer_amount as value_field,
        count(*) as n_records

    from "jaffle_shop"."main"."orders"
    group by bank_transfer_amount

)

select *
from all_values
where value_field not in (
    'bank_transfer'
)



      
    ) dbt_internal_test