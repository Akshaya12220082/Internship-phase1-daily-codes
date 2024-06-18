-- DQL
--GROUP BY

SELECT country, COUNT(customer_id) AS number_of_customers
FROM customers
GROUP BY country;

--ORDER BY

SELECT first_name, last_name, city
FROM customers
ORDER BY city ASC, last_name DESC;

--HAVING

SELECT country, COUNT(customer_id) AS number_of_customers
FROM customers
GROUP BY country
HAVING COUNT(customer_id) > 5;

--BUILTIN FUNC

--SUM

SELECT department, SUM(salary) AS total_salary
FROM employees
GROUP BY department;

--AVG

SELECT department, AVG(salary) AS average_salary
FROM employees
GROUP BY department;

--MAX

SELECT department, MAX(salary) AS highest_salary
FROM employees
GROUP BY department;

--MIN

SELECT department, MIN(salary) AS lowest_salary
FROM employees
GROUP BY department;

--COUNT

SELECT department, COUNT(employee_id) AS number_of_employees
FROM employees
GROUP BY department;

