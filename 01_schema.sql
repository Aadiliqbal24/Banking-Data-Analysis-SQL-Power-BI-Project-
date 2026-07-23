-- ============================================================
-- Company Banking Dataset - Schema Creation
-- Database: MySQL 8.0+
-- ============================================================

DROP DATABASE IF EXISTS company_banking;
CREATE DATABASE company_banking;
USE company_banking;

-- ------------------------------------------------------------
-- Dimension: Customer
-- ------------------------------------------------------------
CREATE TABLE Dim_Customer (
    customer_id     INT PRIMARY KEY,
    customer_name   VARCHAR(50)  NOT NULL,
    gender          CHAR(1)      NOT NULL,
    dob             DATE         NOT NULL,
    city            VARCHAR(30)  NOT NULL,
    state           VARCHAR(30)  NOT NULL,
    occupation      VARCHAR(30)  NOT NULL,
    annual_income   DECIMAL(12,2) NOT NULL,
    join_date       DATE         NOT NULL
);

-- ------------------------------------------------------------
-- Dimension: Branch
-- ------------------------------------------------------------
CREATE TABLE Dim_Branch (
    branch_id       INT PRIMARY KEY,
    branch_name     VARCHAR(50) NOT NULL,
    city            VARCHAR(30) NOT NULL,
    state           VARCHAR(30) NOT NULL
);

-- ------------------------------------------------------------
-- Dimension: Date
-- ------------------------------------------------------------
CREATE TABLE Dim_Date (
    date_id         INT PRIMARY KEY,
    full_date       DATE        NOT NULL,
    day             TINYINT     NOT NULL,
    month           TINYINT     NOT NULL,
    month_name      VARCHAR(10) NOT NULL,
    quarter         TINYINT     NOT NULL,
    year            SMALLINT    NOT NULL,
    weekday         VARCHAR(10) NOT NULL
);

-- ------------------------------------------------------------
-- Dimension: Account (references Customer)
-- ------------------------------------------------------------
CREATE TABLE Dim_Account (
    account_id      INT PRIMARY KEY,
    customer_id     INT          NOT NULL,
    account_number  BIGINT       NOT NULL UNIQUE,
    account_type    VARCHAR(20)  NOT NULL,
    open_date       DATE         NOT NULL,
    status          VARCHAR(10)  NOT NULL,
    CONSTRAINT fk_account_customer
        FOREIGN KEY (customer_id) REFERENCES Dim_Customer(customer_id)
);

-- ------------------------------------------------------------
-- Fact: Transaction (references Account, Branch, Date)
-- ------------------------------------------------------------
CREATE TABLE Fact_Transaction (
    transaction_id    INT PRIMARY KEY,
    account_id        INT           NOT NULL,
    branch_id         INT           NOT NULL,
    date_id           INT           NOT NULL,
    transaction_type  VARCHAR(10)   NOT NULL,
    payment_mode      VARCHAR(15)   NOT NULL,
    amount            DECIMAL(12,2) NOT NULL,
    CONSTRAINT fk_txn_account
        FOREIGN KEY (account_id) REFERENCES Dim_Account(account_id),
    CONSTRAINT fk_txn_branch
        FOREIGN KEY (branch_id) REFERENCES Dim_Branch(branch_id),
    CONSTRAINT fk_txn_date
        FOREIGN KEY (date_id) REFERENCES Dim_Date(date_id)
);

-- Helpful indexes for common query patterns
CREATE INDEX idx_account_customer ON Dim_Account(customer_id);
CREATE INDEX idx_txn_account ON Fact_Transaction(account_id);
CREATE INDEX idx_txn_branch ON Fact_Transaction(branch_id);
CREATE INDEX idx_txn_date ON Fact_Transaction(date_id);
