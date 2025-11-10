/*
============================================================
Product Report - SQL PROJECT
============================================================
Author: Ashwani Gupta
Tools: SQL Server, T-SQL, Window Functions, CTEs
Dataset: fact_sales, gold.dim_product

Purpose:
 - This report consolidates key product metrics and behaviors.

Highlights:
 1. Gathers essential fields such as product name, category, subcategory, and cost.
 2. Segments products by revenue to identify High-Performers, Mid-Range, or Low-Performers.
 3. Aggregates product-level metrics:
    - total orders
    - total sales
    - total quantity sold
    - total customers (unique)
    - lifespan (in months)
 4. Calculates valuable KPIs:
    - recency (months since last sale)
    - average order revenue (AOR)
    - average monthly revenue
============================================================
*/

WITH base_query AS (
SELECT product_name, category, subcategory, cost,
order_number,
sales_amount,
quantity,
customer_key, 
order_date
FROM fact_sales f
JOIN [gold.dim_products] p
ON f.product_key = p.product_key
),
product_aggregations AS (
SELECT 
product_name, category, subcategory, cost,
COUNT(order_number) AS total_orders,
SUM(sales_amount) AS total_sales,
SUM(quantity) AS total_quantity,
COUNT(DISTINCT customer_key) AS total_customers,
DATEDIFF(MONTH,MIN(order_date),MAX(order_date)) AS lifespan,
MAX(order_date) last_order_date,
ROUND(AVG(CAST(sales_amount AS float)/ NULLIF(quantity,0)),1) AS avg_selling_price

FROM base_query
GROUP BY product_name, category, subcategory, cost
)

SELECT 
product_name, category, subcategory, cost,
total_orders,
total_sales,
avg_selling_price,
total_quantity,
total_customers,
lifespan,
CASE WHEN total_sales > 5000 THEN 'High-Performer'
     WHEN total_sales BETWEEN 3000 AND 5000 THEN 'Mid-Range'
     ELSE 'Low-Performer'
END AS product_revenue,

DATEDIFF(MONTH,last_order_date,GETDATE()) AS recency,

CASE WHEN total_orders = 0 THEN 0
     ELSE total_sales/total_orders
END AS  avg_order_revenue,

CASE WHEN lifespan = 0 THEN total_sales
     ELSE total_sales/lifespan
     END AS avg_monthly_revenue

FROM product_aggregations
