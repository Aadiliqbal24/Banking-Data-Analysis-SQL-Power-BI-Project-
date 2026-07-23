# Company Banking Data Analysis (SQL + Power BI Project)

An end-to-end data analytics portfolio project built on a company banking
dataset — modeled as a star schema (4 dimension tables + 1 fact table),
analyzed with **Snowflake SQL** (joins, subqueries, CTEs, window functions),
and visualized with an interactive **Power BI dashboard**.

## Dataset Overview

| Table              | Rows | Description                                   |
|--------------------|------|------------------------------------------------|
| `Dim_Customer`     | 100  | Customer demographics (name, gender, DOB, city, state, occupation, income) |
| `Dim_Account`      | 100  | Bank accounts linked to customers (type, status, open date) |
| `Dim_Branch`       | 10   | Branch details (name, city, state)             |
| `Dim_Date`         | 366  | Date dimension for 2024 (day/month/quarter/year/weekday) |
| `Fact_Transaction` | 5000 | Transactions (amount, type, payment mode, links to account/branch/date) |

**Schema type:** Star schema — `Fact_Transaction` is the fact table, joined
to `Dim_Account`, `Dim_Branch`, and `Dim_Date`; `Dim_Account` in turn links
to `Dim_Customer`.

```
Dim_Customer ──< Dim_Account ──< Fact_Transaction >── Dim_Branch
                                        v
                                    Dim_Date
```

## Project Structure

```
├── data/
│   ├── Dim_Customer.csv
│   ├── Dim_Account.csv
│   ├── Dim_Branch.csv
│   ├── Dim_Date.csv
│   └── Fact_Transaction.csv
├── sql/
│   ├── 01_schema.sql                                 -- CREATE TABLE statements (PK/FK)
│   ├── 02_load_data.sql                               -- data load script
│   ├── 03_business_questions.sql                      -- 26 core business questions
│   ├── 04_sql_concepts_examples.sql                    -- 12 SQL concepts x 3 examples each
│   ├── 05_advanced_company_questions.sql               -- 14 interview-level questions
│   └── 05_advanced_company_questions_with_output.md    -- same 14, with sample output
├── powerbi/
│   ├── Banking_Dashboard.pbix                          -- Power BI file
│   ├── dashboard_questions.md                          -- visuals mapped to business Qs + DAX
│   ├── executive_overview_analysis.md                  -- worked analysis of Page 1
│   └── screenshots/
│       ├── executive_overview.png
│       └── customer_risk_analysis.png
└── README.md
```

## How to Run (Snowflake)

1. Open a Snowflake worksheet.
2. Run `sql/01_schema.sql` to create the database, schema, and all 5 tables.
3. Stage and load the 5 CSVs from `data/` in this order (parents before the
   fact table): `Dim_Customer` → `Dim_Branch` → `Dim_Date` → `Dim_Account` →
   `Fact_Transaction`.
4. Verify row counts: 100 / 10 / 366 / 100 / 5000.
5. Run `sql/03_business_questions.sql`, `04_sql_concepts_examples.sql`, and
   `05_advanced_company_questions.sql` to reproduce the analysis.

## Business Questions Answered

**26 core business questions** (`03_business_questions.sql`), grouped by difficulty:

**A. Basic filtering & sorting** — customers by state, active accounts, high-value transactions, gender split, account types

**B. Joins & aggregation** — customer/account details, revenue per branch, Credit vs Debit totals, payment mode popularity, monthly trends, average transaction by occupation

**C. Subqueries & HAVING** — high-revenue branches, above-average earners, dormant accounts, top 5 customers by spend

**D. CASE statements & date functions** — income tiers, age bands, yearly account growth, weekday transaction patterns

**E. Window functions & CTEs** — income rank within state, running totals, top spender per branch, month-over-month growth %

**Plus:**
- `04_sql_concepts_examples.sql` — 12 SQL concepts (joins, subqueries, CASE, string/date functions, window functions, CTEs, views, set operations) with 3 worked examples each
- `05_advanced_company_questions.sql` — 14 interview-level questions: anomaly/fraud detection, duplicate transaction checks, income quartiles, H1 vs H2 branch growth, dormant-but-valuable accounts, PIVOT reporting, relational division, composite branch scoring, self-join collusion checks, 7-day moving averages, customer segmentation matrix

## Power BI Dashboard

**Page 1 — Executive Overview:** Total transaction value, customer count,
active account %, average transaction amount; transaction value by branch;
monthly transaction trend; Credit vs Debit split; payment mode breakdown;
customers by state.


## Tech Stack
- **Database:** Snowflake
- **Visualization:** Power BI
- **SQL concepts used:** DDL, FK relationships, joins (inner/left/self),
  GROUP BY/HAVING, correlated & non-correlated subqueries, CASE expressions,
  string & date functions, CTEs, window functions (RANK, DENSE_RANK, NTILE,
  LAG, running SUM), views, PIVOT, set operations (UNION/INTERSECT/EXCEPT)
- **Power BI concepts used:** DAX measures (CALCULATE, DATEADD, DIVIDE),
  slicers, KPI cards, scatter plots, heatmap matrices, drill-through

## Notes
- All SQL queries were logic-tested against the dataset before publishing.
- Screenshots were captured with all filters reset to "All" so the numbers
  reflect the full dataset.
  
## Author - AADIL IQBAL A
This project showcases SQL skills essential for database management and analysis. For more content on SQL and data analysis, connect with me through the following channels:

LinkedIn: https://www.linkedin.com/in/aadiliqbal24/

Thank you
