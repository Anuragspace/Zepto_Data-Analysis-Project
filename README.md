# Zepto E-commerce Inventory Data Analysis Project

## 🚀 Project Overview

This project is a comprehensive, hands-on SQL data analysis portfolio piece that replicates the challenges data analysts face in real e-commerce and retail environments. You'll experience the entire data analysis pipeline—from working with messy, real-world inventory data to extracting meaningful business insights using SQL in PostgreSQL. 

Whether you're aiming for a data analyst role, want to showcase your SQL skills for interviews or LinkedIn, or are preparing for analytics positions in retail, product, or e-commerce, this project is designed to make you industry-ready.

![Zepto Data Analysis Screenshot](https://github.com/user-attachments/assets/e0c0a737-ba99-47c1-927d-a233c6a65e56)

---

## 👀 What Is This Project About? (Who Should Use It?)

This project is perfect for anyone who wants to:

- **Gain Real-World Experience:** Work with a realistic, messy e-commerce dataset sourced from Kaggle and Zepto’s official listings.
- **Showcase SQL & Analytical Skills:** Build a portfolio project that stands out for interviews, LinkedIn profiles, and career advancement.
- **Prepare for Analytics Roles:** Practice the skills and workflows required in retail, product, and e-commerce analytics positions.
- **Learn By Doing:** Understand how to clean, explore, and analyze real inventory data, and communicate findings effectively.

You'll learn to simulate the work of a data analyst: set up a database, perform exploratory analysis, clean and transform messy data, and deliver business-driven insights. 

---

## 🗂️ Dataset Summary

- **Source:** [Kaggle - Zepto Inventory Dataset](https://www.kaggle.com/datasets/palvinder2006/zepto-inventory-dataset)
- **Description:** Scraped from Zepto’s product listings, mimicking a true e-commerce inventory system.
- **Rows:** Each row is a unique SKU (Stock Keeping Unit). Duplicate product names represent different package sizes, weights, discounts, or categories.

### 🔑 Columns

| Column                  | Description                                                            |
|-------------------------|------------------------------------------------------------------------|
| `sku_id`                | Unique product entry identifier (Synthetic PK)                         |
| `name`                  | Product name as listed in the app                                      |
| `category`              | Product category (Fruits, Snacks, Beverages, etc.)                     |
| `mrp`                   | Maximum Retail Price (originally in paise, converted to ₹)             |
| `discountPercent`       | Discount applied to MRP (%)                                            |
| `discountedSellingPrice`| Final selling price after discount (converted to ₹)                    |
| `availableQuantity`     | Units available in inventory                                           |
| `weightInGms`           | Product weight in grams                                                |
| `outOfStock`            | Boolean flag for stock availability                                    |
| `quantity`              | Number of units per package (mixed with grams for loose produce)       |

---

## 🔧 Project Workflow

### 1. **Data Exploration**
- Counted total records in the dataset
- Previewed sample rows to understand structure
- Checked for nulls in all columns
- Identified distinct product categories
- Compared in-stock vs out-of-stock products
- Detected duplicate products (different SKUs)

### 2. **Data Cleaning**
- Removed rows with zero MRP or discounted selling price
- Converted `mrp` and `discountedSellingPrice` from paise to rupees for readability

### 3. **Business Insights & Analysis**
- Top 10 best-value products (highest discounts)
- High-MRP products currently out of stock
- Estimated potential revenue per category
- Filtered expensive products (MRP > ₹500) with minimal discount
- Ranked top 5 categories by average discount
- Calculated price per gram for value-for-money analysis
- Grouped products by weight: Low, Medium, Bulk
- Measured total inventory weight per category

---

## 👨‍💻 Example SQL Code Snippets

Below are SQL queries used to answer key business questions in this project:

### 1. How many unique product categories are in the dataset?
```sql
SELECT COUNT(DISTINCT category) AS unique_categories
FROM zepto_inventory;
```

### 2. What are the top 10 products with the highest discount percentage?
```sql
SELECT name, category, discountPercent
FROM zepto_inventory
ORDER BY discountPercent DESC
LIMIT 10;
```

### 3. Which products have an MRP above ₹500 but with less than 5% discount?
```sql
SELECT name, mrp, discountPercent
FROM zepto_inventory
WHERE mrp > 500 AND discountPercent < 5;
```

### 4. What is the potential revenue for each product category? 
```sql
SELECT category,
       SUM(discountedSellingPrice * availableQuantity) AS potential_revenue
FROM zepto_inventory
GROUP BY category
ORDER BY potential_revenue DESC;
```

### 5. Which product categories offer the highest average discounts?
```sql
SELECT category,
       AVG(discountPercent) AS avg_discount
FROM zepto_inventory
GROUP BY category
ORDER BY avg_discount DESC
LIMIT 5;
```

### 6. What is the total inventory weight by product category?
```sql
SELECT category,
       SUM(weightInGms * availableQuantity) AS total_inventory_weight
FROM zepto_inventory
GROUP BY category
ORDER BY total_inventory_weight DESC;
```

### 7. Which products are currently out of stock but have a high MRP?
```sql
SELECT name, mrp
FROM zepto_inventory
WHERE outOfStock = TRUE AND mrp > 300
ORDER BY mrp DESC;
```

### 8. Calculate price per gram for all products to find best value-for-money items
```sql
SELECT name, discountedSellingPrice / NULLIF(weightInGms, 0) AS price_per_gram
FROM zepto_inventory
ORDER BY price_per_gram ASC
LIMIT 10;
```

### 9. Group products by weight: Low (<250g), Medium (250-1000g), Bulk (>1000g)
```sql
SELECT name, 
       CASE 
           WHEN weightInGms < 250 THEN 'Low'
           WHEN weightInGms BETWEEN 250 AND 1000 THEN 'Medium'
           ELSE 'Bulk'
       END AS weight_group
FROM zepto_inventory;
```

### 10. How many products are present multiple times (duplicate names)?
```sql
SELECT name, COUNT(*) AS sku_count
FROM zepto_inventory
GROUP BY name
HAVING COUNT(*) > 1
ORDER BY sku_count DESC;
```

---

## 💡 What I Learned

- **Real-World Data Challenges:** Gained hands-on experience handling inconsistent, messy, and duplicate data typical in e-commerce.
- **SQL Mastery:** Improved proficiency in writing complex SQL queries for EDA, cleaning, and business analysis.
- **Business Acumen:** Learned how to translate data findings into actionable business insights for inventory, pricing, and category management.
- **Portfolio Building:** Produced a project that demonstrates both technical and analytical skills, perfect for interviews and professional profiles.
- **Communication:** Practiced clear documentation and storytelling for communicating analytical projects.

---

## 🛠️ Tools Used

- **Database:** PostgreSQL
- **Language:** SQL
- **Dataset:** [Kaggle Zepto Inventory](https://www.kaggle.com/datasets/palvinder2006/zepto-inventory-dataset)

---

## 🏁 How to Run This Project

1. **Download the Dataset:**  
   [Zepto Inventory Dataset on Kaggle](https://www.kaggle.com/datasets/palvinder2006/zepto-inventory-dataset)

2. **Set Up PostgreSQL:**  
   Import the CSV file into your PostgreSQL database.

3. **Run SQL Scripts:**  
   Use the provided queries and modify as needed for your analysis.

4. **Explore & Extend:**  
   Try more business questions, add visualizations, or integrate with BI tools!

---

## 📬 Contact & Feedback

If you have questions, feedback, or want to connect, feel free to reach out via [LinkedIn](#) or open an issue in this repository!

---

> **This project is ideal for demonstrating your SQL and analytics skills with real e-commerce data. Fork, clone, or use it as a template for your own portfolio!**
