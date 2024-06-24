--Transaction control commands in SQL are used to manage changes made by DML (Data Manipulation Language)
-- statements such as INSERT, UPDATE, and DELETE. These commands help ensure the integrity and consistency of the database.
-- The main transaction control commands are BEGIN, COMMIT, ROLLBACK, and SAVEPOINT.

--SQL Transaction Control Commands

--BEGIN: Starts a new transaction.
BEGIN;

--COMMIT: Commits the current transaction, making all changes permanent.
COMMIT;

--ROLLBACK: Rolls back the current transaction, undoing all changes since the last BEGIN or SAVEPOINT.
ROLLBACK;

--SAVEPOINT: Sets a savepoint within the current transaction.
SAVEPOINT savepoint_name;

--ROLLBACK TO SAVEPOINT: Rolls back the transaction to the specified savepoint.
ROLLBACK TO SAVEPOINT savepoint_name;

--RELEASE SAVEPOINT: Removes a savepoint, but does not affect the transaction.
RELEASE SAVEPOINT savepoint_name;

-- Triggers

-- Trigger is a statement that a system executes automatically when there is any modification to the database
-- Triggers are used to specify certain integrity constraints and referential constraints that cannot be specified using the constraint mechanism of SQL

-- Trigers are 6 types
--1)after insert -- activated after data is inserted into the table.
--2)after update -- activated after data in the table is modified.
--3)after delete -- activated after data is deleted/removed from the table.
--4)before insert -- activated before data is inserted into the table.
--5)before update -- activated before data in the table is modified.
--6)before delete --  activated before data is deleted/removed from the table.

--Delimiters are necessary when creating stored procedures or triggers
-- Delimiters are used in MySQL to avoid conflicts with semicolons within SQL statements

- Create database
create database amazon;

use amazon;

-- Products - pid, pname, price, stock, location (Mumbai or Delhi)
create table products
(
	pid int(3) primary key,
    pname varchar(50) not null,
    price int(10) not null,
    stock int(5),
    location varchar(30) check(location in ('Mumbai','Delhi'))
);

-- Customer - cid, cname, age, addr
create table customer
(
	cid int(3) primary key,
    cname varchar(30) not null,
    age int(3),
    addr varchar(50)
);

-- Orders - oid, cid, pid, amt
create table orders
(
	oid int(3) primary key,
    cid int(3),
    pid int(3),
    amt int(10) not null,
    foreign key(cid) references customer(cid),
    foreign key(pid) references products(pid)
);


-- Payment - pay_id, oid,amount, mode(upi, cerdit, debit), status
create table payment
(
	pay_id int(3) primary key,
    oid int(3),
    amount int(10) not null,
    mode varchar(30) check(mode in('upi','credit','debit')),
    status varchar(30),
    foreign key(oid) references orders(oid)
);

#Inserting values into products table
insert into products values(1,'HP Laptop',50000,15,'Mumbai');
insert into products values(2,'Realme Mobile',20000,30,'Delhi');
insert into products values(3,'Boat earpods',3000,50,'Delhi');
insert into products values(4,'Levono Laptop',40000,15,'Mumbai');
insert into products values(5,'Charger',1000,0,'Mumbai');
insert into products values(6, 'Mac Book', 78000, 6, 'Delhi');
insert into products values(7, 'JBL speaker', 6000, 2, 'Delhi');

#Inserting values into customer table
insert into customer values(101,'Ravi',30,'fdslfjl');
insert into customer values(102,'Rahul',25,'fdslfjl');
insert into customer values(103,'Simran',32,'fdslfjl');
insert into customer values(104,'Purvesh',28,'fdslfjl');
insert into customer values(105,'Sanjana',22,'fdslfjl');

#Inserting values into orders table
insert into orders values(10001,102,3,2700);
insert into orders values(10002,104,2,18000);
insert into orders values(10003,105,5,900);
insert into orders values(10004,101,1,46000);


#inserting values into payments table
insert into payment values(1,10001,2700,'upi','completed');
insert into payment values(2,10002,18000,'credit','completed');
insert into payment values(3,10003,900,'debit','in process');

-- "SQL Trigger for Logging Product Insertions"
-- after insert
DELIMITER //
CREATE TRIGGER products_after_insert
AFTER INSERT ON products
FOR EACH ROW
BEGIN
  INSERT INTO product_log (pid, pname, price, stock, location, inserted_at)
  VALUES (NEW.pid, NEW.pname, NEW.price, NEW.stock, NEW.location, NOW());
END //
DELIMITER ;

-- create an SQL trigger to automatically update product stock levels after each new order is inserted into the 'orders' table?
DELIMITER //
CREATE TRIGGER orders_after_insert
AFTER INSERT ON orders
FOR EACH ROW
BEGIN
  UPDATE products
  SET stock = stock - 1
  WHERE pid = NEW.pid;
END //
DELIMITER ;


-- after update

-- SQL trigger to log changes made to product information whenever an update occurs in the 'products' table?
DELIMITER //
CREATE TRIGGER products_after_update
AFTER UPDATE ON products
FOR EACH ROW
BEGIN
  IF OLD.pid <> NEW.pid OR OLD.pname <> NEW.pname OR OLD.price <> NEW.price OR OLD.stock <> NEW.stock OR OLD.location <> NEW.location THEN
    INSERT INTO product_log (pid, pname, price, stock, location, updated_at)
    VALUES (OLD.pid, OLD.pname, OLD.price, OLD.stock, OLD.location, NOW());
  END IF;
END //
DELIMITER ;


-- after delete

-- SQL trigger to prevent the deletion of a product from the 'products' table if there are existing orders referencing that product in the 'orders' table?
DELIMITER //
CREATE TRIGGER products_after_delete
AFTER DELETE ON products
FOR EACH ROW
BEGIN
  -- Log information about deleted product (optional)
  -- INSERT INTO product_log (pid, pname, price, stock, location, deleted_at)
  -- VALUES (OLD.pid, OLD.pname, OLD.price, OLD.stock, OLD.location, NOW());

  -- Check if there are existing orders referencing the deleted product
  DECLARE has_orders INT DEFAULT (0);

  SELECT COUNT(*) INTO has_orders
  FROM orders
  WHERE pid = OLD.pid;

  IF has_orders > 0 THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Cannot delete product with existing orders. Update or delete orders first.';
  END IF;
END //
DELIMITER ;

-- before insert

#Trigger for Automatic Payment Status on Payment Insert
DELIMITER //

CREATE TRIGGER set_default_payment_status
BEFORE INSERT ON payment
FOR EACH ROW
BEGIN
  IF NEW.status IS NULL THEN
    SET NEW.status = 'Pending';
  END IF;
END //

DELIMITER ;

