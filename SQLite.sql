-- Get all customers who signed up after Jan 11, 2023, ordered by signup date
SELECT customer_name, email
FROM customers
WHERE signup_date >= '2023-01-11'
ORDER BY signup_date;
-- Show all orders with customer names & order dates
SELECT o.order_id, c.customer_name, o.order_date
FROM orders o
INNER JOIN customers c ON o.customer_id = c.customer_id;
-- Total quantity of each product sold
SELECT p.product_name, SUM(oi.quantity) AS total_quantity
FROM order_items oi
JOIN products p ON oi.product_id = p.product_id
GROUP BY p.product_name;
-- Find customers who ordered the most expensive product
SELECT customer_name FROM customers
WHERE customer_id IN (
  SELECT o.customer_id
  FROM orders o
  JOIN order_items oi ON o.order_id = oi.order_id
  WHERE oi.product_id = (
    SELECT product_id FROM products ORDER BY price DESC LIMIT 1
  )
);
-- Create a view of all order details
CREATE VIEW order_details AS
SELECT o.order_id, c.customer_name, p.product_name, oi.quantity
FROM orders o
JOIN customers c ON o.customer_id = c.customer_id
JOIN order_items oi ON o.order_id = oi.order_id
JOIN products p ON oi.product_id = p.product_id;
-- Only show products where total sold quantity > 1
SELECT p.product_name, SUM(oi.quantity) AS total_quantity
FROM order_items oi
JOIN products p ON oi.product_id = p.product_id
GROUP BY p.product_name
HAVING total_quantity > 1;