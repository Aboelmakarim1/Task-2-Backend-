
CREATE DATABASE online_shop;
GO
USE online_shop;
GO


CREATE TABLE CUSTOMER (
    customers_id INT IDENTITY PRIMARY KEY,
    name NVARCHAR(100) NOT NULL,
    email NVARCHAR(100) UNIQUE NOT NULL,
    phone NVARCHAR(20),
    city NVARCHAR(50),
    street NVARCHAR(50),
    building NVARCHAR(20)

);


CREATE TABLE SUPPLIERS (
    suppliers_id INT IDENTITY PRIMARY KEY,
    name NVARCHAR(100) NOT NULL,
    contact_info NVARCHAR(200)
);


CREATE TABLE PRODUCT (
    product_id INT IDENTITY PRIMARY KEY,
    suppliers_id INT NOT NULL,
    name NVARCHAR(100) NOT NULL,
    description NVARCHAR(255),
    price DECIMAL(10,2) NOT NULL,
    category NVARCHAR(100),
    FOREIGN KEY (suppliers_id) REFERENCES SUPPLIERS(suppliers_id)
);


CREATE TABLE ORDERS (
    order_id INT IDENTITY PRIMARY KEY,
    customers_id INT NOT NULL,
    order_date DATETIME DEFAULT GETUTCDATE(),
    total_amount DECIMAL(10,2) NOT NULL,
    status NVARCHAR(50) CHECK (status IN ('Pending', 'Shipped', 'Delivered', 'Cancelled')) DEFAULT 'Pending',
    FOREIGN KEY (customers_id) REFERENCES CUSTOMER(customers_id)
);


CREATE TABLE ORDER_PRODUCT (
    order_id INT NOT NULL,
    product_id INT NOT NULL,
    PRIMARY KEY (order_id, product_id),
    FOREIGN KEY (order_id) REFERENCES ORDERS(order_id),
    FOREIGN KEY (product_id) REFERENCES PRODUCT(product_id)
);


CREATE TABLE ORDER_DETAILS (
    order_detail_id INT IDENTITY PRIMARY KEY,
    order_id INT NOT NULL,
    product_id INT NOT NULL,
    price DECIMAL(10,2) NOT NULL,
    quantity INT NOT NULL,
    FOREIGN KEY (order_id) REFERENCES ORDERS(order_id),
    FOREIGN KEY (product_id) REFERENCES PRODUCT(product_id)
);



INSERT INTO CUSTOMER (name, email, phone, city, street, building)
VALUES 
('mostafa', 'mostafa@gmail.com', '01015134814', 'tanta', '5th Ave', '12A'),
('aboelmakarim', 'aboelmakarim@yahoo.com', '01015134814', 'tanta', 'Sunset Blvd', '34B');


INSERT INTO SUPPLIERS (name, contact_info)
VALUES 
('Tech Supplies ', 'tech@supplies.com'),
('Office Essentials', 'office@essentials.com');

INSERT INTO PRODUCT (suppliers_id, name, description, price, category)
VALUES 
(1, 'Laptop', 'High-performance laptop', 1200.00, 'Electronics'),
(1, 'Smartphone', 'Latest model smartphone', 800.00, 'Electronics'),
(2, 'Office Chair', 'Ergonomic office chair', 150.00, 'Furniture');


INSERT INTO ORDERS (customers_id, order_date, total_amount, status)
VALUES 
(1, GETUTCDATE(), 2000.00, 'Pending'),
(2, GETUTCDATE(), 950.00, 'Shipped');


INSERT INTO ORDER_PRODUCT (order_id, product_id)
VALUES 
(1, 1), 
(1, 2), 
(2, 3); 

INSERT INTO ORDER_DETAILS (order_id, product_id, price, quantity)
VALUES 
(1, 1, 1200.00, 1), 
(1, 2, 800.00, 1), 
(2, 3, 150.00, 2); 


SELECT * FROM CUSTOMER;
SELECT * FROM SUPPLIERS;
SELECT * FROM PRODUCT;
SELECT * FROM ORDERS;
SELECT * FROM ORDER_PRODUCT;
SELECT * FROM ORDER_DETAILS;



ALTER TABLE PRODUCT
ADD rating INT DEFAULT 0;

ALTER TABLE PRODUCT
DROP COLUMN rating;


UPDATE ORDERS
SET order_date = GETDATE()
WHERE order_id > 0;


DELETE *
FROM PRODUCT
WHERE name IS NOT NULL AND name <> 'Null';



