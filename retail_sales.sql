-- Create and select the database
CREATE DATABASE retail_sales_db;
USE retail_sales_db;

-- View all columns in the dataset
SHOW COLUMNS FROM retail_sales_dataset;

-- Find start and end dates in the dataset
SELECT MIN(date) AS start_date, MAX(date) AS end_date FROM retail_sales_dataset;

-- List all unique product categories
SELECT DISTINCT `Product Category` FROM retail_sales_dataset;

-- Count customers by gender
SELECT gender, COUNT(*) AS count FROM retail_sales_dataset GROUP BY gender;

-- Calculate total revenue
SELECT ROUND(SUM(`Total Amount`), 2) AS total_revenue FROM retail_sales_dataset;

-- Calculate total quantity sold
SELECT SUM(quantity) AS total_quantity FROM retail_sales_dataset;

-- Calculate average order value
SELECT ROUND(AVG(`Total Amount`), 2) AS avg_order_value FROM retail_sales_dataset;

-- Revenue by product category
SELECT 
    `Product Category`,
    ROUND(SUM(`Total Amount`), 2) AS category_revenue
FROM retail_sales_dataset
GROUP BY `Product Category`
ORDER BY category_revenue DESC;

-- Total quantity sold by product category
SELECT 
    `Product Category`,
    SUM(quantity) AS total_qty
FROM retail_sales_dataset
GROUP BY `Product Category`
ORDER BY total_qty DESC;

-- Total sales and average spent by gender
SELECT 
    gender,
    ROUND(SUM(`Total Amount`), 2) AS total_sales,
    ROUND(AVG(`Total Amount`), 2) AS avg_spent
FROM retail_sales_dataset
GROUP BY gender;

-- Sales distribution by age group
SELECT 
    CASE 
        WHEN age BETWEEN 18 AND 25 THEN '18-25'
        WHEN age BETWEEN 26 AND 35 THEN '26-35'
        WHEN age BETWEEN 36 AND 45 THEN '36-45'
        WHEN age BETWEEN 46 AND 60 THEN '46-60'
        ELSE '60+'
    END AS age_group,
    ROUND(SUM(`Total Amount`), 2) AS total_sales
FROM retail_sales_dataset
GROUP BY age_group
ORDER BY total_sales DESC;

-- Top 5 customers by total spending
SELECT 
    `Customer ID`,
    ROUND(SUM(`Total Amount`), 2) AS total_spent,
    COUNT(`Transaction ID`) AS transactions
FROM retail_sales_dataset
GROUP BY `Customer ID`
ORDER BY total_spent DESC 
LIMIT 5;

-- Monthly sales trend
SELECT 
    DATE_FORMAT(date, '%Y-%m') AS month,
    ROUND(SUM(`Total Amount`), 2) AS monthly_sales
FROM retail_sales_dataset
GROUP BY month
ORDER BY month;

-- Sales by day of the week
SELECT 
    DAYNAME(date) AS day_of_week,
    ROUND(SUM(`Total Amount`), 2) AS total_sales
FROM retail_sales_dataset
GROUP BY day_of_week
ORDER BY total_sales DESC;

-- Sales performance by gender and product category
SELECT 
    gender,
    `Product Category`,
    ROUND(SUM(`Total Amount`), 2) AS total_sales
FROM retail_sales_dataset
GROUP BY gender, `Product Category`
ORDER BY gender, total_sales DESC;

-- Average spend per item
SELECT 
    ROUND(AVG(`Total Amount` / quantity), 2) AS avg_price_per_item
FROM retail_sales_dataset
WHERE quantity > 0;

-- Top sales day
SELECT 
    date, 
    ROUND(SUM(`Total Amount`), 2) AS total_sales
FROM retail_sales_dataset
GROUP BY date
ORDER BY total_sales DESC
LIMIT 1;

-- Create a view for product category performance
CREATE VIEW category_performance AS
SELECT 
    `Product Category`,
    ROUND(SUM(`Total Amount`), 2) AS total_sales,
    SUM(quantity) AS total_quantity
FROM retail_sales_dataset
GROUP BY `Product Category`;

-- View category performance data
SELECT * FROM category_performance ORDER BY total_sales DESC;

-- Key overall business metrics
SELECT 
    COUNT(DISTINCT `Customer ID`) AS total_customers,
    COUNT(DISTINCT `Product Category`) AS total_categories,
    COUNT(DISTINCT `Transaction ID`) AS total_transactions,
    ROUND(SUM(`Total Amount`), 2) AS total_revenue,
    ROUND(AVG(`Total Amount`), 2) AS avg_order_value
FROM retail_sales_dataset;
