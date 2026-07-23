-- ============================================================
-- Company Banking Dataset - Business Questions & Analysis
-- 25 questions, grouped by difficulty, with the SQL to answer them
-- ============================================================

USE company_banking;

-- ============================================================
-- SECTION A: BASIC (SELECT, WHERE, ORDER BY)
-- ============================================================

-- Q1. List all customers from Tamil Nadu, sorted by annual income (highest first).
SELECT customer_id, customer_name, city, state, annual_income
FROM Dim_Customer
WHERE state = 'Tamil Nadu'
ORDER BY annual_income DESC;

-- Q2. Show all currently Active accounts.
SELECT account_id, customer_id, account_type, open_date, status
FROM Dim_Account
WHERE status = 'Active';

-- Q3. Find all transactions above ₹1,00,000.
SELECT transaction_id, account_id, transaction_type, payment_mode, amount
FROM Fact_Transaction
WHERE amount > 100000
ORDER BY amount DESC;

-- Q4. How many customers are Male vs Female?
SELECT gender, COUNT(*) AS total_customers
FROM Dim_Customer
GROUP BY gender;

-- Q5. What are the distinct account types and how many accounts exist per type?
SELECT account_type, COUNT(*) AS account_count
FROM Dim_Account
GROUP BY account_type
ORDER BY account_count DESC;

-- ============================================================
-- SECTION B: JOINS & AGGREGATIONS
-- ============================================================

-- Q6. List each customer along with their account type and account status.
SELECT c.customer_id, c.customer_name, a.account_type, a.status
FROM Dim_Customer c
JOIN Dim_Account a ON a.customer_id = c.customer_id
ORDER BY c.customer_id;

-- Q7. Total transaction amount handled by each branch.
SELECT b.branch_name, SUM(f.amount) AS total_amount
FROM Fact_Transaction f
JOIN Dim_Branch b ON b.branch_id = f.branch_id
GROUP BY b.branch_name
ORDER BY total_amount DESC;

-- Q8. Total Credit vs Debit amount, overall.
SELECT transaction_type, SUM(amount) AS total_amount, COUNT(*) AS txn_count
FROM Fact_Transaction
GROUP BY transaction_type;

-- Q9. Which payment mode is used most often, and what's its total value?
SELECT payment_mode, COUNT(*) AS txn_count, SUM(amount) AS total_amount
FROM Fact_Transaction
GROUP BY payment_mode
ORDER BY txn_count DESC;

-- Q10. Monthly transaction volume and total amount for the year.
SELECT d.month_name, d.month, COUNT(*) AS txn_count, SUM(f.amount) AS total_amount
FROM Fact_Transaction f
JOIN Dim_Date d ON d.date_id = f.date_id
GROUP BY d.month_name, d.month
ORDER BY d.month;

-- Q11. Full customer transaction detail: name, city, branch, amount, date.
SELECT c.customer_name, c.city AS customer_city, b.branch_name,
       f.transaction_type, f.amount, d.full_date
FROM Fact_Transaction f
JOIN Dim_Account a  ON a.account_id = f.account_id
JOIN Dim_Customer c ON c.customer_id = a.customer_id
JOIN Dim_Branch b   ON b.branch_id = f.branch_id
JOIN Dim_Date d     ON d.date_id = f.date_id
ORDER BY d.full_date;

-- Q12. Average transaction amount by occupation.
SELECT c.occupation, ROUND(AVG(f.amount), 2) AS avg_txn_amount
FROM Fact_Transaction f
JOIN Dim_Account a  ON a.account_id = f.account_id
JOIN Dim_Customer c ON c.customer_id = a.customer_id
GROUP BY c.occupation
ORDER BY avg_txn_amount DESC;

-- ============================================================
-- SECTION C: FILTERING WITH HAVING / SUBQUERIES
-- ============================================================

-- Q13. Branches whose total transaction value exceeds ₹20,00,000.
SELECT b.branch_name, SUM(f.amount) AS total_amount
FROM Fact_Transaction f
JOIN Dim_Branch b ON b.branch_id = f.branch_id
GROUP BY b.branch_name
HAVING SUM(f.amount) > 2000000;

-- Q14. Customers whose annual income is above the overall average income.
SELECT customer_id, customer_name, annual_income
FROM Dim_Customer
WHERE annual_income > (SELECT AVG(annual_income) FROM Dim_Customer)
ORDER BY annual_income DESC;

-- Q15. Accounts that have never made a transaction.
SELECT a.account_id, a.customer_id, a.account_type
FROM Dim_Account a
WHERE a.account_id NOT IN (SELECT DISTINCT account_id FROM Fact_Transaction);

