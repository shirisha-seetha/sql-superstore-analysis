
use samplrsuperstore
--19. region with highest sales
select region,total_sales from(
select region,sum(sales)total_sales,
dense_rank()over( order by sum(sales))rnk
from sample_superstore
group by region
)x
where rnk=1


--20. region with highest profit
with region_profit as(
select region,sum(profit)as total_profit
from sample_superstore
group by region
)
select * from region_profit 
where total_profit=(select max(total_profit) from region_profit)

--21. state with more orders
select state,Total_orders from(
select state_or_province state,count(distinct order_id)Total_orders,
rank()over( order by count( distinct order_id) desc)rnk 
from sample_superstore
group by State_or_Province
)x
where rnk=1

--22. city with highest sales
select city,sum(sales)total_sales
from sample_superstore
group by city
order by total_sales desc
offset 0 rows fetch next 1 row only

--23. region company focus on for growth
with sales as(
select region,sum(sales)total_sales
from sample_superstore
group by region
),
profit as(
select region,
sum(profit)total_profit
from sample_superstore
group by region

)
select s.region,s.total_sales,p.total_profit from profit p
join sales s
on p.region=s.region
order by total_sales,total_profit
offset 0 rows fetch next 1 row only


