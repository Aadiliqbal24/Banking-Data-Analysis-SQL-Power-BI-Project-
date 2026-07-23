-- ============================================================
-- Company Banking Dataset - Data Load
-- Loads CSV files (in /data folder) into MySQL using LOAD DATA
-- NOTE: Update the file path below to the full path of your
-- local /data folder before running (MySQL needs absolute paths).
-- If you hit "The MySQL server is running with the
-- --secure-file-priv option", copy the CSVs into the folder
-- shown by: SHOW VARIABLES LIKE 'secure_file_priv';
-- ============================================================

USE company_banking;

-- Disable FK checks temporarily so load order is flexible
SET FOREIGN_KEY_CHECKS = 0;

-- ------------------------------------------------------------
-- Dim_Customer
-- ------------------------------------------------------------
LOAD DATA INFILE '/path/to/project/data/Dim_Customer.csv'
INTO TABLE Dim_Customer
FIELDS TERMINATED BY ','
OPTIONALLY ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS
(customer_id, customer_name, gender, dob, city, state, occupation, annual_income, join_date);

-- ------------------------------------------------------------
-- Dim_Branch
-- ------------------------------------------------------------
LOAD DATA INFILE '/path/to/project/data/Dim_Branch.csv'
INTO TABLE Dim_Branch
FIELDS TERMINATED BY ','
OPTIONALLY ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS
(branch_id, branch_name, city, state);

-- ------------------------------------------------------------
-- Dim_Date
-- ------------------------------------------------------------
LOAD DATA INFILE '/path/to/project/data/Dim_Date.csv'
INTO TABLE Dim_Date
FIELDS TERMINATED BY ','
OPTIONALLY ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS
(date_id, full_date, day, month, month_name, quarter, year, weekday);

-- ------------------------------------------------------------
-- Dim_Account (depends on Dim_Customer)
-- ------------------------------------------------------------
LOAD DATA INFILE '/path/to/project/data/Dim_Account.csv'
INTO TABLE Dim_Account
FIELDS TERMINATED BY ','
OPTIONALLY ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS
(account_id, customer_id, account_number, account_type, open_date, status);

-- ------------------------------------------------------------
-- Fact_Transaction (depends on Dim_Account, Dim_Branch, Dim_Date)
-- ------------------------------------------------------------
LOAD DATA INFILE '/path/to/project/data/Fact_Transaction.csv'
INTO TABLE Fact_Transaction
FIELDS TERMINATED BY ','
OPTIONALLY ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS
(transaction_id, account_id, branch_id, date_id, transaction_type, payment_mode, amount);

SET FOREIGN_KEY_CHECKS = 1;

-- ------------------------------------------------------------
-- Sanity checks: row counts should be 100, 10, 366, 100, 5000
-- ------------------------------------------------------------
SELECT 'Dim_Customer' AS tbl, COUNT(*) AS row_count FROM Dim_Customer
UNION ALL SELECT 'Dim_Branch', COUNT(*) FROM Dim_Branch
UNION ALL SELECT 'Dim_Date', COUNT(*) FROM Dim_Date
UNION ALL SELECT 'Dim_Account', COUNT(*) FROM Dim_Account
UNION ALL SELECT 'Fact_Transaction', COUNT(*) FROM Fact_Transaction;
