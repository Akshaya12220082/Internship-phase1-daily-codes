--DDL & DML questions codes

-- 0)Make a new table employee with specified column id, name, position and salary.

CREATE TABLE employee (
    id INT PRIMARY KEY,
    name VARCHAR(100),
    position VARCHAR(100),
    salary DECIMAL(10, 2)
);

-- 1)insert query adds a new row to the employees table with specific values for id, name, position, and salary.

INSERT INTO employee (id, name, position, salary)
VALUES (1, 'John Doe', 'Manager', 75000.00);

-- 2)update query updates the salary of the employee with id = 1.

UPDATE employee
SET salary = 80000.00
WHERE id = 1;

-- 3)delete query deletes the row from employees where id = 1.

DELETE FROM employee
WHERE id = 1;

-- 4)create a query that creates a table called students.

CREATE TABLE students (
    student_id INT PRIMARY KEY,
    name VARCHAR(100),
    age INT
);


-- 5)create another table courses and set up a foreign key constraint in the students table.

CREATE TABLE courses (
    course_id INT PRIMARY KEY,
    course_name VARCHAR(100)
);

-- Alter the `students` table to add a `course_id` column
ALTER TABLE students
ADD COLUMN course_id INT;

-- Add foreign key constraint
ALTER TABLE students
ADD CONSTRAINT fk_course
FOREIGN KEY (course_id)
REFERENCES courses(course_id);

-- 6)Alter the students table to add the foreign key constraint.

ALTER TABLE students
ADD CONSTRAINT fk_course
FOREIGN KEY (course_id)
REFERENCES courses(course_id);


-- 7)insert some data into the students table while respecting the constraints.

INSERT INTO courses (course_id, course_name)
VALUES (1, 'Computer Science'), (2, 'Mathematics');

INSERT INTO students (student_id, name, age, course_id)
VALUES (1, 'Alice', 20, 1), (2, 'Bob', 22, 2);

-- 8)create a SELECT query that retrieves products based on numeric and date conditions.

SELECT product_id, product_name, price, stock, date_added
FROM products
WHERE price > 50 AND date_added >= '2023-01-01';

-- 9)update a record and set the last_updated column to the current datetime.

UPDATE products
SET last_updated = NOW()
WHERE product_id = 1;

-- 10)delete products with stock below a certain threshold.

-- Assuming a table `products` with columns `product_id` and `stock`
DELETE FROM products
WHERE stock < 10;
