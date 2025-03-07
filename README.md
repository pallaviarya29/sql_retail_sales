# Retail Sales Analysis SQL Project

## Project Overview

**Project Title**: Retail Sales Analysis  
**Level**: Beginner  
**Database**: `sql_project_1`

This project is designed to demonstrate SQL skills and techniques typically used by data analysts to explore, clean, and analyze retail sales data. The project involves setting up a retail sales database, performing exploratory data analysis (EDA), and answering specific business questions through SQL queries. This project is ideal for those who are starting their journey in data analysis and want to build a solid foundation in SQL.

## Objectives

1. **Set up a retail sales database**: Create and populate a retail sales database with the provided sales data.
2. **Data Cleaning**: Identify and remove any records with missing or null values.
3. **Exploratory Data Analysis (EDA)**: Perform basic exploratory data analysis to understand the dataset.
4. **Business Analysis**: Use SQL to answer specific business questions and derive insights from the sales data.

## Project Structure

### 1. Database Setup

- **Database Creation**: The project starts by creating a database named `sql_project_1`.
- **Table Creation**: A table named `retail_sales` is created to store the sales data. The table structure includes columns for transaction ID, sale date, sale time, customer ID, gender, age, product category, quantity sold, price per unit, cost of goods sold (COGS), and total sale amount.

```sql
Create Table Retail_Sales
               (
                transactions_id	int  PRIMARY KEY,
                sale_date	Date,
                sale_time	Time,
                customer_id	int,
                gender	varchar(15),
                age	int,
                category varchar(15),	
                quantity int,
                price_per_unit	float,
                cogs	Float,
                total_sale float
				)
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

### 3. Data Analysis & Findings

The following SQL queries were developed to answer specific business questions:

1. **Write a SQL query to retrieve all columns for sales made on '2022-11-05**:
```sql
Select *
From Retail_sales
where sale_date=' 2022-11-05'
```

2. **Write a SQL query to retrieve all transactions where the category is 'Clothing' and the quantity sold is more than 3 in the month of Nov-2022**:
```sql
Select * 
From Retail_sales
Where category='Clothing'
and Quantity > 3
and Year(sale_date)='2022'
and Month(sale_date)='11'
```

3. **Write a SQL query to calculate the total sales (total_sale) for each category.**:
```sql
Select 
category,
Sum(total_sale) as net_sales,
Count(*) as total_orders
From Retail_sales
Group by category
```

4. **Write a SQL query to find the average age of customers who purchased items from the 'Beauty' category.**:
```sql
Select
Avg(age) as Avg_age
From Retail_sales
Where category= 'Beauty'
```

5. **Write a SQL query to find all transactions where the total_sale is greater than 1000.**:
```sql
Select * from Retail_sales
Where total_sale > 1000

```

6. **Write a SQL query to find the total number of transactions (transaction_id) made by each gender in each category.**:
```sql
Select 
gender,
category,
Count(*) as total_transactions
From Retail_sales
Group By gender,
         category
Order By category
```

7. **Write a SQL query to calculate the average sale for each month. Find out best selling month in each year**:
```sql
Select * From
   (
      Select 
      Year(sale_date) as Year,
      Month(sale_date) as Month,
      Avg(total_sale) as avg_sale,
      Rank() Over (Partition by Year(sale_date) Order by Avg(total_sale) DESC) as rank
      From Retail_sales
      Group by YEAR(sale_date), Month(sale_date)
	) as t1
	where rank=1
```

8. **Write a SQL query to find the top 5 customers based on the highest total sales **:
```sql
Select Top 5 
Customer_id,
Sum(total_sale) as total_sales
From Retail_sales
Group by customer_id
Order by total_sales Desc
```

9. **Write a SQL query to find the number of unique customers who purchased items from each category.**:
```sql
Select
category,
Count(Distinct customer_id) as unique_customer
From retail_sales
Group by category
```

10. **Write a SQL query to create each shift and number of orders (Example Morning <12, Afternoon Between 12 & 17, Evening >17)**:
```sql
Select
  Case 
      When Cast(sale_time as Time) <'12:00:00' then 'Morning'
      When Cast(sale_time as Time) between '12:00:00' and '17:00:00' then 'Afternoon'
      Else 'Evening'
  End as shift,
  Count(*) as total_orders
  From Retail_sales
  Group by 
  Case 
      When Cast(sale_time as Time) <'12:00:00' then 'Morning'
      When Cast(sale_time as Time) between '12:00:00' and '17:00:00' then 'Afternoon'
      Else 'Evening'
	  End
	  Order by total_orders Desc

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
