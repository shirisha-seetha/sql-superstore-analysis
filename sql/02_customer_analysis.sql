use samplrsuperstore
select * from sample_superstore

--7. Top 10 customers by sales
select customer_name,total_sales from(
select  customer_name ,sum(sales)total_sales,
rank()over(order by sum(sales) desc)rnk
from sample_superstore
group by Customer_Name
)x
where rnk between 1 and 10
--===============OR=====================
select top 10 customer_name ,sum(sales)total_sales
from sample_superstore
group by Customer_Name
order by total_sales desc

--8. customers with highest profit
select customer_name,total_profit from(
select  customer_name,sum(profit)total_profit,
DENSE_RANK()over(order by sum(profit)desc)rnk
from sample_superstore
group by Customer_Name
)x
where rnk=1

--9. customer with highest discounts
select  customer_name,sum(discount)Total_Discount
from sample_superstore
group by Customer_Name
order by Total_Discount desc
offset 0 rows fetch next 1 row only

--10. highest customer contribution to the revenue
select top 1 customer_segment,
round(sum(sales),2)Revenue
from sample_superstore
group by Customer_Segment
order by revenue desc

--11. 10 highest orders placed by the customers
select customer_name,total_orders,rnk from(
select  customer_name,count( distinct order_id)total_orders,
row_number()over(order by count(order_id) desc)rnk
from sample_superstore
group by Customer_Name
)x
where rnk>=1 and rnk<=10
order by total_orders desc

--12. repeat buyers and one time buyers%
select
	case
	when order_count = 1 then 'one_time_buyer' else 'repeat_buyer' 
	end as customer_type,
	count(*)total_customers,
	round(count(*) * 100/sum(count(*))over(),2) pct_of_customers
from
(
	select customer_name,count(distinct order_id) as order_count
	from sample_superstore
	group by customer_name
)x
group by case when order_count=1 then 'one_time_buyer' else 'repeat_buyer'
end



