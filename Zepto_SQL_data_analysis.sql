-- 1️⃣ Drop old table if exists
DROP TABLE IF EXISTS public.zepto;

-- 2️⃣ Create new table with columns matching your CSV
CREATE TABLE public.zepto (
    sku_id SERIAL PRIMARY KEY,
    category VARCHAR(120),
    name VARCHAR(150) NOT NULL,
    mrp NUMERIC(8,2),
    discountpercent NUMERIC(5,2),
    availablequantity INTEGER,
    discountedsellingprice NUMERIC(8,2),
    weightingms INTEGER,
    outofstock BOOLEAN,
    quantity INTEGER
);

COPY public.zepto(category, name, mrp, discountpercent, availablequantity, discountedsellingprice, weightingms, outofstock, quantity)
FROM 'D:/sqlproject/archive/zepto_v2.csv'
WITH (FORMAT csv, HEADER, DELIMITER ',', ENCODING 'UTF8', QUOTE '"', ESCAPE '''');

-- 4️⃣ Check row count
SELECT COUNT(*) AS total_rows FROM public.zepto;


--sample data
SELECT * FROM zepto
LIMIT 10;

-- null values
SELECT * FROM zepto
WHERE name IS NULL
OR
category IS NULL
OR
mrp IS NULL
OR
discountpercent IS NULL
OR
discountedsellingprice IS NULL
OR
weightingms IS NULL
OR
availablequantity IS NULL
OR
outofstock IS NULL
OR
quantity IS NULL;

--different product categories
SELECT DISTINCT category
FROM zepto
ORDER BY category;

--products in stock vs out of stock
SELECT outofstock, COUNT(sku_id)
FROM zepto
GROUP BY outofstock;

--product names present multiple times
SELECT name, COUNT(sku_id) AS "Number of SKUs"
FROM zepto
GROUP BY name
HAVING count(sku_id) > 1
ORDER BY count(sku_id) DESC;

--data cleaning

--products with price = 0
SELECT * FROM zepto
WHERE mrp = 0 OR discountedsellingprice = 0;

DELETE FROM zepto
WHERE mrp = 0;

--convert paise to rupees
UPDATE zepto
SET mrp = mrp / 100.0,
discountedSellingPrice = discountedsellingprice / 100.0;

SELECT mrp, discountedSellingPrice FROM zepto;

--data analysis

-- Q1. Find the top 10 best-value products based on the discount percentage.
SELECT DISTINCT name, mrp, discountPercent
FROM zepto
ORDER BY discountPercent DESC
LIMIT 10;

--Q2.What are the Products with High MRP but Out of Stock
SELECT DISTINCT name,mrp
FROM zepto
WHERE outOfStock = TRUE and mrp > 300
ORDER BY mrp DESC;

--Q3.Calculate Estimated Revenue for each category
SELECT category,
SUM(discountedSellingPrice * availableQuantity) AS total_revenue
FROM zepto
GROUP BY category
ORDER BY total_revenue;

-- Q4. Find all products where MRP is greater than ₹500 and discount is less than 10%.
SELECT DISTINCT name, mrp, discountPercent
FROM zepto
WHERE mrp > 500 AND discountPercent < 10
ORDER BY mrp DESC, discountPercent DESC;

-- Q5. Identify the top 5 categories offering the highest average discount percentage.
SELECT category,
ROUND(AVG(discountPercent),2) AS avg_discount
FROM zepto
GROUP BY category
ORDER BY avg_discount DESC
LIMIT 5;

-- Q6. Find the price per gram for products above 100g and sort by best value.
SELECT DISTINCT name, weightInGms, discountedSellingPrice,
ROUND(discountedSellingPrice/weightInGms,2) AS price_per_gram
FROM zepto
WHERE weightInGms >= 100
ORDER BY price_per_gram;

--Q7.Group the products into categories like Low, Medium, Bulk.
SELECT DISTINCT name, weightInGms,
CASE WHEN weightInGms < 1000 THEN 'Low'
	WHEN weightInGms < 5000 THEN 'Medium'
	ELSE 'Bulk'
	END AS weight_category
FROM zepto;

--Q8.What is the Total Inventory Weight Per Category 
SELECT category,
SUM(weightInGms * availableQuantity) AS total_weight
FROM zepto
GROUP BY category
ORDER BY total_weight;

--Q9 Find the products with the highest discount amount (MRP - Discounted Price)
SELECT name, mrp, discountedSellingPrice,
       (mrp - discountedSellingPrice) AS discount_amount,
       ROUND(((mrp - discountedSellingPrice)/mrp)*100, 2) AS discount_percentage
FROM zepto
ORDER BY discount_amount DESC
LIMIT 10;

--Q10 List categories with the lowest average stock availability
SELECT category,
       ROUND(AVG(availableQuantity), 2) AS avg_stock
FROM zepto
GROUP BY category
ORDER BY avg_stock ASC
LIMIT 5;

-- advanced analytics question
-- Q 11 Top 10 products by estimated revenue (discountedSellingPrice × availableQuantity)
SELECT name, category, discountedSellingPrice, availableQuantity,
       (discountedSellingPrice * availableQuantity) AS estimated_revenue
FROM zepto
ORDER BY estimated_revenue DESC
LIMIT 10;

-- Q12. Categories with the highest average price per gram
SELECT category,
       ROUND(AVG(discountedSellingPrice / weightInGms), 2) AS avg_price_per_gram
FROM zepto
WHERE weightInGms > 0
GROUP BY category
ORDER BY avg_price_per_gram DESC;

-- Q13. Products with low discount but high MRP (potential for promotion)
SELECT name, category, mrp, discountPercent
FROM zepto
WHERE discountPercent < 5 AND mrp > 500
ORDER BY mrp DESC, discountPercent ASC;

-- Q14. Average inventory value per category
SELECT category,
       SUM(discountedSellingPrice * availableQuantity) AS total_inventory_value,
       ROUND(SUM(discountedSellingPrice * availableQuantity) / SUM(availableQuantity), 2) AS avg_price_per_unit
FROM zepto
GROUP BY category
ORDER BY total_inventory_value DESC;

-- Q15. Products with extremely low price per gram (good value deals)
SELECT name, category, weightInGms, discountedSellingPrice,
       ROUND(discountedSellingPrice / weightInGms, 2) AS price_per_gram
FROM zepto
WHERE weightInGms >= 50
ORDER BY price_per_gram ASC
LIMIT 10;