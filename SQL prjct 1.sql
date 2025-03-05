--Retails Analysis SQL Project 1
Create Database sql_project_1

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

SELECT * FROM Retail_Sales
--DROP table Retail_Sales
Select Count(*)
From Retail_Sales


Select * From Retail_Sales
Where transactions_id is NULL
Select * From Retail_Sales
Where price_per_unit is NULL

EXEC sp_rename '[dbo].[Retail_sales].[quantiy]', 'Quantity', 'COLUMN'

--DATA CLEANING
 Select * From Retail_Sales
 Where transactions_id is NULL
 OR
 sale_date is NULL
 OR
 sale_time is NULL
 OR
 customer_id is NULL
 OR
  gender is NULL
 OR
  age is NULL
 OR
  category is NULL
 OR
  quantity is NULL
  or
  price_per_unit is NULL
  or
  cogs is NULL
  or 
  total_sale is NULL

  Delete From Retail_Sales
  Where transactions_id is NULL
 OR
 sale_date is NULL
 OR
 sale_time is NULL
 OR
 customer_id is NULL
 OR
  gender is NULL
 OR
  age is NULL
 OR
  category is NULL
 OR
  quantity is NULL
  or
  price_per_unit is NULL
  or
  cogs is NULL
  or 
  total_sale is NULL

  --DATA EXPLORATION

 --Unique Customer & Category
   Select Count(Distinct customer_id) as Total_sales From Retail_Sales
   Select Distinct category From Retail_Sales

   --DATA ANALYSIS & Business key problems

   --Q1 Sql query to retrive all columns for sales made on '2022-11-05'
   Select *
   From Retail_sales
   where sale_date=' 2022-11-05'

   --Q2 Sql query to retrive all transactions where category is 'clothing' and quantity sold is more than 3 in the month of nov 2022
   Select * 
   From Retail_sales
   Where category='Clothing'
   and Quantity > 3
   and Year(sale_date)='2022'
   and Month(sale_date)='11'

   --Q3 Sql query to calculate total sales(total_sale) for eaxch category
      Select 
	  category,
	  Sum(total_sale) as net_sales,
	  Count(*) as total_orders
	  From Retail_sales
	  Group by category

  --Q4 Sql query to find the avg age of customer who purchased items from 'Beauty' category'
       Select
	   Avg(age) as Avg_age
	   From Retail_sales
	   Where category= 'Beauty'
  
  --Q5 Sql query to find all transactions where the total_sale is grater than 1000
  Select * from Retail_sales
  Where total_sale > 1000

  --Q6 Sql query to find total number of transactions(transaction_id) made by each gender in each category
   Select 
   gender,
   category,
   Count(*) as total_transactions
   From Retail_sales
   Group By gender,
            category
   Order By category

 --Q7 Sql query to find avg sale for each month, find out best selling month in each year.
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

  --Q8 Sql query to find top 5 customers based on highest total sales
  Select Top 5 
  Customer_id,
  Sum(total_sale) as total_sales
  From Retail_sales
  Group by customer_id
  Order by total_sales Desc
  
  --Q9 Sql query to find number of unique customers who purchasd items from each category
 
   Select
   category,
   Count(Distinct customer_id) as unique_customer
   From retail_sales
   Group by category

  --Q10 Sql query to create each shift and number of orders(Eg Morning <12, Aftenoon between 12 & 17, Evening>=17)
 
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

	--End of Project