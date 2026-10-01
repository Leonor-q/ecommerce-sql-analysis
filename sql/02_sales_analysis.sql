-- E-Commerce Sales Analysis
-- Sales Analysis

USE ecommerce_portfolio;


-- Business Question 2
-- What is the total sales revenue?

SELECT SUM(quantity * price) AS total_revenue
FROM order_items
JOIN products
    ON order_items.product_id = products.product_id;


-- Business Question 3
-- Which product generated the most revenue?

SELECT product_name,
       SUM(quantity * price) AS total_revenue
FROM order_items
JOIN products
    ON order_items.product_id = products.product_id
GROUP BY product_name
ORDER BY total_revenue DESC
LIMIT 1;


-- Business Question 4
-- Which product category generated the most revenue?

SELECT category,
       SUM(quantity * price) AS total_revenue
FROM order_items
JOIN products
    ON order_items.product_id = products.product_id
GROUP BY category
ORDER BY total_revenue DESC
LIMIT 1;


-- Business Question 9
-- What is the average order value (AOV)?

SELECT AVG(order_total) AS average_order_value
FROM (
    SELECT orders.order_id,
           SUM(quantity * price) AS order_total
    FROM orders
    JOIN order_items
        ON orders.order_id = order_items.order_id
    JOIN products
        ON order_items.product_id = products.product_id
    GROUP BY orders.order_id
) AS order_totals;


-- Business Question 12
-- How many units have we sold in each category?

SELECT products.category,
       SUM(quantity) AS units_sold
FROM products
JOIN order_items
    ON products.product_id = order_items.product_id
GROUP BY products.category
ORDER BY units_sold DESC;


-- Business Question 13
-- What is the monthly revenue?

SELECT DATE_FORMAT(orders.order_date, '%Y-%m') AS month,
       SUM(quantity * price) AS total_revenue
FROM orders
JOIN order_items
    ON orders.order_id = order_items.order_id
JOIN products
    ON order_items.product_id = products.product_id
GROUP BY month
ORDER BY month ASC;


-- Business Question 14
-- Which month generated the most revenue?

SELECT DATE_FORMAT(orders.order_date, '%Y-%m') AS month,
       SUM(quantity * price) AS total_revenue
FROM orders
JOIN order_items
    ON orders.order_id = order_items.order_id
JOIN products
    ON order_items.product_id = products.product_id
GROUP BY month
ORDER BY total_revenue DESC
LIMIT 1;


-- Business Question 15
-- What percentage of total revenue comes from each category?

SELECT products.category,
       SUM(quantity * price) AS total_revenue,
       ROUND(
           SUM(quantity * price) /
           (SELECT SUM(quantity * price)
            FROM order_items
            JOIN products
                ON order_items.product_id = products.product_id)
           * 100,
           2
       ) AS revenue_percentage
FROM products
JOIN order_items
    ON products.product_id = order_items.product_id
GROUP BY products.category
ORDER BY revenue_percentage DESC;
