use samplrsuperstore
select * from sample_superstore

--31. most frequently used shipping mode
select ship_mode,count(*)as total_usage
from sample_superstore
group by Ship_Mode
order by total_usage desc
offset 0 rows fetch next 1 row only


--32. highly profitable ship mode

select ship_mode,sum(profit)total_profit
from sample_superstore
group by Ship_Mode
order by total_profit desc
offset 0 rows fetch next 1 row only

--33. does faster shipping incerase profit
select datediff(day,order_date,ship_date) as days_to_ship,
round(avg(profit),2)average_profit,
count(*)order_count
from sample_superstore
group by datediff(day,order_date,ship_date)  
order by days_to_ship asc

--34. shipping mode with highest discount
select Ship_Mode,total_discount from(
select ship_mode,sum(Discount)total_discount,
rank()over(order by sum(discount)desc)as rnk
from sample_superstore
group by ship_mode
)x
where rnk=1

--35. average shipping delay respect to ship_mode

select Ship_Mode,
avg(cast(DATEDIFF(day,order_date,ship_date)as decimal(10,2)))avg_shipping_delay
from sample_superstore
group by Ship_Mode
order by avg_shipping_delay 







