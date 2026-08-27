with late_order as(
select
	count(order_id) as total_orders,
	count(order_id) filter (where order_delivered_customer_date > order_estimated_delivery_date) as n_late
from orders
where order_status = 'delivered'
)

select *, round(n_late/total_orders :: decimal,2) as ratio
from late_order
