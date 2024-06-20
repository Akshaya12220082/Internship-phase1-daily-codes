--creating a database

CREATE DATABASE company;

USE company;

CREATE TABLE employees (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(50),
    department_id INT,
    salary DECIMAL(10, 2),
    hire_date DATE
);

CREATE TABLE departments (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(50)
);

CREATE TABLE projects (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(50),
    start_date DATE,
    end_date DATE
);

CREATE TABLE employee_projects (
    employee_id INT,
    project_id INT,
    PRIMARY KEY (employee_id, project_id)
);

--inserting values
INSERT INTO departments (name) VALUES
('HR'), ('Engineering'), ('Marketing');

INSERT INTO employees (name, department_id, salary, hire_date) VALUES
('Alice', 1, 60000, '2021-01-15'),
('Bob', 2, 80000, '2020-03-22'),
('Charlie', 2, 75000, '2019-06-12'),
('Diana', 3, 65000, '2021-09-30');

INSERT INTO projects (name, start_date, end_date) VALUES
('Project A', '2022-01-01', '2022-12-31'),
('Project B', '2023-01-01', '2023-06-30');

INSERT INTO employee_projects (employee_id, project_id) VALUES
(1, 1), (2, 1), (3, 2);

--subqueries
--single row Subquery

-- Finding the employee with the highest salary
SELECT name, salary FROM employees
WHERE salary = (SELECT MAX(salary) FROM employees);

--multi row subqueries
-- Finding employees who work in the same department as 'Alice'
SELECT name FROM employees
WHERE department_id = (SELECT department_id FROM employees WHERE name = 'Alice');

--correlated subqueries
-- Finding employees who earn more than the average salary in their department
SELECT name, salary FROM employees e1
WHERE salary > (SELECT AVG(salary) FROM employees e2 WHERE e1.department_id = e2.department_id);

--join
--joins with subqueries
-- Listing employees and their department names
SELECT e.name, d.name AS department_name
FROM employees e
JOIN departments d ON e.department_id = d.id;

--joins with aggregate functions
-- Finding the average salary for each department
SELECT d.name, AVG(e.salary) AS average_salary
FROM employees e
JOIN departments d ON e.department_id = d.id
GROUP BY d.name;

--joins with date and time
-- Finding employees hired in the last 2 years
SELECT e.name, e.hire_date
FROM employees e
WHERE e.hire_date > DATE_SUB(CURDATE(), INTERVAL 2 YEAR);

--analytics functions
--RANK
-- Ranking employees by salary within their departments
SELECT name, department_id, salary,
RANK() OVER (PARTITION BY department_id ORDER BY salary DESC) AS salary_rank
FROM employees;

--DENSE RANK
-- Dense rank employees by hire date
SELECT name, hire_date,
DENSE_RANK() OVER (ORDER BY hire_date) AS hire_date_rank
FROM employees;

--ROW NUMBER
-- Assign row numbers to employees
SELECT name, salary,
ROW_NUMBER() OVER (ORDER BY salary DESC) AS row_num
FROM employees;

--CUME DIST
-- Calculating the cumulative distribution of salaries
SELECT name, salary,
CUME_DIST() OVER (ORDER BY salary) AS cume_dist
FROM employees;

--LAG
-- Comparing each employee's salary with the previous employee's salary
SELECT name, salary,
LAG(salary, 1) OVER (ORDER BY salary) AS previous_salary
FROM employees;

--LEAD
-- Comparing each employee's salary with the next employee's salary
SELECT name, salary,
LEAD(salary, 1) OVER (ORDER BY salary) AS next_salary
FROM employees;







