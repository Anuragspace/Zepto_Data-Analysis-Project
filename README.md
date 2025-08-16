# Zepto E-commerce Inventory Data Analysis Project

## 🚀 Project Overview

This end-to-end Data Analyst portfolio project demonstrates how real-world e-commerce inventory data is explored, cleaned, and analyzed using **PostgreSQL**. The project is designed to simulate the daily workflow of data analysts working in retail or e-commerce environments. It features hands-on SQL work, from setting up a messy dataset to delivering business insights.

![Zepto Data Analysis Screenshot](https://github.com/user-attachments/assets/e0c0a737-ba99-47c1-927d-a233c6a65e56)

---

## 📣 Who Is This Project For?

- **📊 Data Analyst aspirants:** Build a strong SQL portfolio project for interviews and LinkedIn.
- **📚 SQL learners:** Practice SQL techniques on real-world data.
- **💼 Interview preparation:** Perfect for roles in retail, e-commerce, or product analytics.

---

## 🗂️ Dataset Summary

- **Source:** [Kaggle - Zepto Inventory Dataset](https://www.kaggle.com/datasets/palvinder2006/zepto-inventory-dataset)
- **Description:** Scraped from Zepto’s official product listings, simulating a real e-commerce inventory system.
- **Rows:** Each row is a unique SKU (Stock Keeping Unit). Duplicate product names exist due to different packages, sizes, discounts, or categories.

### 🔑 Columns Explained

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

## 🛠️ Tools Used

- **Database:** PostgreSQL
- **Language:** SQL
- **Dataset:** [Kaggle Zepto Inventory](https://www.kaggle.com/datasets/palvinder2006/zepto-inventory-dataset)

---

## 👨‍💻 Example SQL Code Snippets

### Sample 1: Counting Total Records

```sql
SELECT COUNT(*) AS total_records
FROM zepto_inventory;
```

### Sample 2: Checking Nulls Across Columns

```sql
SELECT
    COUNT(*) FILTER (WHERE sku_id IS NULL) AS null_sku_id,
    COUNT(*) FILTER (WHERE name IS NULL) AS null_name,
    COUNT(*) FILTER (WHERE category IS NULL) AS null_category,
    COUNT(*) FILTER (WHERE mrp IS NULL) AS null_mrp,
    COUNT(*) FILTER (WHERE discountedSellingPrice IS NULL) AS null_discountedSellingPrice
FROM zepto_inventory;
```

### Sample 3: Removing Zero Pricing Entries

```sql
DELETE FROM zepto_inventory
WHERE mrp = 0 OR discountedSellingPrice = 0;
```

### Sample 4: Converting Paise to Rupees

```sql
UPDATE zepto_inventory
SET
    mrp = mrp / 100.0,
    discountedSellingPrice = discountedSellingPrice / 100.0;
```

### Sample 5: Top 10 Best-Value Products

```sql
SELECT name, category, discountPercent
FROM zepto_inventory
ORDER BY discountPercent DESC
LIMIT 10;
```

---

## 📊 Key Insights Delivered

- **Category Analysis:** Identified top categories with highest sales potential and discounts.
- **Stock Analysis:** Flagged products out of stock with high revenue potential.
- **Value Analysis:** Ranked products by price per gram and overall value for money.
- **Inventory Management:** Segmented inventory by weight and measured total stock per category.
- **Business Recommendations:** Provided actionable insights for improving pricing, stock, and category management.

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

## 💡 What You’ll Learn

- Real-world SQL data cleaning and analysis
- EDA workflows for e-commerce datasets
- Insight generation for business decision-making
- Portfolio-ready documentation and code samples

---

## 📬 Contact & Feedback

If you have questions, feedback, or want to connect, feel free to reach out via [LinkedIn](#) or open an issue in this repository!

---

> **This project is perfect for showcasing your SQL skills and understanding of e-commerce data analysis. Clone, fork or use it as a template for your own portfolio!**
