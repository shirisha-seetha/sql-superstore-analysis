use samplrsuperstore

--41. average order value for each month
select month, avg(order_count)avg_orders from(
select  count(distinct order_id)order_count,month
from sample_superstore
group by month
)x
group by month

--42. region with every year highest sales
select region, year,total_sales
from(select region,year,sum(sales)total_sales,
DENSE_RANK()over( partition by year order by sum(sales) desc)rnk
from sample_superstore
group by region,year
)t
where rnk=1
order by total_sales desc

--43. most orders placed by the customer in a single year
select customer_name,year,total_orders from(
select customer_name,year,count( distinct Order_ID)total_orders,
DENSE_RANK()over(partition by year order by count( distinct order_id ) desc)rnk
from sample_superstore
group by year,Customer_Name
)t
where rnk=1

--44. longest gap between two orders for same customers
with cte as(
select customer_name ,
	order_date,
	year,
	datediff(day,
	lag(Order_Date)over (
	partition by customer_name ,year
	order by order_date
	),
	Order_Date
	) as gap_days
from sample_superstore
)
select customer_name,max(gap_days)as longest_gap,year
from cte
group by customer_name,year
order by year,longest_gap desc

--45. first order date and last order date of customers
select customer_name,FIRST_VALUE(order_date)
over(partition by customer_name order by order_date)first_order_date,
LAST_VALUE(order_date)over(partition by customer_name 
order by order_date rows  between unbounded preceding and unbounded following)last_order_date
from sample_superstore
order by first_order_date

--46. Q1 SALES AND Q4 SALES OF EVERY YEAR
with cte as(
select year,(datepart(QUARTER,order_date))quarter,
sum(sales)quarter_sales
from sample_superstore
group by year,datepart(QUARTER,order_date)
)
select distinct year,FIRST_VALUE(quarter_sales)over(partition by year 
order by  quarter)as Q1_sales,
LAST_VALUE(quarter_sales)over(partition by year order by quarter
 rows between unbounded preceding and unbounded following)	Q4_sales
from cte












