# Power BI Dashboard — Executive Overview: Analysis & Insights

Business questions and analysis mapped exactly to this dashboard page —
useful as documentation in the repo, and as talking points when explaining
the project in an interview.

---

### 1. KPI Cards — Total Txn Value, Total Customers, Active Accounts, Avg Txn Amount

**Business Questions:**
- What is the overall health of the bank's transaction activity this period?
- What share of our account base is actually active, versus sitting dormant?
- Is the average transaction size healthy, or are most transactions very small (high volume, low value)?

**Analysis:**
With ₹14.3M in total transaction value across only 37 filtered customers
and an average transaction of ₹98K, this book of customers is transacting
at a high average ticket size. But **Active Accounts is only 43%** — that's
the number worth flagging first in any executive summary: more than half
the account base isn't currently active, which directly caps how much of
that ₹14.3M could grow if reactivation efforts worked.

---

### 2. Total Txn Value by Branch Name (Bar Chart)

**Business Questions:**
- Which branches are the strongest revenue contributors?
- Is transaction value concentrated in a few top branches, or spread evenly?
- Which underperforming branches might need operational review?

**Analysis:**
Delhi Branch clearly leads, followed by Mumbai and Chennai — the top 3
branches noticeably outpace the bottom 3 (Coimbatore, Hyderabad, Madurai).
This is a classic **80/20 pattern**: a handful of branches likely drive a
disproportionate share of total value. Worth a follow-up: is that because
of branch location (city size/economic activity), or because of account
mix (more high-income customers at top branches)?

---

### 3. Month Calendar Slicer

**Business Questions:**
- Can stakeholders drill into a specific day or month to investigate anomalies?
- Does activity cluster on certain days of the week?

**Analysis:**
This isn't an analysis visual by itself — it's a **navigation tool**. Its
value is enabling drill-down: if the line chart (see #5) shows a spike or
dip in a given month, the calendar lets you click into specific days to
find out whether it was one large transaction or many small ones driving
the change.

---

### 4. Credit vs Debit (Donut Chart)

**Business Questions:**
- Is more money flowing into the bank (Credit) than out (Debit)?
- Is the Credit/Debit ratio stable, or does it swing by branch/month?

**Analysis:**
Credit (57.63%) outweighs Debit (42.37%) — net inflow is positive, which
is a healthy signal. If this ratio flipped in a future period, that would
be an early warning sign of a liquidity or outflow problem worth
investigating branch-by-branch.

---

### 5. Total Txn Value by Month Name (Line Chart)

**Business Questions:**
- Is transaction value trending up, down, or flat across the year?
- Are there seasonal peaks and dips worth planning around?

**Analysis:**
The trend is clearly **not linear** — there's a sharp dip early on, a peak
mid-year, another dip, then a second smaller peak before tapering at
year-end. This volatility (rather than steady growth) suggests the bank's
transaction volume is event-driven (salary cycles, festival spending,
quarter-end business activity) rather than steadily compounding — worth
overlaying against known Indian financial calendar events (e.g. festival
season, tax deadlines) to explain the peaks.

---

### 6. Payment Mode (Bar Chart)

**Business Questions:**
- Which payment channel should the bank invest further in?
- Are customers moving away from cash toward digital modes?

**Analysis:**
IMPS leads, with ATM, NEFT, Cash, Card, and Salary fairly close behind,
and UPI trailing lowest. That's a notable finding — in most modern Indian
banking datasets, UPI usually dominates. If IMPS/ATM/NEFT are ahead here,
it's worth checking the customer segment being served (e.g. more Current/
business accounts using NEFT for transfers, versus a segment that would
be expected to use UPI more heavily).

---

### 7. Total Customers by State (Line/Area Chart)

**Business Questions:**
- Where is the customer base geographically concentrated?
- Are expansion or marketing efforts justified in underrepresented states?

**Analysis:**
Tamil Nadu leads clearly (11 customers), followed by a steady decline
through Delhi, Maharashtra, Kerala, Telangana, Karnataka (down to 2).
Combined with the branch chart (#2), it's worth checking whether the
branches with the highest transaction value are actually located in the
states with the most customers — if not, that's a mismatch between where
customers are and where the bank's strongest branches operate.

---

## Overall Executive Takeaway

Three things stand out together, not in isolation:
1. **Active Accounts is only 43%** — the single biggest lever for growth.
2. **Credit > Debit** — net inflow is healthy, a good sign to lead with.
3. **Branch and customer concentration don't necessarily line up** — worth
   a targeted follow-up analysis (this is exactly the kind of question
   Page 2, Customer & Risk Analysis, is built to dig into).
