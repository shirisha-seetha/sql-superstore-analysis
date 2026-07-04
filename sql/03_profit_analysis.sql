use samplrsuperstore
select * from sample_superstore;

--13. category with highest profit
with high_categoty as(
select Product_Category,sum(profit)Total_profit
from sample_superstore
group by Product_Category
)
select * from high_categoty
where Total_profit=(select max(total_profit)from high_categoty)
--=======================OR=========================
select top 1 product_category,sum(profit)total_profit
from sample_superstore
group by Product_Category
order by Total_profit desc

--14. products causing loss
select Product_Name,count(*)total_products,
round(sum(profit-shipping_cost),2) as net_loss
from sample_superstore
group by Product_Name
having sum(profit-shipping_cost)<0
order by net_loss

--15. states with negative profit
select state_or_province as state,sum(profit)negative_profit
from sample_superstore
where profit<0
group by State_or_Province
order by negative_profit

--16. cities with highest profit
select city,max_profit from(
select  city,round(sum(profit),3)max_profit,
rank()over(order by round(sum(profit),3)desc)rnk
from sample_superstore
group by city
)x
where rnk=1

--17. city with high product margin
select top 1 city,round((sum(profit)*100/sum(sales)),2)product_margin
from sample_superstore
group by city
order by product_margin desc

--18. profit margin for each category
select product_category,round((sum(profit)*100/sum(sales)),2)product_margin
from sample_superstore
group by Product_Category
order by product_margin desc

