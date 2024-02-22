-- Show databases
SHOW DATABASES;

-- Create a database named mysqlProje
CREATE DATABASE mysqlMarketProject;

-- Use the mysqlProje database
USE mysqlMarketProject;

-- Products Table
CREATE TABLE Products (
    product_id INT PRIMARY KEY AUTO_INCREMENT,
    product_name VARCHAR(255),
    price DECIMAL(10, 2)
);

-- Stores Table
CREATE TABLE Stores (
    store_id INT PRIMARY KEY,
    store_name VARCHAR(255),
    location VARCHAR(255)
);

-- Customers Table
CREATE TABLE Customers (
    customer_id INT PRIMARY KEY AUTO_INCREMENT,
    customer_name VARCHAR(255),
    customer_lastname VARCHAR(255),
    email VARCHAR(255),
    phone_number VARCHAR(15),
    store_id INT,
    FOREIGN KEY (store_id) REFERENCES Stores(store_id)
);

-- Suppliers Table
CREATE TABLE Suppliers (
    supplier_id INT PRIMARY KEY,
    supplier_name VARCHAR(255),
    supplier_lastname VARCHAR(255),
    contact_person VARCHAR(255),
    contact_phone VARCHAR(15)
);

-- Employees Table
CREATE TABLE Employees (
    employee_id INT PRIMARY KEY,
    employee_name VARCHAR(255),
    employee_lastname VARCHAR(255),
    position VARCHAR(255),
    store_id INT,
    FOREIGN KEY (store_id) REFERENCES Stores(store_id)
);

-- Stock Table
CREATE TABLE Stock (
    stock_id INT PRIMARY KEY,
    product_id INT,
    store_id INT,
    quantity INT,
    FOREIGN KEY (product_id) REFERENCES Products(product_id),
    FOREIGN KEY (store_id) REFERENCES Stores(store_id)
);

-- Sales Table
CREATE TABLE Sales (
    sale_id INT PRIMARY KEY,
    customer_id INT,
    product_id INT,
    store_id INT,
    quantity INT,
    date INT,
    FOREIGN KEY (customer_id) REFERENCES Customers(customer_id),
    FOREIGN KEY (product_id) REFERENCES Products(product_id),
    FOREIGN KEY (store_id) REFERENCES Stores(store_id)
);

-- Campaigns Table
CREATE TABLE Campaigns (
    campaign_id INT PRIMARY KEY,
    store_id INT,
    campaign_name VARCHAR(255) NOT NULL,
    description TEXT,
    start_date DATE NOT NULL,
    end_date DATE NOT NULL,
    discount_rate DECIMAL(5, 2) NOT NULL,
    minimum_amount DECIMAL(10, 2) DEFAULT 0.00,
    active BOOLEAN DEFAULT true,
    CONSTRAINT chk_start_end_date CHECK (start_date <= end_date),
    FOREIGN KEY (store_id) REFERENCES Stores(store_id)
);

-- Trigger for Sales Table
DELIMITER //
CREATE TRIGGER after_sale_insert
AFTER INSERT ON Sales
FOR EACH ROW
BEGIN
    UPDATE Stock
    SET quantity = quantity - NEW.quantity
    WHERE product_id = NEW.product_id AND store_id = NEW.store_id;
END;
//
DELIMITER ;

-- Insert Data
INSERT INTO Products (product_id, product_name, price) VALUES
(1, 'Water', 2.50),
(2, 'Soda', 5.00),
(3, 'Chips', 3.50),
(4, 'Milk', 1.80),
(5, 'Feta Cheese', 12.50),
(6, 'Tomato', 2.00),
(7, 'Egg', 0.75),
(8, 'Bread', 1.50),
(9, 'Chicken Breast', 8.75),
(10, 'Pasta', 1.25);

-- Insert into Stores Table
INSERT INTO Stores (store_id, store_name, location) VALUES
(1, 'City Branch', 'Ankara'),
(2, 'Mall Branch', 'Istanbul'),
(3, 'Street Branch', 'Izmir'),
(4, 'Antalya Branch', 'Antalya'),
(5, 'Bursa Branch', 'Bursa'),
(6, 'Gaziantep Branch', 'Gaziantep'),
(7, 'Adana Branch', 'Adana'),
(8, 'Trabzon Branch', 'Trabzon'),
(9, 'Konya Branch', 'Konya'),
(10, 'Samsun Branch', 'Samsun');

-- Insert into Customers Table
INSERT INTO Customers (customer_id, customer_name, customer_lastname, email, phone_number, store_id) VALUES
(1, 'Yusuf', 'Kuşçu', 'yusuf@email.com', '555-123-4567', 2),
(2, 'Ayse', 'Demir', 'ayse@email.com', '555-987-6543', 3),
(3, 'Mehmet', 'Kaya', 'mehmet@email.com', '555-234-5678', 5),
(4, 'Zeynep', 'Akin', 'zeynep@email.com', '555-876-5432', 6),
(5, 'Emre', 'Tekin', 'emre@email.com', '555-345-6789', 1),
(6, 'Seda', 'Demir', 'seda@email.com', '555-654-3210', 7),
(7, 'Can', 'Yildirim', 'can@email.com', '555-432-1098', 8),
(8, 'Nihan', 'Toprak', 'nihan@email.com', '555-321-0987', 4),
(9, 'Berkay', 'Ozturk', 'berkay@email.com', '555-210-9876', 9),
(10, 'Elif', 'Kara', 'elif@email.com', '555-789-0123', 10);

