use samplrsuperstore
select * from sample_superstore
--36. high discounts increase profits
select  
case 
when discount<=0 then '0%'
when Discount<=0.10 then '1-10%'
when discount<=0.20 then '11-20%'
when discount<=0.30 then '21-30%'
else '30+%'
end discount_range,
avg(profit)avg_profit,
avg(sales) avg_sales,
count(*)number_of_orders
from sample_superstore
group by 
case 
when discount<=0 then '0%'
when Discount<=0.10 then '1-10%'
when discount<=0.20 then '11-20%'
when discount<=0.30 then '21-30%'
else '30+%'
end
order by discount_range desc



--37.states with highest average discounts
select state_or_province,average_discount from(
select state_or_province,avg(discount)average_discount,
rank()over(order by avg(discount)desc)rnk
from sample_superstore
group by State_or_Province
)x
where rnk=1

--38. category with highest discounts

select top 1 product_category,avg(discount)total_discount
from sample_superstore
group by Product_Category
order by total_discount desc

--39. subcategory with highest avg
select product_sub_category,avg(discount)avg_discount
from sample_superstore
group by Product_Sub_Category
order by avg_discount desc

--40. profit made by discount
select product_category,sum(profit)total_profit,
sum(sales+discount)as total_discount_given,
round(sum(profit)/nullif(sum(sales*discount),0),2)profit_per_discount
from sample_superstore
group by product_category
order by profit_per_discount desc

