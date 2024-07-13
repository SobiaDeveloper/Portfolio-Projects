CREATE TABLE Supermarket.dbo.Sales(
  Invoice_ID varchar(255),
  Branch varchar(50),
  City varchar(255),
  Customer_Type varchar(255),
  Gender varchar(255),
  Product_Line varchar(255),
  Unit_Price float,
  Quantity INT,
  Tax_Five_Percent float,
  Total float,
  Invoice_Date date,
  Invoice_Time timestamp,
  Payment_Method varchar(255),
  COGS float,
  Gross_margin_Percentage float,
  Gross_Income float,
  Rating float
);


select * from   Supermarket.dbo.supermarket_sales as ss

-- caluclate month name for each date
SELECT Payment_Date,
datename(month,Payment_Date) AS month_name
FROM Supermarket.dbo.supermarket_sales;

ALTER TABLE Supermarket.dbo.supermarket_sales 
ADD  month_name VARCHAR(10);


UPDATE Supermarket.dbo.supermarket_sales
SET month_name = datename(month,Payment_Date);

select * from   Supermarket.dbo.supermarket_sales as ss

SELECT  CAST(Payment_time AS time) 
from   Supermarket.dbo.supermarket_sales 

ALTER TABLE Supermarket.dbo.supermarket_sales 
ADD  Payment_in_time VARCHAR(10);

UPDATE Supermarket.dbo.supermarket_sales
SET Payment_in_time = CAST(Payment_time AS time) ;

select * from   Supermarket.dbo.supermarket_sales as ss

-- drop previous column
ALTER TABLE Supermarket.dbo.supermarket_sales
DROP COLUMN Payment_time;
select * from   Supermarket.dbo.supermarket_sales as ss

-- check for duplicates

select distinct count (Invoice_ID) from Supermarket.dbo.supermarket_sales

-- no null values found
Select Count (CASE WHEN Invoice_ID is null then 1 end) as Invoice_ID ,
       COUNT(CASE WHEN Branch is null then 1 end) as Branch ,
       COUNT(CASE WHEN City is null then 1 end) as City ,
	   Count (CASE WHEN Customer_type is null then 1 end) as Customer_type ,
       COUNT(CASE WHEN Gender is null then 1 end) as Gender ,
       COUNT(CASE WHEN Product_line is null then 1 end) as Product_line ,
	   Count (CASE WHEN Unit_price is null then 1 end) as Unit_price ,
       COUNT(CASE WHEN Quantity is null then 1 end) as Quantity ,
       COUNT(CASE WHEN Tax_5_Percent is null then 1 end) as Tax_5_Percent ,
	    COUNT(CASE WHEN Total is null then 1 end) as Total ,
       COUNT(CASE WHEN Payment_date is null then 1 end) as Payment_date, 
	   COUNT(CASE WHEN Payment_time is null then 1 end) as Payment_time, 
       COUNT(CASE WHEN Payment is null then 1 end) as Payment, 
       COUNT(CASE WHEN cogs is null then 1 end) as cogs, 
       COUNT(CASE WHEN Gross_margin_percentage is null then 1 end) as Gross_margin_percentage, 
       COUNT(CASE WHEN gross_income is null then 1 end) as gross_income, 
       COUNT(CASE WHEN Rating is null then 1 end) as Rating

from   Supermarket.dbo.supermarket_sales as ss;

-- GENERIC ANALYSIS
-- howmany branches data is available 
SELECT DISTINCT Branch 
FROM Supermarket.dbo.supermarket_sales;

-- how many cities data is available
SELECT DISTINCT City 
FROM Supermarket.dbo.supermarket_sales;

-- which branch is in which city (Yangon--A, Mandalay--B, Naypyitaw--C)
SELECT DISTINCT City , Branch
FROM Supermarket.dbo.supermarket_sales
group by City, Branch;


--PRODUCT ANALYSIS:
-- How many distinct product lines are there in the dataset?
select distinct Product_line from  Supermarket.dbo.supermarket_sales

-- List down all payment method
 select distinct Payment
 from  Supermarket.dbo.supermarket_sales


-- What is the most common payment method? ewallet=345
 select top 1 Payment, COUNT(Payment)
 from  Supermarket.dbo.supermarket_sales
 group by Payment
 order by COUNT(Payment) Desc 

-- which is the best product line  for sell? Fashion accessories = 178
 select top 1 Product_line, COUNT(Product_line)
 from  Supermarket.dbo.supermarket_sales
 group by Product_line
 order by COUNT(Product_line) Desc 



 --what is the total revenue by month
 select month_name, sum(Total) as total_revenue_per_month
  from  Supermarket.dbo.supermarket_sales
 group by month_name
 order by total_revenue_per_month desc

 --Which month recorded the highest Cost of Goods Sold (COGS)?
 SELECT month_name, SUM(cogs) AS total_cogs
FROM Supermarket.dbo.supermarket_sales
GROUP BY month_name
ORDER BY total_cogs DESC;

--Which product line generated the highest revenue? food and beverages= 56144.95
SELECT top 1 Product_line, SUM(total) AS total_revenue
FROM Supermarket.dbo.supermarket_sales
GROUP BY Product_line 
ORDER BY total_revenue DESC;

