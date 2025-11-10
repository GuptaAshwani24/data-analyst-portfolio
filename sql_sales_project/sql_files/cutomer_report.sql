/*=========================================================
CUSTOMER REPORT - SQL PROJECT
=========================================================
Author: Ashwani Gupta
Tools: SQL Server, T-SQL, Window Functions, CTEs
Dataset: fact_sales, gold.dim_customers
Date: November 2025

Purpose:
This project consolidates key customer-level metrics such as total sales, 
average order value, lifespan, recency, and segmentation.
=========================================================*/

WITH base_query AS (
    /* 1) Base Query: Retrieve core fields */
    SELECT 
        f.order_number,
        f.product_key,
        f.order_date,
        f.sales_amount,
        f.quantity,
        c.customer_key,
        c.customer_number,
        CONCAT(c.first_name, ' ', c.last_name) AS customer_name,
        DATEDIFF(YEAR, c.birthdate, GETDATE()) AS age
    FROM fact_sales f
    JOIN [gold.dim_customers] c
        ON f.customer_key = c.customer_key
    WHERE order_date IS NOT NULL
),
customer_aggregation AS (
    /* 2) Customer Aggregations: Summarize metrics */
    SELECT 
        customer_key,
        customer_number,
        customer_name,
        age,
        COUNT(order_number) AS total_order,
        SUM(sales_amount) AS total_sales,
        SUM(quantity) AS total_quantity,
        COUNT(product_key) AS total_product,
        MAX(order_date) AS last_order,
        DATEDIFF(MONTH, MIN(order_date), MAX(order_date)) AS lifespan
    FROM base_query
    GROUP BY customer_key, customer_number, customer_name, age
)
SELECT 
    customer_key,
    customer_number,
    customer_name,
    age,
    total_order,
    total_sales,
    total_quantity,
    total_product,
    last_order,
    lifespan,
    DATEDIFF(MONTH, last_order, GETDATE()) AS recency,
    CASE 
        WHEN age < 20 THEN 'Under 20'
        WHEN age BETWEEN 20 AND 29 THEN '20-29'
        WHEN age BETWEEN 30 AND 39 THEN '30-39'
        WHEN age BETWEEN 40 AND 49 THEN '40-49'
        ELSE 'Above 50'
    END AS age_group,
    CASE 
        WHEN lifespan >= 12 AND total_sales > 5000 THEN 'VIP'
        WHEN lifespan < 12 AND total_sales > 5000 THEN 'Regular'
        ELSE 'New'
    END AS customer_segment,
    CASE 
        WHEN total_sales = 0 THEN 0
        ELSE total_sales / total_order
    END AS avg_order_value,
    CASE 
        WHEN lifespan = 0 THEN total_sales
        ELSE total_sales / lifespan
    END AS avg_monthly_spend
FROM customer_aggregation
ORDER BY customer_key;
