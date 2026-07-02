with
total as(
	select
		oi.seller_id,
		sum(oi.price) as sales,
		count(distinct oi.order_id) as n_order
	from order_items oi
	join orders o on oi.order_id = o.order_id
	where order_status = 'delivered'
	group by oi.seller_id
),
ranking as(
select 
	*,
	dense_rank() over(order by sales desc) as rank
from total
)

select *
from ranking
where rank <= 10