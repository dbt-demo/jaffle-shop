select
      count(*) as failures,
      count(*) != 0 as should_warn,
      count(*) != 0 as should_error
    from (
      
    
    

with all_values as (

    select
        gift_card_amount as value_field,
        count(*) as n_records

    from "jaffle_shop"."main"."orders"
    group by gift_card_amount

)

select *
from all_values
where value_field not in (
    'gift_card'
)



      
    ) dbt_internal_test