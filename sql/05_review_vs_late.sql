with
avg_score as (
	select 
		pct.product_category_name_english as category,
		round(avg(review_score),2) as average_score
	from order_reviews ordr
	join orders o on ordr.order_id = o.order_id
	join order_items oi on ordr.order_id = oi.order_id
	join products p on oi.product_id = p.product_id
	join product_category_translation pct on p.product_category_name = pct.product_category_name
	WHERE o.order_status = 'delivered'
	group by 1	
),
late_order as(
	select
		pct.product_category_name_english as category,
		count(o.order_id) as total_orders,
		count(o.order_id) filter (where order_delivered_customer_date > order_estimated_delivery_date) as n_late
	from orders o
	join order_items oi on o.order_id = oi.order_id
	join products p on oi.product_id = p.product_id
	join product_category_translation pct on p.product_category_name = pct.product_category_name
	WHERE o.order_status = 'delivered'
	group by 1
)

select
	avgs.category,
	avgs.average_score,
	round(lo.n_late/lo.total_orders :: decimal,2) as ratio
from avg_score avgs
join late_order lo on avgs.category = lo.category
order by avgs.average_score
limit 10
