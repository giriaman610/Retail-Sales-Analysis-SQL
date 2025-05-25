select * from retail_sales
limit 10

-- checking NULL values 
select * from retail_sales
where age  is null or quantiy  is null or
price_per_unit  is null or  cogs  
is null or total_sale  is null
-- deleting NULL values
delete from retail_sales
where age  is null or quantiy  is null or
price_per_unit  is null or  cogs  
is null or total_sale  is null

select count(*) from retail_sales

---How many unique customers ?
select count(distinct customer_id) from retail_sales

-- write a query to retrieve all columns for sales that made on 2022-11-05
select * from retail_sales
where sale_date ='2022-11-05'

-- write a query to find the average age of customers who have purchased items from the beauty category?

select cast(avg(age) as decimal(10,0)) as avg_age_customers from retail_sales
where category='Beauty'

--write a query to find the  customers who have purchased items from the clothing category
--and quantity sold is more --than 5?
select * from retail_sales
 where category='Clothing' and quantiy>=4 and extract(month from sale_date)='11'
-- write a query to calculate total sales for each category
select category,sum(total_sale) as Total_sales,count(distinct transactions_id) as total_orders
from retail_sales
group by category
order by Total_Sales desc
-- write all transactions where total sale is greater than 1000?
select * from retail_sales
where total_sale > 1000
-- write a sql query to find total number transactions made by each gender in eachh category?
select category,gender,count(distinct transactions_id)as number_transactions from retail_sales
group by category,gender
order by 1
-- write a query to calculate avg sale for each month, find out best selling month in each year?
with output_as as(
  select  extract(year from sale_date) as year_here,extract(month from sale_date) as month_here, 
  avg(total_sale) as avg_sale,
  Row_number() over(partition by  extract(year from sale_date)  order by avg(total_sale)desc) as row_num
  from retail_sales
  group by 1,2
  order by 1,avg_sale desc
)
select year_here,month_here,avg_sale from output_as
where row_num<=1

-- write a query to find top 5 customers based on the highest sale
select * from retail_sales
select customer_id,sum(total_sale) as Total_sale 
from retail_sales
group by 1
order by 2 desc
limit 5
--write a query to find out the number of unique  customers of have purchased items from each category?

select  category,count(distinct customer_id) as unique_cutomers
from retail_Sales
group by 1

-- write a query to create each shift and number of orders(ex- morning<=12,afternoon between 12&17,evening>17)
with hourly_sales as(
select 
case
when extract(hour from sale_time)<=12 then 'Morning'
when extract(hour from sale_time) between 12 and 17 then 'Afternoon'
else 'Evening'
end as shift
from retail_sales
)
select shift,count (*) as number_of_orders 
from hourly_sales
group by shift


