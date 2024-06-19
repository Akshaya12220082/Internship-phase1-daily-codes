--Normalization is a process in database design to minimize redundancy and dependency by organizing
-- fields and table of a database. The objective is to ensure that the data is stored in such a way that
-- reduces anomalies during data operations like insert, update, and delete. The process involves dividing
-- large tables into smaller ones and defining relationships among them. There are several normal forms, each with
-- a set of rules to achieve a certain level of normalization.

--normalization forms
--first noraml form(1NF) - Each column must contain atomic (indivisible) values, and each column must contain values of a single type.
--second normal form(2NF)-The table must be in 1NF, and all non-key attributes must be fully functional dependent on the primary key.
--third Normal Form (3NF)-The table must be in 2NF, and all non-key attributes must be non-transitively dependent
-- on the primary key (i.e., no transitive dependency).
--Boyce-Codd Normal Form (BCNF)-For every non-trivial functional dependency A→B, A should be a super key.
--Fourth Normal Form (4NF)-A table is in 4NF if it is in BCNF and has no multi-valued dependencies.
--Fifth Normal Form (5NF)- A table is in 5NF if it is in 4NF and not contains any join dependency and joining should be lossless.

--Anamolies
--Database anomalies can occur when a database is not properly normalized.
-- There are three main types of anomalies: insertion, update, and deletion anomalies
--
--
-- Creating an Unnormalized Database
-- single table Library that stores books, authors, and borrowers.

-- Creating database
CREATE DATABASE library;

-- Using the database
USE library;

-- Creating unnormalized Library table
CREATE TABLE Library (
    book_id INT PRIMARY KEY,
    book_title VARCHAR(100),
    author_name VARCHAR(100),
    borrower_name VARCHAR(100),
    borrow_date DATE
);

-- Inserting data into Library table
INSERT INTO Library (book_id, book_title, author_name, borrower_name, borrow_date) VALUES
(1, 'The Great Gatsby', 'F. Scott Fitzgerald', 'John Doe', '2024-06-01'),
(2, '1984', 'George Orwell', 'Jane Smith', '2024-06-02'),
(3, 'To Kill a Mockingbird', 'Harper Lee', 'Alice Johnson', '2024-06-03'),
(4, 'The Great Gatsby', 'F. Scott Fitzgerald', 'Bob Brown', '2024-06-04');

-- normalizing the Library table into three tables: Books, Authors, and Borrowings.

-- Create Books table
CREATE TABLE Books (
    book_id INT PRIMARY KEY,
    book_title VARCHAR(100),
    author_id INT
);

-- Create Authors table
CREATE TABLE Authors (
    author_id INT PRIMARY KEY,
    author_name VARCHAR(100)
);

-- Create Borrowings table
CREATE TABLE Borrowings (
    borrowing_id INT PRIMARY KEY AUTO_INCREMENT,
    book_id INT,
    borrower_name VARCHAR(100),
    borrow_date DATE,
    FOREIGN KEY (book_id) REFERENCES Books(book_id)
);

-- Insert data into Authors table
INSERT INTO Authors (author_id, author_name) VALUES
(1, 'F. Scott Fitzgerald'),
(2, 'George Orwell'),
(3, 'Harper Lee');

-- Insert data into Books table
INSERT INTO Books (book_id, book_title, author_id) VALUES
(1, 'The Great Gatsby', 1),
(2, '1984', 2),
(3, 'To Kill a Mockingbird', 3);

-- Insert data into Borrowings table
INSERT INTO Borrowings (book_id, borrower_name, borrow_date) VALUES
(1, 'John Doe', '2024-06-01'),
(2, 'Jane Smith', '2024-06-02'),
(3, 'Alice Johnson', '2024-06-03'),
(1, 'Bob Brown', '2024-06-04');

--demonstrating anamolies
--Insert anamoly
-- Inserting a new book into Books table
INSERT INTO Books (book_id, book_title, author_id) VALUES (4, 'Brave New World', 2);

--update anamoly
-- Updating author name in Authors table
UPDATE Authors
SET author_name = 'Fitzgerald'
WHERE author_id = 1;

--delete anamoly
-- Deleting a borrowing record
DELETE FROM Borrowings WHERE borrowing_id = 1;


