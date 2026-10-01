-- E-Commerce Sales Analysis
-- Product Analysis

USE ecommerce_portfolio;


-- Business Question 10
-- Which products have sold the most units?

SELECT products.product_name,
       SUM(quantity) AS sold_units
FROM products
JOIN order_items
    ON products.product_id = order_items.product_id
GROUP BY products.product_name
ORDER BY sold_units DESC;


-- Business Question 11
-- Which products have generated the least revenue?

SELECT products.product_name,
       SUM(quantity * price) AS total_revenue
FROM products
JOIN order_items
    ON products.product_id = order_items.product_id
GROUP BY products.product_name
ORDER BY total_revenue ASC;
