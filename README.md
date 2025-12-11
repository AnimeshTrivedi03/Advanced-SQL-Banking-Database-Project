# Advanced-SQL-Banking-Database-Project

Project Overview

This project demonstrates the design and implementation of an end-to-end SQL-based banking system. It includes database normalization, ER diagram design, creation of relational tables, SQL indexing for performance improvement, and 50 advanced SQL queries covering analytical functions, joins, subqueries, window functions, and reporting queries. This project simulates a real-world banking environment with customers, accounts, transactions, loans, credit cards, feedback, and anomaly detection.

Key Features

Fully normalized database structure up to Third Normal Form (3NF)

Professional ER diagram representing all major entities and relationships

SQL schema for all tables including customer, account, transactions, loan, credit card, feedback, and anomaly logs

Indexing strategy to significantly improve performance on large datasets

Advanced SQL queries demonstrating analytics and reporting capabilities

Designed for learning, portfolio building, and interview preparation

Realistic dataset structure based on the uploaded Comprehensive Banking CSV

Database Normalization

The original dataset contained mixed fields for customers, accounts, loans, credit cards, transactions, and feedback. It was normalized into the following relational tables to achieve 3NF:

customer

account

transactions

loan

credit_card

feedback

anomaly_logs

Normalization removes data redundancy and improves data consistency, scalability, and query performance.

ER Diagram

The ER diagram represents all entities and relationships within the banking system including one-to-many and many-to-many mappings between customer, account, loan, and transactions.
The major relationships include:

One customer can have multiple accounts

One account can have multiple transactions

One customer can have multiple loans

One customer can have multiple credit cards

One customer can generate multiple feedback entries

SQL Schema Design
Customer Table
CREATE TABLE customer (
    customer_id INT PRIMARY KEY,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    age INT,
    gender VARCHAR(10),
    address VARCHAR(255),
    city VARCHAR(100),
    contact_number VARCHAR(20),
    email VARCHAR(100) UNIQUE
);

Account Table
CREATE TABLE account (
    account_id INT PRIMARY KEY,
    customer_id INT,
    account_type VARCHAR(50),
    balance DECIMAL(15,2),
    date_opened DATE,
    FOREIGN KEY (customer_id) REFERENCES customer(customer_id)
);

Transactions Table
CREATE TABLE transactions (
    transaction_id INT PRIMARY KEY,
    account_id INT,
    transaction_date DATE,
    transaction_type VARCHAR(50),
    transaction_amount DECIMAL(15,2),
    FOREIGN KEY (account_id) REFERENCES account(account_id)
);

Loan Table
CREATE TABLE loan (
    loan_id INT PRIMARY KEY,
    customer_id INT,
    loan_amount DECIMAL(15,2),
    loan_type VARCHAR(50),
    loan_status VARCHAR(50),
    loan_approval_date DATE,
    loan_closure_date DATE,
    interest_amount DECIMAL(15,2),
    FOREIGN KEY (customer_id) REFERENCES customer(customer_id)
);

Credit Card Table
CREATE TABLE credit_card (
    card_id INT PRIMARY KEY,
    customer_id INT,
    credit_limit DECIMAL(15,2),
    credit_used DECIMAL(15,2),
    min_payment_due DECIMAL(15,2),
    due_date DATE,
    last_payment_date DATE,
    late_fee DECIMAL(10,2),
    FOREIGN KEY (customer_id) REFERENCES customer(customer_id)
);

Feedback Table
CREATE TABLE feedback (
    feedback_id INT PRIMARY KEY,
    customer_id INT,
    feedback_date DATE,
    feedback_type VARCHAR(50),
    resolution_status VARCHAR(50),
    resolution_date DATE,
    FOREIGN KEY (customer_id) REFERENCES customer(customer_id)
);

Anomaly Logs Table
CREATE TABLE anomaly_logs (
    anomaly_id INT PRIMARY KEY,
    customer_id INT,
    transaction_id INT,
    reason VARCHAR(255),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (customer_id) REFERENCES customer(customer_id),
    FOREIGN KEY (transaction_id) REFERENCES transactions(transaction_id)
);

SQL Indexing Strategy
Indexes for Primary and Foreign Keys
CREATE INDEX idx_customer_id ON account(customer_id);
CREATE INDEX idx_account_id ON transactions(account_id);
CREATE INDEX idx_customer_loan ON loan(customer_id);
CREATE INDEX idx_customer_card ON credit_card(customer_id);
CREATE INDEX idx_customer_feedback ON feedback(customer_id);

Indexes for High-Search Columns
CREATE INDEX idx_customer_city ON customer(city);
CREATE INDEX idx_customer_email ON customer(email);
CREATE INDEX idx_txn_date ON transactions(transaction_date);
CREATE INDEX idx_txn_type ON transactions(transaction_type);
CREATE INDEX idx_loan_status ON loan(loan_status);
CREATE INDEX idx_loan_amount ON loan(loan_amount);
CREATE INDEX idx_account_balance ON account(balance);

Composite Indexes
CREATE INDEX idx_txn_customer_date ON transactions(account_id, transaction_date);
CREATE INDEX idx_loan_type_status ON loan(loan_type, loan_status);
CREATE INDEX idx_card_customer_due ON credit_card(customer_id, due_date);

Advanced SQL Queries Included

The project includes 50 professionally written SQL queries covering:

Aggregations

Window functions

Ranking functions

Date and time analysis

Subqueries

CTEs

Fraud detection logic

Customer analytics

Loan risk identification

Account segmentation

Monthly and yearly reporting

Examples include:

Running transaction totals

Credit score percentile calculations

Risky loan customer identification

Top customers by balance

Fraudulent or anomaly transaction detection

Account balance trend analysis

How to Run This Project

Import all tables using the SQL schema file

Insert your dataset after mapping columns to the normalized tables

Create indexes using the provided scripts

Run the analytical SQL queries for insights

Use this project for portfolio, resume, or interview discussions

Purpose of This Project

This SQL banking system project is designed to help users understand:

Real-world banking database structures

SQL optimization through indexing

Analytical use cases with SQL
