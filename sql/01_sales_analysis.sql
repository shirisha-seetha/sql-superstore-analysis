create database samplrsuperstore

use samplrsuperstore
select * from sample_superstore

--1. category generates highest sales
select top 1 product_category,sum(sales)Total_sales
from sample_superstore
group by Product_Category
order by Total_sales desc


--2.products with highest sales and lowest sales
with product_sales as(
select Product_Name,sum(sales) total_sales
from sample_superstore
group by Product_Name
)
select * from product_sales
where total_sales=(select max(total_sales) from product_sales)
or total_sales=(select min(total_sales) from product_sales)

--3.highest contribution of sub category to revenue
select top 1 product_sub_category,sum(sales)Total_sales
from sample_superstore
group by product_sub_category
order by Total_sales desc

--4. running total of sales by month
select total_sales,month,year,
sum(total_sales) over(partition by year order by month)running_total
from(
select sum(sales)total_sales,month(order_date)month,year
from sample_superstore
group by month(order_date),year
)x
order by year,month

--5. monthly sales ternd
select year ,
month(order_date) month,
 sum(sales)total_sales
from sample_superstore
group by year,month(order_date)
order by year,month

--6. month over month growth %
--% growth reset to zero every year
select year,month,total_sales,
lag(total_sales)over(partition by year order by month)prev_monthly_sales,
round((total_sales-lag(total_sales)over(partition by year order by month))
/ lag(total_sales )over(partition by year order by month)*100,2)month_growth_pct
from (
select year ,month(order_date)month,sum(sales)total_sales
from sample_superstore
group by year,month(order_date)
)x
order by year,month




