# Grocery Store Management System

This project is a simple Grocery Store Management System developed using MySQL. It includes database schema creation, data insertion, and SQL procedures for common operations.

## Table of Contents
- Features
- Database Schema
- How to Use
- Stored Procedures
- Sample Data

## Features
- **Product Management:** Add, remove, or update products in the inventory.
- **Store Management:** Manage information about different stores, their locations, and employees.
- **Customer Management:** Add and manage customer details including name, email, and phone number.
- **Supplier Management:** Keep track of suppliers and their contact information.
- **Employee Management:** Manage store employees, their positions, and responsibilities.
- **Stock Tracking:** Track the stock of products in different stores.
- **Sales:** Record customer purchases and update stock levels accordingly.
- **Campaigns:** Implement marketing campaigns with start and end dates, discount rates, and minimum purchase amounts.

## Database Schema
The database consists of the following tables:
- `Products`: Information about the products available in the store.
- `Stores`: Details about different store locations.
- `Customers`: Information about the customers.
- `Suppliers`: Details of the product suppliers.
- `Employees`: Information about store employees.
- `Stock`: Details of the stock, including product quantity in each store.
- `Sales`: Records of customer purchases.
- `Campaigns`: Information about marketing campaigns.

## How to Use
1. Clone the repository to your local machine.
2. Import the SQL script (`grocery_store_management.sql`) into your MySQL database to create the schema and tables.
3. Use the provided stored procedures to interact with the database, such as making sales, adding products, or adding customers.

## Stored Procedures
The project includes stored procedures for common operations:
- `MakeSale`: Simulates a sale with specified customer, product, store, quantity, and date.
- `AddProduct`: Adds a new product to the inventory with specified name and price.
- `AddCustomer`: Adds a new customer with specified name, last name, email, and phone number.

## Sample Data
The project includes sample data for products, stores, customers, suppliers, employees, stock, and campaigns. You can customize this data or add more as needed.

Feel free to explore and modify the project to suit your specific requirements.
