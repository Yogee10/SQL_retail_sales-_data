# Retail Sales Analysis SQL Project

## Project Overview

**Project Title**: Retail Sales Analysis  
**Level**: Beginner  
**Database**: `SQL_Project`

This project is designed to demonstrate SQL skills and techniques typically used by data analysts to explore, clean, and analyze retail sales data. The project involves setting up a retail sales database, performing exploratory data analysis (EDA), and answering specific business questions through SQL queries. This project is ideal for those who are starting their journey in data analysis and want to build a solid foundation in SQL.

## Objectives

1. **Set up a retail sales database**: Create and populate a retail sales database with the provided sales data.
2. **Data Cleaning**: Identify and remove any records with missing or null values.
3. **Exploratory Data Analysis (EDA)**: Perform basic exploratory data analysis to understand the dataset.
4. **Business Analysis**: Use SQL to answer specific business questions and derive insights from the sales data.

## Project Structure

### 1. Database Setup

- **Database Creation**: The project starts by creating a database named `SQL_Project`.
- **Table Creation**: A table named `retail_sales` is created to store the sales data. The table structure includes columns for transaction ID, sale date, sale time, customer ID, gender, age, product category, quantity sold, price per unit, cost of goods sold (COGS), and total sale amount.

```sql
CREATE DATABASE SQL_Project;

CREATE TABLE retail_sales
(
    transactions_id INT PRIMARY KEY,
    sale_date DATE,	
    sale_time TIME,
    customer_id INT,	
    gender VARCHAR(10),
    age INT,
    category VARCHAR(35),
    quantity INT,
    price_per_unit FLOAT,	
    cogs FLOAT,
    total_sale FLOAT
);
```

### 2. Data Exploration & Cleaning

- **Record Count**: Determine the total number of records in the dataset.
- **Customer Count**: Find out how many unique customers are in the dataset.
- **Category Count**: Identify all unique product categories in the dataset.
- **Null Value Check**: Check for any null values in the dataset and delete records with missing data.

```sql
SELECT COUNT(*) FROM retail_sales;
SELECT COUNT(DISTINCT customer_id) FROM retail_sales;
SELECT DISTINCT category FROM retail_sales;

SELECT * FROM retail_sales
WHERE 
    sale_date IS NULL OR sale_time IS NULL OR customer_id IS NULL OR 
    gender IS NULL OR age IS NULL OR category IS NULL OR 
    quantity IS NULL OR price_per_unit IS NULL OR cogs IS NULL;

DELETE FROM retail_sales
WHERE 
    sale_date IS NULL OR sale_time IS NULL OR customer_id IS NULL OR 
    gender IS NULL OR age IS NULL OR category IS NULL OR 
    quantity IS NULL OR price_per_unit IS NULL OR cogs IS NULL;
```
--Data exploration

--**how many sales we have**
```sql
SELECT COUNT (*) AS total_sale FROM Retail_Sales;
```
--**how many unique customers we have**
```sql
SELECT COUNT (DISTINCT customer_id) AS total_sale FROM Retail_Sales;
```
--**how many unique category we have**
```sql
SELECT DISTINCT category FROM Retail_Sales;
```
### 3. Data Analysis & Findings
--**convert sale_date into a DATETIME value.**
```sql
SELECT CONVERT(DATETIME, sale_date, 120) FROM Retail_Sales;
```

The following SQL queries were developed to answer specific business questions:

1. **Write a SQL query to retrieve all columns for sales made on '2022-11-05**:
```sql
SELECT *
FROM Retail_Sales
WHERE sale_date = '2022-11-05'
```

2. **Write a SQL query to retrieve all transactions where the category is 'Clothing' and the quantity sold is more than 2 in the month of Nov-2022**:
```sql
SELECT *
FROM Retail_Sales
WHERE category = 'Clothing'
  AND quantiy > 2
  AND sale_date >= '2022-11-01'
  AND sale_date < '2022-12-01';
```

3. **Write a SQL query to calculate the total sales (total_sale) for each category.**:
```sql
SELECT 
	category,
	SUM(total_sale) as Net_sale,
	COUNT (*) AS Total_order
	FROM Retail_Sales
	Group BY category;
```

4. **Write a SQL query to find the average age of customers who purchased items from the 'Beauty' category.**:
```sql
SELECT 
	ROUND(AVG(age),2) as avg_age
	FROM Retail_Sales
	WHERE category ='Beauty'
```

5. **Write a SQL query to find all transactions where the total_sale is greater than 1000.**:
```sql
SELECT * FROM Retail_Sales
WHERE total_sale>1000
```

6. **Write a SQL query to find the total number of transactions (transaction_id) made by each gender in each category.**:
```sql
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
```

7. **Write a SQL query to calculate the average sale for each month. Find out best selling month in each year**:
```sql
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
```

8. **Write a SQL query to find the top 5 customers based on the highest total sales **:
```sql
SELECT TOP 5 
customer_id,
SUM(total_sale) AS total_sales
FROM Retail_Sales
GROUP BY customer_id
ORDER BY total_sales DESC
```

9. **Write a SQL query to find the number of unique customers who purchased items from each category.**:
```sql
SELECT 
COUNT (DISTINCT customer_id),
category
FROM Retail_Sales
Group BY category
```

10.**Write a SQL query to find the different/unique customers who purchased in each category.**:
```sql
SELECT DISTINCT
    category,
    customer_id
FROM Retail_Sales
ORDER BY category, customer_id;
```

11. **Write a SQL query to create each shift and number of orders (Example Morning <12, Afternoon Between 12 & 17, Evening >17)**:
```sql
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
```

## Findings

- **Customer Demographics**: The dataset includes customers from various age groups, with sales distributed across different categories such as Clothing and Beauty.
- **High-Value Transactions**: Several transactions had a total sale amount greater than 1000, indicating premium purchases.
- **Sales Trends**: Monthly analysis shows variations in sales, helping identify peak seasons.
- **Customer Insights**: The analysis identifies the top-spending customers and the most popular product categories.

## Reports

- **Sales Summary**: A detailed report summarizing total sales, customer demographics, and category performance.
- **Trend Analysis**: Insights into sales trends across different months and shifts.
- **Customer Insights**: Reports on top customers and unique customer counts per category.

## Conclusion

This project serves as a comprehensive introduction to SQL for data analysts, covering database setup, data cleaning, exploratory data analysis, and business-driven SQL queries. The findings from this project can help drive business decisions by understanding sales patterns, customer behavior, and product performance.

## Author - Yogee10

This project is part of my portfolio, showcasing the SQL skills essential for data analyst roles. If you have any questions, feedback, or would like to collaborate, feel free to get in touch!

Make sure to follow me on social media 

- **Instagram**: [Follow me for daily tips and updates](https://www.instagram.com/its_yogeshwer)
- **LinkedIn**: [Connect with me professionally](https://www.linkedin.com/in/yogeshwer-sharma/)


Thank you for your support, and I look forward to connecting with you!
