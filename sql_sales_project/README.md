## **📊 SQL Sales Analytics – Customer & Product Reports**
**Author: Ashwani Gupta**

**Tools: SQL Server, T-SQL, CTEs, Window Functions**

**Datasets: fact_sales, gold.dim_customers, gold.dim_products**

________________________________________
### **📌 Overview**
This project delivers two end-to-end SQL analytical reports—Customer Report and Product Report—built entirely using SQL Server.
Both reports consolidate multi-dimensional business metrics such as sales, customer segmentation, product performance, recency, and lifespan.

The project demonstrates strong competency in:

•	T-SQL querying

•	CTE-based data pipelines

•	Analytical transformations

•	KPI creation

•	Data modeling logic inside SQL

________________________________________
### **🧍‍♂️ 1. Customer Report**

**Purpose**

To analyze customer-level behavior and derive insights such as:

•	Total sales, total orders, and quantities

•	Customer lifespan & recency

•	Age groups and customer segments

•	Average order value (AOV)

•	Average monthly spend

•	Purchase frequency & product mix

**Key Features**

•	Multi-layer CTE pipeline (base ➝ aggregation ➝ final KPIs)

•	Customer segmentation (VIP / Regular / New)

•	Recency calculation

•	Lifespan-based metrics

•	Age group classification

________________________________________

### **📦 2. Product Report**

**Purpose**

To evaluate product-level performance and categorize items by revenue and engagement.

**Featured Metrics**

•	Total orders, total sales, total quantity sold

•	Unique customers per product

•	Lifespan and recency

•	Average selling price (ASP)

•	Average order revenue (AOR)

•	Monthly revenue trends

Product Segmentation

**Based on revenue:**

•	High-Performer

•	Mid-Range

•	Low-Performer

________________________________________

### **🏗 Technical Highlights**

•	Consistent multi-CTE structures

•	Robust NULL handling

•	Revenue-per-order & revenue-per-month logic

•	DATEDIFF-based recency & lifespan calculations

•	Optimized grouping and aggregations

________________________________________
```plaintext
**📁 Project Structure**

sql_sales_project/
│
├── customer_report.sql
├── product_report.sql
└── README.md
```
