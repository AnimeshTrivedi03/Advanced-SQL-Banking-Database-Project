USE animesh;

SELECT * FROM bank;

#Retriving all customers with saving accounts
SELECT * 
FROM bank
WHERE account_type='Savings';


# Get Customer name and their city
SELECT First_name, Last_name, city
FROM bank;

# Finding transaction above 1K
SELECT * 
FROM bank
WHERE transaction_amount>1000;

# Listing all type of unique account
SELECT DISTINCT account_type
FROM bank;

# Counting customer from each city
SELECT city, COUNT(*) AS total_customer
FROM bank
GROUP BY city;

# Get all complaints from feedback
SELECT *
FROM bank
WHERE feedback_type='Complaint';

# Finding customers older than 60
SELECT * 
FROM bank 
WHERE age>60
ORDER BY age DESC;

# Customers with loan amount greater than avg loan
SELECT first_name, last_name, loan_amount
FROM bank
WHERE loan_amount > (
    SELECT AVG(loan_amount) FROM bank
)
ORDER BY loan_amount DESC;


# Count customer by gender
SELECT gender, COUNT(*)
FROM bank
GROUP BY gender;

# Top 10 customers by account balance
SELECT first_name, last_name, account_balance
FROM bank
ORDER BY account_balance DESC
LIMIT 10;

# Average loan amount by loan status
SELECT loan_status, AVG(loan_amount)
FROM bank
GROUP BY loan_status;

# Customer with overdue credit card payment
SELECT * 
FROM bank
WHERE minimum_payment_due>0;

# List loans approved in 2023
SELECT * 
FROM bank
WHERE Approval/Rejection_Date= 2023;


#Compare male Vs femal average balance
SELECT gender, AVG(account_balance)
FROM bank
GROUP BY gender;

# Show customer with reward points > 8000
SELECT *
FROM bank
WHERE rewards_points>8000;

#Top 10 credit card spender customer
SELECT customer_id, SUM(Credit_Card_Balance) AS Total_Credit_Card_Balance
FROM bank
GROUP BY customer_id
ORDER BY total_credit_card_balance DESC
LIMIT 10;

#Top cities by total balance
SELECT city, SUM(account_balance) AS total_balance
FROM bank
GROUP BY city
ORDER BY total_balance DESC;


# Rank customer by balance
SELECT customer_id, first_name, last_name, account_balance, RANK() OVER(ORDER BY account_balance) AS balance_rank
FROM bank;

#Customer with highest loan in each city
SELECT * 
FROM (SELECT * , ROW_NUMBER() OVER(PARTITION BY city ORDER BY Loan_amount DESC) AS rn
FROM bank) t
WHERE rn=1;


# Customer having more than 3 transaction
SELECT customer_id,COUNT(*) AS txn_count
FROM bank
GROUP BY customer_id
HAVING COUNT(*)>3;



# Fraud detection (anomaly) + high transaction
SELECT * 
FROM bank
WHERE anomaly = 1 AND transaction_amount>3000;


#Total loan intrest collected
SELECT SUM('Intrest_rate') AS total_intrest
FROM bank;

#Find customer without email ID
SELECT * 
FROM bank 
WHERE email IS NULL OR Email=' ';

#top 10 Customer with highest payment due
SELECT first_name, last_name, minimum_payment_due AS Payment_Due
FROM bank
ORDER BY minimum_payment_due DESC
LIMIT 10;

#Finding customer with both auto loan and credit card
SELECT customer_id, first_name,last_name,loan_type,Credit_Limit
FROM bank
WHERE loan_type='Auto' AND Credit_Limit>0
ORDER BY Credit_Limit DESC;

# customer whoes Loan amount is above thier city's average
SELECT * 
FROM bank b
WHERE loan_amount > (SELECT AVG(Loan_amount) FROM bank WHERE city=b.city);

#This CSV has many columns like (customer + account + loan + transaction + credit card + feedback).To normalize, we split them into separate related tables.
CREATE TABLE customer(
customer_id INT PRIMARY KEY,
first_name VARCHAR(50),
last_name VARCHAR(50),
age INT,
gender VARCHAR (15),
address VARCHAR(50),
city VARCHAR(20),
contact_number VARCHAR(50),
email VARCHAR(100));
DROP TABLE customer;
SELECT * FROM customer;

# Each customer may have multiple account
CREATE TABLE account(
customer_id INT,
account_type VARCHAR(50),
account_balance DECIMAL(15,2),
Date_Of_Account_Opening DATE,
FOREIGN KEY (customer_id) REFERENCES customer(customer_id));

# For loan 
CREATE TABLE loan (
loan_id INT PRIMARY KEY,
customer_id INT,
loan_amount DECIMAL(15,2),
loan_type VARCHAR(50),
loan_status VARCHAR(50),
Approval_Rejection_Date DATE,
interest_rate DECIMAL(15,2),
FOREIGN KEY (customer_id) REFERENCES customer(customer_id)
);

# For credit card
CREATE TABLE credit_card (
card_id INT PRIMARY KEY,
customer_id INT,
credit_limit DECIMAL(15,2),
Minimum_Payment_Due DECIMAL(15,2),
Payment_Due_Date DATE,
Last_Credit_Card_Payment_Date DATE,
FOREIGN KEY (customer_id) REFERENCES customer(customer_id));

# Now Indexing for performance improvement
CREATE INDEX idx_customer_id ON account(customer_id);
CREATE INDEX idx_customer_loan ON loan(customer_id);
CREATE INDEX idx_customer_card ON credit_card(customer_id);