-- Q16. Customers who hold more than one account type would be duplicates here,
-- so instead: customers with a Current account AND above-average income.
SELECT c.customer_id, c.customer_name, c.annual_income
FROM Dim_Customer c
JOIN Dim_Account a ON a.customer_id = c.customer_id
WHERE a.account_type = 'Current'
  AND c.annual_income > (SELECT AVG(annual_income) FROM Dim_Customer);

-- Q17. Top 5 customers by total transaction amount.
SELECT c.customer_id, c.customer_name, SUM(f.amount) AS total_spent
FROM Fact_Transaction f
JOIN Dim_Account a  ON a.account_id = f.account_id
JOIN Dim_Customer c ON c.customer_id = a.customer_id
GROUP BY c.customer_id, c.customer_name
ORDER BY total_spent DESC
LIMIT 5;

-- ============================================================
-- SECTION D: CASE STATEMENTS & DATE FUNCTIONS
-- ============================================================

-- Q18. Bucket customers into income tiers.
SELECT customer_id, customer_name, annual_income,
       CASE
           WHEN annual_income < 500000 THEN 'Low'
           WHEN annual_income BETWEEN 500000 AND 1000000 THEN 'Mid'
           ELSE 'High'
       END AS income_tier
FROM Dim_Customer
ORDER BY annual_income DESC;

-- Q19. Customer age (as of today) and an age band.
SELECT customer_id, customer_name, dob,
       TIMESTAMPDIFF(YEAR, dob, CURDATE()) AS age,
       CASE
           WHEN TIMESTAMPDIFF(YEAR, dob, CURDATE()) < 25 THEN 'Young Adult'
           WHEN TIMESTAMPDIFF(YEAR, dob, CURDATE()) BETWEEN 25 AND 40 THEN 'Adult'
           ELSE 'Senior'
       END AS age_band
FROM Dim_Customer
ORDER BY age;

-- Q20. How many new accounts were opened each year?
SELECT YEAR(open_date) AS year_opened, COUNT(*) AS accounts_opened
FROM Dim_Account
GROUP BY YEAR(open_date)
ORDER BY year_opened;

-- Q21. Weekday with the highest transaction volume (are weekends slower?).
SELECT d.weekday, COUNT(*) AS txn_count, SUM(f.amount) AS total_amount
FROM Fact_Transaction f
JOIN Dim_Date d ON d.date_id = f.date_id
GROUP BY d.weekday
ORDER BY txn_count DESC;

-- ============================================================
-- SECTION E: WINDOW FUNCTIONS & CTEs (ADVANCED)
-- ============================================================

-- Q22. Rank customers within their state by annual income.
SELECT customer_id, customer_name, state, annual_income,
       RANK() OVER (PARTITION BY state ORDER BY annual_income DESC) AS income_rank_in_state
FROM Dim_Customer;

-- Q23. Running total of transaction amount per account, ordered by date.
SELECT f.account_id, d.full_date, f.amount,
       SUM(f.amount) OVER (PARTITION BY f.account_id ORDER BY d.full_date
                            ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS running_total
FROM Fact_Transaction f
JOIN Dim_Date d ON d.date_id = f.date_id
ORDER BY f.account_id, d.full_date;

-- Q24. Using a CTE: find the top spending customer per branch.
WITH branch_customer_spend AS (
    SELECT b.branch_id, b.branch_name, c.customer_id, c.customer_name,
           SUM(f.amount) AS total_spend,
           RANK() OVER (PARTITION BY b.branch_id ORDER BY SUM(f.amount) DESC) AS rnk
    FROM Fact_Transaction f
    JOIN Dim_Branch b   ON b.branch_id = f.branch_id
    JOIN Dim_Account a  ON a.account_id = f.account_id
    JOIN Dim_Customer c ON c.customer_id = a.customer_id
    GROUP BY b.branch_id, b.branch_name, c.customer_id, c.customer_name
)
SELECT branch_name, customer_name, total_spend
FROM branch_customer_spend
WHERE rnk = 1
ORDER BY total_spend DESC;

-- Q25. Month-over-month growth (%) in total transaction amount.
WITH monthly_totals AS (
    SELECT d.month, d.month_name, SUM(f.amount) AS total_amount
    FROM Fact_Transaction f
    JOIN Dim_Date d ON d.date_id = f.date_id
    GROUP BY d.month, d.month_name
)
SELECT month_name, total_amount,
       LAG(total_amount) OVER (ORDER BY month) AS prev_month_amount,
       ROUND(
         (total_amount - LAG(total_amount) OVER (ORDER BY month))
         / LAG(total_amount) OVER (ORDER BY month) * 100, 2
       ) AS mom_growth_pct
FROM monthly_totals
ORDER BY month;
