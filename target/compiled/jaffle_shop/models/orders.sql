

select
    o.order_id,
    o.customer_id,
    o.order_date,
    o.status,
    sum(case when p.payment_method = 'credit_card' then p.amount else 0 end) as credit_card_amount,
    sum(case when p.payment_method = 'coupon' then p.amount else 0 end) as coupon_amount,
    sum(case when p.payment_method = 'bank_transfer' then p.amount else 0 end) as bank_transfer_amount,
    sum(case when p.payment_method = 'gift_card' then p.amount else 0 end) as gift_card_amount,
    sum(p.amount) as total_amount
from
    "memory"."main"."stg_orders" o
left join
    "memory"."main"."stg_payments" p
on
    o.order_id = p.order_id
group by
    o.order_id,
    o.customer_id,
    o.order_date,
    o.status