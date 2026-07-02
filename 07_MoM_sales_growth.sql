with
monthly_sales as(
	SELECT
	    DATE_TRUNC('month', o.order_purchase_timestamp) AS order_month,
	    ROUND(SUM(oi.price), 2) AS total_revenue
	FROM orders o
	JOIN order_items oi ON o.order_id = oi.order_id
	WHERE o.order_status = 'delivered'
	GROUP BY order_month
),

last_month as(
	select 
		order_month,
		LAG(total_revenue) over (order by order_month) as last_month_revenue
	from monthly_sales
)

select
	ms.order_month,
	round(((total_revenue-last_month_revenue)/last_month_revenue)*100,2) as MoM
from monthly_sales ms
join last_month lm on ms.order_month = lm.order_month
ORDER BY order_month