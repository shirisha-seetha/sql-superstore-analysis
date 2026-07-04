use samplrsuperstore
select * from sample_superstore

--26. highest sales product
select product_name,total_sales from(select product_name,sum(sales)total_sales,
DENSE_RANK()over(order by sum(sales)desc)rnk
from sample_superstore
group by Product_Name
)x
where rnk=1

--27. product with highest sales but low profit
with product_sales as(
select product_name,sum(sales)total_sales
from sample_superstore
group by product_name
),
product_profit as(
select product_name,sum(profit)total_profit
from sample_superstore
group by product_name
)
select s.product_name,
total_sales,
total_profit
from product_sales s
join product_profit p
on p.Product_Name=s.Product_Name
order by total_sales desc,total_profit asc
offset 0 rows fetch next 1 rows only

--28. subcategory with continuous losses or least profitable
select Product_Sub_Category from(
select product_sub_category,
year(order_date)year,sum(profit)yearly_profit
from sample_superstore
group by Product_Sub_Category,year(order_date)
)x
group by Product_Sub_Category
having sum(case when yearly_profit<0 then 1 else 0 end)=count(*)



--29. products with highest discounts
select Product_Name,total_discount from(
select product_name,round(sum(discount),2)total_discount
,dense_rank()over(order by sum(discount) desc) as rnk
from sample_superstore
group by product_name
)x
where rnk=1

--30. need more promotions for the products
select  *
from (select  product_name,
round(sum(sales),2)total_sales,
rank()over(order by sum(sales))rnk
from sample_superstore 
group by product_name 
) t
where rnk=1 

