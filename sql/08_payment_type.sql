select
	payment_type,
	count(payment_type) as count_type,
	sum(payment_value) as total_value,
	round(avg(payment_installments),2) as average_installment
from order_payments op
join orders o on op.order_id = o.order_id
where o.order_status = 'delivered'
group by payment_type
order by 2 desc
