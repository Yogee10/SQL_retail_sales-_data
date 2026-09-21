--SQL Retail Sales Analysis

SELECT * FROM Retail_Sales;

SELECT COUNT (*) FROM Retail_Sales;

SELECT * 
FROM Retail_Sales 
WHERE 
	transactions_id IS NULL OR sale_date IS NULL OR sale_time IS NULL OR customer_id IS NULL 
	OR gender IS NULL OR age IS NULL OR category IS NULL OR price_per_unit IS NULL OR cogs IS NULL
	OR total_sale IS NULL;
DELETE FROM Retail_Sales
WHERE 
	transactions_id IS NULL OR sale_date IS NULL OR sale_time IS NULL OR customer_id IS NULL 
	OR gender IS NULL OR age IS NULL OR category IS NULL OR	price_per_unit IS NULL OR cogs IS NULL
	OR	total_sale IS NULL;
--Data exploration

--how many sales we have
SELECT COUNT (*) AS total_sale FROM Retail_Sales;

--how many unique customers we have
SELECT COUNT (DISTINCT customer_id) AS total_sale FROM Retail_Sales;

--how many unique category we have
SELECT DISTINCT category FROM Retail_Sales;

--DATA ANALYSIS
SELECT CONVERT(DATETIME, sale_date, 120) FROM Retail_Sales;
--Q1-SQL Query to retrieve all the columns forb sales made on '2022-11-05'
SELECT *
FROM Retail_Sales
WHERE sale_date = '2022-11-05';

--Q2-write a sql query to retrieve all transactions where the category is 'clothing' and the quantity sold is more thant 10 
--in the month of nov-2022

SELECT *
FROM Retail_Sales
WHERE category = 'Clothing'
  AND quantiy > 2
  AND sale_date >= '2022-11-01'
  AND sale_date < '2022-12-01';

--Q3-write sql query to calculate the total sale for each categories.
SELECT 
	category,
	SUM(total_sale) as Net_sale,
	COUNT (*) AS Total_order
	FROM Retail_Sales
	Group BY category;

--Q4-write a sql query to find the average age of customer who purchases item fromthe "Beauty" Category
SELECT 
	ROUND(AVG(age),2) as avg_age
	FROM Retail_Sales
	WHERE category ='Beauty'

--Q5-write sql query to find all transaction where total sale is greater than 1000

SELECT 
*
FROM Retail_Sales
WHERE total_sale>1000

--Q6-write a sql query to find the total no of transactions (transaction_id) made by each gender in each category

SELECT 
gender,
category,
COUNT (transactions_id) as Total_transaction
FROM Retail_Sales
GROUP BY
gender,
category
ORDER BY
category,
gender;

--Q7-write a sql query to calculate the average sale for each month. Find out best selling month in each year
SELECT 
Sale_year,
Sale_month,
Average_sale
FROM
(
	SELECT
		YEAR(sale_date) as Sale_year,
		MONTH(sale_date) as Sale_month,
		AVG(total_sale) as Average_sale,
		RANK() OVER(PARTITION BY YEAR(sale_date) ORDER BY AVG(total_sale) DESC) AS Sales_rank
	FROM Retail_Sales
	GROUP BY
	YEAR(sale_date),
	MONTH(sale_date)
) AS T1
WHERE Sales_rank=1

--Q8-Write a query to find top 5 customer based on the highest total sales
SELECT TOP 5 
customer_id,
SUM(total_sale) AS total_sales
FROM Retail_Sales
GROUP BY customer_id
ORDER BY total_sales DESC

--Q9-write a query to find the number of unique customer who purchased item from each category.
SELECT 
COUNT (DISTINCT customer_id),
category
FROM Retail_Sales
Group BY category

--Q10-find the different/unique customers who purchased in each category
SELECT DISTINCT
    category,
    customer_id
FROM Retail_Sales
ORDER BY category, customer_id;

--Q11-write a query to create each shift and number of order (Example Morning <=12, afternoonbetween 12 and 17, evening >17)
WITH Hourly_sale
AS
(SELECT *,
    CASE
        WHEN DATEPART(HOUR, sale_time) < 12 THEN 'Morning'
        WHEN DATEPART(HOUR, sale_time) BETWEEN 12 AND 17 THEN 'Afternoon'
        ELSE 'Evening'
    END AS Shift
FROM Retail_Sales)

SELECT 
Shift,
COUNT(transactions_id)AS Total_sales
FROM Hourly_sale
GROUP BY Shift
