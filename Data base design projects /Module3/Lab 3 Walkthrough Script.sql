--Step 1: Simple Product Table
CREATE TABLE Simple_product (
product_name VARCHAR(32) NOT NULL,
product_price DECIMAL(6,2) NOT NULL);

INSERT INTO Simple_product (product_name, product_price)
VALUES('Pencil', 0.3);
INSERT INTO Simple_product (product_name, product_price)
VALUES('Notebook', 1.99);
INSERT INTO Simple_product (product_name, product_price)
VALUES('Glue', 1.25);
INSERT INTO Simple_product (product_name, product_price)
VALUES('Scissors', 2.25);

--Step 2: Count with WHERE
SELECT COUNT(*)
FROM   Simple_product
WHERE  product_price > 1.50;

--Step 3: Determining Highest and Lowest
SELECT MAX(product_price) AS highest, MIN(product_price) AS lowest
FROM   Simple_product
WHERE  product_price < 1.50;

--Step 4: Product Table with Third Column
CREATE TABLE Product (
product_name VARCHAR(32) NOT NULL,
product_price DECIMAL(6,2) NOT NULL,
number_available DECIMAL(4) NOT NULL);

INSERT INTO Product (product_name, product_price, number_available)
VALUES('Pencil', 0.3, 10);
INSERT INTO Product (product_name, product_price, number_available)
VALUES('Notebook', 1.99, 15);
INSERT INTO Product (product_name, product_price, number_available)
VALUES('Glue', 1.25, 10);
INSERT INTO Product (product_name, product_price, number_available)
VALUES('Scissors', 2.25, 3);

--MAX with GROUP BY
SELECT number_available, Max(product_price) as max_price
FROM   Product
GROUP  BY number_available; 

--Step 5: MAX with HAVING
SELECT number_available, MAX(product_price) as max_price
FROM   Product
GROUP  BY number_available
HAVING MAX(product_price) > 1.50;

--Step 6: Sum Aggregate Function
SELECT SUM(product_price) AS total_price
FROM   Product
WHERE  number_available > 8;

--Step 8: More Rows for Product
DELETE FROM Product;

INSERT INTO Product (product_name, product_price, number_available)
VALUES('Pencil', 0.3, 10);
INSERT INTO Product (product_name, product_price, number_available)
VALUES('Notebook', 1.99, 15);
INSERT INTO Product (product_name, product_price, number_available)
VALUES('Glue', 1.25, 10);
INSERT INTO Product (product_name, product_price, number_available)
VALUES('Scissors', 2.25, 3);
INSERT INTO Product (product_name, product_price, number_available)
VALUES('Pencil', 0.45, 10);
INSERT INTO Product (product_name, product_price, number_available)
VALUES('Pencil', 0.49, 15);
INSERT INTO Product (product_name, product_price, number_available)
VALUES('Pencil', 0.59, 9);
INSERT INTO Product (product_name, product_price, number_available)
VALUES('Pencil', 0.3, 10);
INSERT INTO Product (product_name, product_price, number_available)
VALUES('Notebook', 2.17, 25);
INSERT INTO Product (product_name, product_price, number_available)
VALUES('Glue', 1.10, 15);
INSERT INTO Product (product_name, product_price, number_available)
VALUES('Glue', 1.35, 5);

--Useful Query for Single Measure
SELECT   product_name, SUM(number_available) AS total_available
FROM     Product
GROUP BY product_name
ORDER BY product_name;

--Useful Query for Two Measures
SELECT   product_name, 
         SUM(number_available) AS total_available,
		 COUNT(*) AS different_brands
FROM     Product
GROUP BY product_name
ORDER BY product_name;