-- Insert into Suppliers Table
INSERT INTO Suppliers (supplier_id, supplier_name, supplier_lastname, contact_person, contact_phone) VALUES
(1, 'ABC Wholesale', 'Ali', 'Cim', '555-111-2222'),
(2, 'XYZ Supplier', 'Mehmet', 'On', '555-333-4444'),
(3, '123 Distribution', 'Ayse', 'Kor', '555-555-6666'),
(4, '456 Market', 'Zeynep', 'Bil', '555-777-8888'),
(5, '789 Trade', 'Ahmet', 'Tel', '555-999-0000'),
(6, 'DEF Material', 'Seda', 'Sertac', '555-000-1111'),
(7, 'GHI Food', 'Yilmaz', 'Yigit', '555-222-3333'),
(8, 'JKL Wholesale', 'Ikkan', 'Kel', '555-444-5555'),
(9, 'MNO Supplier', 'Ersoy', 'Pudra', '555-666-7777'),
(10, 'PQR Distribution', 'Elif', 'Alemdar', '555-888-9999');

-- Insert into Employees Table
INSERT INTO Employees (employee_id, employee_name, employee_lastname, position, store_id) VALUES
(1, 'Ayse', 'Kaya', 'Cashier', 1),
(2, 'Mustafa', 'Tekin', 'Warehouse Manager', 2),
(3, 'Fatma', 'Yilmaz', 'Assistant Manager', 3),
(4, 'Ahmet', 'Demir', 'Cashier', 4),
(5, 'Zeynep', 'Celik', 'Store Manager', 5),
(6, 'Mehmet', 'Akgun', 'Cleaner', 6),
(7, 'Selin', 'Gunduz', 'Cashier', 4),
(8, 'Ali', 'Yildiz', 'Warehouse Manager', 8),
(9, 'Mikdat', 'Kal', 'Store Manager', 9),
(10, 'Berk', 'Ozdemir', 'Cashier', 10);

-- Insert into Stock Table
INSERT INTO Stock (stock_id, product_id, store_id, quantity) VALUES
(1, 1, 1, 200),
(2, 2, 1, 100),
(3, 3, 1, 150),
(4, 4, 1, 300),
(5, 5, 1, 50),
(6, 6, 1, 75),
(7, 7, 1, 400),
(8, 8, 1, 200),
(9, 9, 1, 80),
(10, 10, 1, 250);

-- Insert into Campaigns Table
INSERT INTO Campaigns (campaign_id, store_id, campaign_name, description, start_date, end_date, discount_rate, minimum_amount, active)
VALUES
(1, 6, 'New Year Discount', 'Special Discount for the New Year!', '2023-12-31', '2024-01-01', 0.15, 50.00, true),
(2, 8, 'Summer Opportunity', 'Spring Campaign has Started!', '2024-07-24', '2024-07-30', 0.10, 30.00, false),
(3, 5, 'Enjoyable Discount', 'Discount for My Pleasure!', '2024-03-24', '2024-03-29', 0.20, 10.00, false);

-- Sales Procedure
DELIMITER //
CREATE PROCEDURE MakeSale (
    IN p_sale_id INT,
    IN p_customer_id INT,
    IN p_product_id INT,
    IN p_store_id INT,
    IN p_quantity INT,
    IN p_date INT
)
BEGIN
    -- Simulate a sale with the specified customer, product, store, and quantity
    INSERT INTO Sales (sale_id, customer_id, product_id, store_id, quantity, date)
    VALUES (p_sale_id, p_customer_id, p_product_id, p_store_id, p_quantity, p_date);
END;
//
DELIMITER ;

-- Call the Sales Procedure
CALL MakeSale(6, 1, 1, 1, 5, 15);

-- Product Addition Procedure
DELIMITER //
CREATE PROCEDURE AddProduct (
    IN p_product_name VARCHAR(255),
    IN p_price DECIMAL(10, 2)
)
BEGIN
    -- Add a new product
    INSERT INTO Products (product_name, price)
    VALUES (p_product_name, p_price);
END;
//
DELIMITER ;

-- Call the Product Addition Procedure
CALL AddProduct('Potato', 29.90);

-- Customer Addition Procedure
DELIMITER //
CREATE PROCEDURE AddCustomer (
    IN p_customer_name VARCHAR(255),
    IN p_customer_lastname VARCHAR(255),
    IN p_email VARCHAR(255),
    IN p_phone_number VARCHAR(15)
)
BEGIN
    -- Add a new customer
    INSERT INTO Customers (customer_name, customer_lastname, email, phone_number)
    VALUES (p_customer_name, p_customer_lastname, p_email, p_phone_number);
END;
//
DELIMITER ;

-- Call the Customer Addition Procedure
CALL AddCustomer('Furkan', 'Kuşçu', 'furkan@email.com', '555-893-4567');

-- Select Data from Tables
SELECT * FROM Products;
SELECT * FROM Customers;
SELECT * FROM Suppliers;
SELECT * FROM Stores;
SELECT * FROM Employees;
SELECT * FROM Stock;
SELECT * FROM Campaigns;
