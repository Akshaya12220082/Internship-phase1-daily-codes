-- PRACTICE QUESTIONS

-- 1. PROCEDURES

-- Ques 1. Write a query to create a function that calculates the total revenue from the 'orders' and 'payment' tables for completed orders, and call the function to get the total revenue.
-- Ques 2. Write a query to create a function that calculates the total revenue from the 'orders' and 'payment' tables for completed orders, and call the function to get the total revenue.
-- Ques 3. Write a query to create a procedure with an IN parameter to retrieve details of a specific product based on the product ID passed as a parameter. Call the procedure for product ID 5.
-- Ques 4. Write a query to create a procedure with an OUT parameter to get the count of products in the 'products' table, store it in a variable, and select the variable to display the count.
-- Ques 5. Write a query to use the predefined SUM() cursor to calculate the total price of all products in the 'products' table where the product category is 'Electronics'.
-- Ques 6. Write a query to declare and use a cursor to iterate through the 'products' table and print the product name for each product.






-- Answer 1:
DELIMITER $$
CREATE PROCEDURE select_all_products()
BEGIN
    SELECT * FROM products;
END$$
DELIMITER ;

CALL select_all_products();


-- Answer 2:
DELIMITER $$
CREATE FUNCTION get_total_revenue()
RETURNS DECIMAL(10,2)
DETERMINISTIC
BEGIN
    DECLARE total_revenue DECIMAL(10,2);
    SELECT SUM(p.amount) INTO total_revenue
    FROM payment p
    INNER JOIN orders o ON p.order_id = o.order_id
    WHERE o.status = 'Completed';
    RETURN total_revenue;
END$$
DELIMITER ;

SELECT get_total_revenue();

-- Answer 3:
DELIMITER $$
CREATE PROCEDURE get_product_details(IN product_id INT)
BEGIN
    SELECT * FROM products WHERE product_id = product_id;
END$$
DELIMITER ;

CALL get_product_details(5);


-- Answer 4:
DELIMITER $$
CREATE PROCEDURE get_product_count(OUT total_count INT)
BEGIN
    SELECT COUNT(*) INTO total_count FROM products;
END$$
DELIMITER ;

CALL get_product_count(@count);
SELECT @count AS total_products;


-- Answer 5:
DELIMITER $$
CREATE PROCEDURE calc_total_electronics_price(OUT total_price DECIMAL(10,2))
BEGIN
    SELECT SUM(price) INTO total_price
    FROM products
    WHERE category = 'Electronics';
END$$
DELIMITER ;

CALL calc_total_electronics_price(@total);
SELECT @total AS total_electronics_price;


-- Answer 6:
DELIMITER //
CREATE PROCEDURE print_product_names()
BEGIN
    DECLARE product_name VARCHAR(100);
    DECLARE done INT DEFAULT FALSE;
    DECLARE product_cursor CURSOR FOR SELECT name FROM products;
    DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = TRUE;

    OPEN product_cursor;

    get_names: LOOP
        FETCH product_cursor INTO product_name;
        IF done THEN
            LEAVE get_names;
        END IF;
        SELECT product_name;
    END LOOP get_names;

    CLOSE product_cursor;
END;
DELIMITER ;

--cursors
-- EXAMPLE:
-- To calculate the number of customers
DELIMITER //
DECLARE @customer_count INT;

SELECT @customer_count = COUNT(*)
FROM customer;

PRINT 'Number of customers: ' + CAST(@customer_count AS VARCHAR(10));
DELIMITER ;

--predefined cursor
-- EXAMPLE:
-- To calculate the sum of prices for all HP laptops
DELIMITER //
DECLARE @total_price INT;

SELECT @total_price = SUM(price)
FROM products
WHERE pname = 'HP Laptop';
PRINT 'Total price of all HP Laptops: ' + CAST(@total_price AS VARCHAR(20));
DELIMITER ;

--functions
-- EXAMPLE:
-- Function to calculate total revenue for a product
DELIMITER $$
CREATE FUNCTION get_total_revenue()
RETURNS INT
DETERMINISTIC
BEGIN
DECLARE total_revenue INT;
-- Declare a variable to store the total revenue
-- Calculate the total revenue by summing the 'amount' column from the 'payment' table
-- for all completed orders
SELECT SUM(p.amount) INTO total_revenue
FROM payment p
INNER JOIN orders o ON p.oid = o.oid
WHERE p.status = 'completed';
RETURN total_revenue; -- Returns the calculated total revenue
END$$
DELIMITER ;
-- Restores the original delimiter