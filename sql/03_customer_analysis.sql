-- E-Commerce Sales Analysis
-- Customer Analysis

USE ecommerce_portfolio;


-- Business Question 5
-- Which customers have spent more than €200?

SELECT customers.customer_id,
       first_name,
       last_name,
       SUM(quantity * price) AS total_spent
FROM products
JOIN order_items
    ON products.product_id = order_items.product_id
JOIN orders
    ON order_items.order_id = orders.order_id
JOIN customers
    ON orders.customer_id = customers.customer_id
GROUP BY customers.customer_id, first_name, last_name
HAVING total_spent > 200;


-- Business Question 6
-- How many orders has each customer placed?

SELECT customers.customer_id,
       first_name,
       last_name,
       COUNT(DISTINCT orders.order_id) AS number_of_orders
FROM customers
JOIN orders
    ON customers.customer_id = orders.customer_id
GROUP BY customers.customer_id, first_name, last_name;


-- Business Question 7
-- Which customers have placed at least 3 orders?

SELECT customers.customer_id,
       first_name,
       last_name,
       COUNT(DISTINCT orders.order_id) AS number_of_orders
FROM customers
JOIN orders
    ON customers.customer_id = orders.customer_id
GROUP BY customers.customer_id, first_name, last_name
HAVING number_of_orders >= 3;


-- Business Question 8
-- Who are the highest-spending customers?

SELECT customers.customer_id,
       first_name,
       last_name,
       SUM(quantity * price) AS total_spent
FROM customers
JOIN orders
    ON customers.customer_id = orders.customer_id
JOIN order_items
    ON orders.order_id = order_items.order_id
JOIN products
    ON order_items.product_id = products.product_id
GROUP BY customers.customer_id, first_name, last_name
ORDER BY total_spent DESC;
