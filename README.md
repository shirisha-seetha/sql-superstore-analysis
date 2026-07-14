# Superstore SQL Business Analysis

A SQL-based analysis of the Sample Superstore dataset, answering 40+ real-world business questions across sales, profit, customers, regions, products, shipping, and discounts. Built in Microsoft SQL Server (SSMS).

This project uses the same dataset as my [PowerBI Superstore Dashboard]( https://github.com/shirisha-seetha/superstore-sales-analysis) — this repo focuses on SQL querying and analysis, while the dashboard focuses on visualization.

---

## Dataset

The dataset (`sample_superstore.csv`) contains ~9,000+ order-level records from a fictional retail superstore, including sales, profit, discount, customer, product, region, and shipping information.

| Column | Type | Description |
|---|---|---|
| Row_ID | int | Unique row identifier (primary key) |
| Order_ID | int | Order identifier (note: multiple rows can share the same Order_ID — one per product line item) |
| Order_Date / Ship_Date | date | Order and shipping dates |
| Ship_Mode | nvarchar | Shipping method (Regular Air, Express Air, Delivery Truck) |
| Customer_ID / Customer_Name | int / nvarchar | Customer identifiers |
| Customer_Segment | nvarchar | Consumer, Corporate, Home Office |
| Product_Category / Sub_Category / Name | nvarchar | Product hierarchy |
| Region / State_or_Province / City | nvarchar | Location hierarchy |
| Sales / Profit / Discount | float / float / decimal | Core financial metrics |
| Quantity_ordered_new | tinyint | Units ordered |

Full schema: [`sql/schema.sql`](sql/schema.sql)

---

## Setup

1. Clone this repo
2. Run [`sql/schema.sql`](sql/schema.sql) to create the table
3. Run [`sql/load_data.sql`](sql/load_data.sql) to  load `C:\Users\SSS\OneDrive\Desktop\samplesuperstoreSQL\data\sample_superstore.csv`    
4. Run any analysis file in [`sql/`](sql/) independently — each is self-contained

---

## Project Structure

```
superstore-sql-analysis/
├── data/
│   └── sample_superstore.csv
├── sql/
│   ├── schema.sql              -- Table creation (DDL)
│   ├── load_data.sql           -- Data load script
│   ├── sales_analysis.sql      -- 6 questions
│   ├── customer_analysis.sql   -- 6 questions
│   ├── profit_analysis.sql     -- 6 questions
│   ├── region_analysis.sql     -- 5 questions
│   ├── product_analysis.sql    -- 5 questions
│   ├── shipping_analysis.sql   -- 5 questions
│   └── discount_analysis.sql   -- 5 questions
|   |__ order_date_analysis.sql -- 6 questions
└── README.md
```

---

## Business Questions Answered

### Sales Analysis
- Which category generates the highest sales?
- what is the product with highest and lowest sales?
- Which sub-category contributes the most revenue?
- What are the monthly sales trends?
- Which quarter has the highest sales?
- What is the running total (cumulative) sales by month?

### Customer Analysis
- Who are the top 10 customers by sales?
- Which customers generate the highest profit?
- Which customers receive the highest discounts?
- Which customer segments contribute the most revenue?
- Which customers have placed the most orders?
- what % of repeted and non repeat buyres?
### Profit Analysis
- Which category is the most profitable?
- Which products are causing losses?
- Which states have negative profits?
- Which cities generate the highest profits?
- What is the profit margin for each category?

### Regional Analysis
- Which region has the highest sales?
- Which region has the highest profit?
- Which state has the most orders?
- Which city has the highest sales?
- Which region should the company focus on for growth?

### Product Analysis
- Which products have the best profit margin?
- Which products have high sales but low profit?
- Which sub-categories show continuous losses across years?
- Which products receive the highest discounts?
- Which products should be promoted mode?

### Shipping Analysis
- Which ship mode is used most frequently?
- Which ship mode generates the highest profit?
- does the faster shipping incerase profit?
- What is the average shipping delay by ship mode?
- Which shipping mode is associated with the highest discounts?

### Discount Analysis
- Are high discounts reducing profits? *(bucketed discount-range analysis)*
- Does giving higher discounts increase sales?
- Which states receive the highest average discounts?
- Which category/sub-category receives the highest average discounts?
- what are the profits made by the discount?

### Order Date Analysis
- what is the average order value for each month?
- which region has the highest sales every year?
- which customer placed most orders in a single year?
- find the longest gap between two orders for the same customers?
- find the first and last order date of customers
-  Q1 and Q4 sales of each year
---

## Key Insights

- **Discounts above ~15-20% are associated with negative average profit.** Orders with 0% discount average ~$185 profit; orders in the 21-30% discount range average -$249 — a consistent downward trend across every bucket.
- **Higher discounts do not increase average sales per order** — average sales per order actually *decreases* as discount tier increases (from ~$1,065 at 0% discount to ~$167 at 21-30%).
- Several sub-categories show losses in **every year** of the dataset, not just isolated bad quarters, indicating a structural (not seasonal) profitability problem.
- region with least sales 

---

## SQL Techniques Demonstrated

- Window functions: `LAG()`, `RANK()`, `ROW_NUMBER()`, `SUM() OVER()` (running totals), `PARTITION BY`
- CTEs and nested subqueries
- `CASE` expressions for tiered/bucketed grouping
- Aggregate functions: `SUM`, `AVG`, `COUNT(DISTINCT ...)`, `STDEV`
- `DATEDIFF` for time-based calculations
- `HAVING` clauses with multiple conditions
- `TOP N` and `OFFSET/FETCH` for ranked results
- `FIRST_VALUE` anD `LAST_VALUE` for first and last values

---

## Notes on Methodology

- All order-counting queries use `COUNT(DISTINCT Order_ID)` where relevant, since `Order_ID` repeats across multiple product line items within the same order.
- Discount-based profit/sales comparisons are grouped into ranges (0%, 1-10%, 11-20%, 21-30%, 30%+) rather than exact discount values, to avoid misleading results from low-sample-size groups.
- "Continuous loss" questions check profitability across every year in the dataset, not just the aggregate total, to distinguish genuinely unprofitable products from one-time loss events.

---

## Tools Used

- Microsoft SQL Server / SSMS
- Dataset: Sample Superstore (CSV)
