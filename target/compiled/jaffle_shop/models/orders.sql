
select
    orders.order_id,
    orders.customer_id,
    orders.order_date,
    orders.status,
    sum(case when payments.payment_method = 'credit_card' then payments.amount else 0 end) as credit_card_amount,
    sum(case when payments.payment_method = 'coupon' then payments.amount else 0 end) as coupon_amount,
    sum(case when payments.payment_method = 'bank_transfer' then payments.amount else 0 end) as bank_transfer_amount,
    sum(case when payments.payment_method = 'gift_card' then payments.amount else 0 end) as gift_card_amount,
    sum(payments.amount) as total_amount
from "jaffle_shop"."main"."stg_orders" as orders
left join "jaffle_shop"."main"."stg_payments" as payments
    on orders.order_id = payments.order_id
group by orders.order_id, orders.customer_id, orders.order_date, orders.status