-- count of invoice and revenue generated from each branch (A-->340, B-->332, C-->328 but branch C has the highest revenue
select Sum(Total), count(Invoice_ID) , Branch
from  Supermarket.dbo.supermarket_sales
group by Branch
ORDER BY  Sum(Total) DESC;


-- count of Invoice_ID in every branch with respect to product line
select count(Invoice_ID) as total_Invoice_per_branch_productline, Branch , Product_line
from  Supermarket.dbo.supermarket_sales
group by Branch ,Product_line
order by count(Invoice_ID) desc;


--Which product line incurred the highest VAT? = Food and beverages
SELECT Top 1 Product_line, SUM(Tax_five_percent) as VAT 
FROM Supermarket.dbo.supermarket_sales 
GROUP BY Product_line 
ORDER BY VAT DESC ;

--Retrieve each product line and add a column product_category, indicating 'Good' or 'Bad,'based on whether its sales are above the average.
Alter table Supermarket.dbo.supermarket_sales 
ADD product_category VARCHAR(20);
 
Update Supermarket.dbo.supermarket_sales
set product_category = (
	case 
		when Total >= ( Select AVG(Total) from Supermarket.dbo.supermarket_sales)
	then 'Good'
	else 'Bad'
	end)
from Supermarket.dbo.supermarket_sales

select * from Supermarket.dbo.supermarket_sales


--What is the most common product line by gender?
SELECT Gender, product_line, COUNT(Gender) as total_count
FROM Supermarket.dbo.supermarket_sales 
GROUP BY Gender, product_line
ORDER BY total_count DESC

--What is the average rating of each product line?
SELECT product_line, ROUND(AVG(Rating),2) as average_rating
FROM Supermarket.dbo.supermarket_sales 
GROUP BY product_line 
ORDER BY average_rating DESC;


--SALES ANALYSIS
--which weekday has greater sales
SELECT Day_name, sum(Total) as week_days_sales
FROM Supermarket.dbo.supermarket_sales 
group by Day_name 
ORDER BY week_days_sales DESC;

--Identify the customer type that generates the highest revenue.
SELECT Top 1 Customer_type, SUM(Total) AS total_sales
FROM Supermarket.dbo.supermarket_sales 
GROUP BY customer_type 
ORDER BY total_sales DESC ;


--Which city has the largest tax percent/ VAT (Value Added Tax)?
SELECT top 1 City, SUM(Tax_five_percent) AS total_VAT
FROM Supermarket.dbo.supermarket_sales 
GROUP BY City ORDER BY total_VAT DESC ;

--Which customer type pays the most in VAT?
SELECT top 1 Customer_type, SUM(Tax_five_percent) AS total_VAT
FROM Supermarket.dbo.supermarket_sales 
GROUP BY customer_type 
ORDER BY total_VAT DESC ;

-- Avg sales/day= 323
 select AVG(Total) as per_day_sales 
 from  Supermarket.dbo.supermarket_sales

 --total customer type(member-->501, Normal-->499)
 select Customer_type, COUNT(Customer_type)
 from  Supermarket.dbo.supermarket_sales
 group by Customer_type

 -- how many payment types and counts(credit card--> 311, Cash-->344, ewallet-->345)
 select Payment, COUNT(Payment)
 from  Supermarket.dbo.supermarket_sales
 group by Payment

 --CUSTOMER ANALYSIS

 --How many unique customer types does the data have?
SELECT COUNT(DISTINCT customer_type) FROM Supermarket.dbo.supermarket_sales;

--How many unique payment methods does the data have?
SELECT COUNT(DISTINCT Payment) FROM Supermarket.dbo.supermarket_sales;

--Which is the most common customer type?
SELECT top 1 Customer_type, COUNT(Customer_type) AS common_customer
FROM Supermarket.dbo.supermarket_sales
GROUP BY Customer_type 
ORDER BY common_customer DESC;

--Which customer type buys the most?
SELECT top 1 Customer_type, SUM(Total) as total_sales
FROM Supermarket.dbo.supermarket_sales
GROUP BY Customer_type 
ORDER BY total_sales ;

SELECT top 1 Customer_type, COUNT(Invoice_ID) AS most_buyer
FROM Supermarket.dbo.supermarket_sales
GROUP BY Customer_type 
ORDER BY most_buyer DESC

--What is the gender of most of the customers?
SELECT top 1 Gender, COUNT(Invoice_ID) AS all_genders 
FROM Supermarket.dbo.supermarket_sales
GROUP BY Gender 
ORDER BY all_genders DESC;

--What is the gender distribution per branch?
SELECT Branch, Gender, COUNT(Gender) AS gender_distribution
FROM Supermarket.dbo.supermarket_sales 
GROUP BY Branch, Gender ORDER BY Branch;



-- which day of the week has the best avg ratings?
SELECT top 1  Day_name, AVG(Rating) AS average_rating
FROM Supermarket.dbo.supermarket_sales
GROUP BY Day_name
ORDER BY average_rating DESC 

-- Which day of the week has the best average ratings per branch?
SELECT  Branch, Day_name, AVG(Rating) AS average_rating
FROM Supermarket.dbo.supermarket_sales
GROUP BY Day_name, Branch 
ORDER BY average_rating DESC;
