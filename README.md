# 🛒 Brazilian E-Commerce Analysis (Olist) — SQL Portfolio Project

## Project Overview
This project analyzes real transaction data from **Olist**, Brazil's largest e-commerce platform, using **PostgreSQL**. The goal is to uncover business insights across sales trends, product performance, delivery efficiency, seller rankings, and customer payment behavior.

**Dataset:** [Brazilian E-Commerce Public Dataset by Olist](https://www.kaggle.com/datasets/olistbr/brazilian-ecommerce) — Kaggle  
**Tool:** PostgreSQL 18 + pgAdmin 4  
**Data period:** September 2016 – August 2018  
**Total orders:** 99,441 | **Total order items:** 112,650

---

## Database Schema

The dataset consists of **8 relational tables** connected via `order_id`, `product_id`, and `seller_id`:

```
customers ─────────┐
                   ▼
sellers ───► order_items ───► orders ◄─── order_payments
                   │              │
                   ▼              └──────► order_reviews
                products
                   │
                   ▼
     product_category_translation
```

---

## Analysis Questions & Findings

### Q1 — Monthly Sales Trend
**SQL skills:** `DATE_TRUNC`, `GROUP BY`, multi-table `JOIN`

- Platform grew rapidly from late 2016 through 2017 (nearly 10x growth)
- November 2017 was the peak month (~987K BRL), driven by Black Friday promotions
- From 2018 onward, monthly revenue stabilized at ~850K–970K BRL, signaling platform maturity

---

### Q2 — Top 10 Revenue-Generating Product Categories
**SQL skills:** 4-table `JOIN`, `RANK() OVER`, `ORDER BY DESC`

| Rank | Category | Revenue (BRL) |
|------|----------|---------------|
| 1 | Health & Beauty | 1,233,131 |
| 2 | Watches & Gifts | 1,166,176 |
| 3 | Bed, Bath & Table | 1,023,434 |
| 4 | Sports & Leisure | 954,852 |
| 5 | Computers & Accessories | 888,724 |

Health & Beauty and Watches & Gifts dominated revenue, while tech accessories ranked lower than expected.

---

### Q3 — Late Delivery Analysis
**SQL skills:** `COUNT FILTER`, `CTE`, `CASE WHEN`, date comparison

- Out of **96,478 delivered orders**, **7,826 arrived late** — an **8% late delivery rate**
- Although relatively low in percentage, ~8,000 late deliveries represent a significant reputational risk

---

### Q4 — Lowest-Rated Categories vs Late Delivery Rate
**SQL skills:** Multi-CTE, 5-table `JOIN`, `AVG`, `ROUND`

- **Security & Services** had the lowest average rating (2.50) despite 0% late rate — product/service quality is the issue
- **Home Comfort** (17% late) and **Furniture/Mattress** (14% late) showed the strongest correlation between lateness and poor ratings
- Late delivery is a contributing factor to low ratings, but not the only cause

---

### Q5 — Top 10 Sellers by Revenue
**SQL skills:** `DENSE_RANK() OVER`, `CTE`, `COUNT DISTINCT`, `SUM`

- Top seller generated **226,987 BRL** across 1,124 orders
- Rank 3 had the most orders (1,772) but ranked lower in revenue — high-volume, lower-margin strategy
- Rank 6 achieved top-6 revenue with only 319 orders — premium pricing strategy

---

### Q6 — Month-over-Month Revenue Growth Rate
**SQL skills:** `LAG() OVER`, `CTE`, window functions, percentage calculation

- February 2017 saw **+109% MoM growth** — the platform's true takeoff point
- November 2017 grew **+52%** — Black Friday effect
- 2016 figures excluded from meaningful analysis due to extremely low order volume (1–265 orders/month)
- From mid-2018, growth stabilized within ±15% monthly

---

### Q7 — Payment Method Preferences
**SQL skills:** `GROUP BY`, `COUNT`, `SUM`, `AVG`, `JOIN`

| Payment Type | Transactions | Total Value (BRL) | Avg Installments |
|---|---|---|---|
| Credit Card | 74,586 | 12,101,094 | 3.50 |
| Boleto | 19,191 | 2,769,932 | 1.00 |
| Voucher | 5,493 | 343,013 | 1.00 |
| Debit Card | 1,486 | 208,421 | 1.00 |

- Credit card dominates at **73% of transactions**
- Average of **3.5 installments** per credit card purchase reflects Brazil's strong installment payment culture
- Boleto (Brazilian bank slip) remains significant, indicating a large unbanked/non-credit-card user base

---

## SQL Skills Demonstrated

| Skill | Used In |
|---|---|
| Multi-table `JOIN` (up to 5 tables) | Q2, Q4, Q5 |
| `CTE` (WITH clause) | Q3, Q4, Q5, Q6 |
| Window functions (`RANK`, `DENSE_RANK`, `LAG`) | Q2, Q5, Q6 |
| `DATE_TRUNC` / date functions | Q1, Q6 |
| `FILTER` clause | Q3, Q4 |
| `CASE WHEN` | Q3, Q4 |
| Aggregate functions (`SUM`, `AVG`, `COUNT`) | All queries |
| Subqueries | Q5 (alternative) |
| Data filtering (`WHERE`, `HAVING`) | All queries |

---

## How to Reproduce

1. Download the dataset from [Kaggle](https://www.kaggle.com/datasets/olistbr/brazilian-ecommerce)
2. Set up PostgreSQL and create a database called `olist_db`
3. Run `01_create_tables.sql` to create all tables
4. Import each CSV file into the corresponding table via pgAdmin
5. Run analysis queries `02` through `08` in order

---

*This is the third portfolio project in a data analytics portfolio covering Python (Pandas) and SQL (PostgreSQL).*
