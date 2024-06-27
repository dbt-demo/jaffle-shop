
    
    

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


