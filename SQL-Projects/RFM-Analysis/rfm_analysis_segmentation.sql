SELECT * FROM RFM_Analysis.dbo.customer_shopping_data;

select customer_id, gender, age, quantity, price, payment_method, shopping_mall,invoice_date
from RFM_Analysis.dbo.customer_shopping_data;


select count(*) -- check how many records= 99457
from RFM_Analysis.dbo.customer_shopping_data;

select count(distinct(customer_id)) -- customer id has to be unique = 99457, check if it's correct
from RFM_Analysis.dbo.customer_shopping_data;

--check for null values in the column (no null values found . Great!)
select count (case when customer_id  is null then 1  end) as customer_id,
	   count (case when gender  IS NULL then 1  end) as gender,
	   count (case when age  IS NULL then 1  end) as age,
	   count (case when category  IS NULL then 1  end) as category,
	   count (case when quantity  IS NULL then 1  end) as quantity,
	   count (case when price  IS NULL then 1  end) as price,
	   count (case when payment_method  IS NULL then 1  end) as payment_method,
	   count (case when invoice_date  IS NULL then 1  end) as invoice_date,
	   count (case when shopping_mall  IS NULL then 1  end) as shopping_mall
from RFM_Analysis.dbo.customer_shopping_data;

--getting some knowlegde from the data 

-- 8 categories
select distinct category from RFM_Analysis.dbo.customer_shopping_data;

-- three payment method : debit card, credit card, cash
select distinct payment_method from RFM_Analysis.dbo.customer_shopping_data;

-- ten shopping malls
select distinct shopping_mall from RFM_Analysis.dbo.customer_shopping_data;

-- two male and female
select distinct gender from RFM_Analysis.dbo.customer_shopping_data;

--ANALYSIS 

-- total sales with respect to gender -- females customers are more than males customer
select gender, sum(price) as sales_distribution
from RFM_Analysis.dbo.customer_shopping_data
group by gender ;

-- total sales with respect to gender -- females customers orders more than males customer
select gender, sum(quantity) as sales_distribution
from RFM_Analysis.dbo.customer_shopping_data
group by gender ;

--ordered list of all categories where female purchases are higher
select category, count(quantity) as quantities, sum (price) as sales 
from RFM_Analysis.dbo.customer_shopping_data
where gender = 'Female'
group by category 
order by count(quantity) desc

--ordered list of all categories where female purchases are higher
select category, count(quantity) as quantities, sum (price) as sales 
from RFM_Analysis.dbo.customer_shopping_data
where gender = 'male'
group by category 
order by count(quantity) desc

-- cusotmers and sales of malls 
select shopping_mall, count(customer_id) as mall_customers, sum (price) as mall_sales 
from RFM_Analysis.dbo.customer_shopping_data
group by shopping_mall
order by mall_sales desc

-- customers dictinction on payment  method
select payment_method, count(customer_id) as types_of_customers
from RFM_Analysis.dbo.customer_shopping_data
group by payment_method
order by payment_method desc


-- top spending customer category by year
select distinct(year(invoice_date)) as selling_years, gender, sum(quantity) sales, sum(price) revenue
from  RFM_Analysis.dbo.customer_shopping_data
group by year(invoice_date) , gender
order by revenue desc;


-- minimum and maximum age of customers
select gender, min(age) as min_age, MAX(age) as max_age
from  RFM_Analysis.dbo.customer_shopping_data
group by gender;

--how many years data = 2021,2022,2023
select YEAR(invoice_date) AS years, count (invoice_date)
from  RFM_Analysis.dbo.customer_shopping_data
group by YEAR(invoice_date);


--make new columns of last_order_date (recency),total_orders(frequency) and spending(monetary)
select
  customer_id, gender, age, payment_method, shopping_mall, invoice_date,
  datediff(DAY,invoice_date,'2023-12-02') as last_date_order, --date format :yyyy-mm-dd
  sum(quantity) as total_orders,
  sum(price) as spending
from RFM_Analysis.dbo.customer_shopping_data
group by customer_id, gender, age, payment_method, shopping_mall, invoice_date
order by last_date_order asc

with rfm as(
		select
  customer_id, gender, age, payment_method, shopping_mall, invoice_date,
   datediff(DAY,invoice_date,'2023-12-03') as last_date_order,
  sum(quantity) as total_orders,
  sum(price) as spending
from RFM_Analysis.dbo.customer_shopping_data
 group by customer_id, gender, age, payment_method, shopping_mall, invoice_date
 order by last_date_order desc OFFSET 0 ROWS
 ),
-- ranking them form 3-1
 rfm_calc as(
 select *,
  ntile(3) over (order by last_date_order) rfm_recency,
  ntile(3) over (order by total_orders) rfm_frequency,
  ntile(3) over (order by spending) rfm_monetary
 from rfm
 order by rfm_monetary desc OFFSET 0 ROWS
), 
 last_rfm as(
-- calculate rfm score
select *, rfm_recency + rfm_frequency + rfm_monetary as rfm_score,
concat(rfm_recency, rfm_frequency, rfm_monetary) as rfm
from rfm_calc
)
-- making group of customers
select *, case
 when rfm in (311, 312, 311) then 'new customers'
 when rfm in (111, 121, 131, 122, 133, 113, 112, 132) then 'lost customers'
 when rfm in (212, 313, 123, 221, 211, 232) then 'regular customers'
 when rfm in (223, 222, 213, 322, 231, 321, 331) then 'loyal customers'
 when rfm in (333, 332, 323, 233) then 'champion customers'
end rfm_segment
 from last_rfm;
