-- Arithmetic Operators:
-- 1)
SELECT SUM(price) AS total_revenue
FROM products;
-- 2)
SELECT *
FROM products
WHERE price % 3 = 0;
-- 3)
SELECT pid, pname, price,
(price - (SELECT AVG(price) FROM products)) AS price_difference
FROM products;

-- Comparison Operators:
-- 1)
SELECT *
FROM products
WHERE price >= 50000;
-- 2)
SELECT *
FROM customer
WHERE age != 30;
-- 3)
SELECT *
FROM orders
WHERE amt <= 10000;

-- Logical Operators:
-- 1)
SELECT *
FROM products
WHERE location = 'Mumbai'
AND stock > 10;
-- 2)
SELECT *
FROM customer
WHERE addr LIKE '%Mumbai%'
OR
(SELECT SUM(amt)
FROM orders o
WHERE o.cid = customer.cid) > 20000;
-- 3)
SELECT *
FROM payment
WHERE mode != 'upi'
AND status = 'completed';
