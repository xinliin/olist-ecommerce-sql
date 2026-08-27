select
	pct.product_category_name_english,
	sum(price) as total_amount
from order_items oi
join orders o on oi.order_id = o.order_id
join products p on oi.product_id = p.product_id
join product_category_translation pct on p.product_category_name = pct.product_category_name

where o.order_status = 'delivered'
group by pct.product_category_name_english
order by total_amount DESC
limit 10
