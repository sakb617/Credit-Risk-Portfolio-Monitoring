
-- CREDIT RISK PORTFOLIO MONITORING & OVERSIGHT ANALYTICS
-- Dataset: UCI Default of Credit Card Clients
-- SQL dialect: SQLite

-- 1. Overall portfolio summary

SELECT
    COUNT(*) AS total_customers,
    SUM(LIMIT_BAL) AS total_assigned_credit_limits,
    ROUND(AVG(LIMIT_BAL), 2) AS average_credit_limit,
    SUM("default payment next month") AS total_defaults,
    ROUND(
        100.0 * SUM("default payment next month") / COUNT(*), 2
    ) AS overall_default_rate
FROM credit_risk_customers;


-- 2. Default rate by delinquency category

SELECT
    CASE
        WHEN PAY_0 <= 0 THEN 'No Positive Delay'
        WHEN PAY_0 = 1 THEN '1 Month Delay'
        WHEN PAY_0 = 2 THEN '2 Months Delay'
        ELSE '3+ Months Delay'
    END AS delinquency_category,
    COUNT(*) AS customers,
    SUM("default payment next month") AS defaults,
    ROUND(
        100.0 * SUM("default payment next month") / COUNT(*), 2
    ) AS default_rate
FROM credit_risk_customers
GROUP BY delinquency_category
ORDER BY
    CASE delinquency_category
        WHEN 'No Positive Delay' THEN 1
        WHEN '1 Month Delay' THEN 2
        WHEN '2 Months Delay' THEN 3
        ELSE 4
    END;


-- 3. Default rate by credit limit segment

SELECT
    CASE
        WHEN LIMIT_BAL < 50000 THEN 'Below 50K'
        WHEN LIMIT_BAL < 100000 THEN '50K - 100K'
        WHEN LIMIT_BAL < 200000 THEN '100K - 200K'
        WHEN LIMIT_BAL < 500000 THEN '200K - 500K'
        ELSE '500K+'
    END AS credit_limit_segment,
    COUNT(*) AS customers,
    SUM(LIMIT_BAL) AS assigned_credit_limits,
    SUM("default payment next month") AS defaults,
    ROUND(
        100.0 * SUM("default payment next month") / COUNT(*), 2
    ) AS default_rate
FROM credit_risk_customers
GROUP BY credit_limit_segment;


-- 4. Default rate by latest repayment status

SELECT
    PAY_0 AS repayment_status,
    COUNT(*) AS customers,
    SUM("default payment next month") AS defaults,
    ROUND(
        100.0 * SUM("default payment next month") / COUNT(*), 2
    ) AS default_rate
FROM credit_risk_customers
GROUP BY PAY_0
ORDER BY PAY_0;


-- 5. High-risk exception monitoring

WITH customer_flags AS (
    SELECT
        *,
        100.0 * BILL_AMT1 / NULLIF(LIMIT_BAL, 0) AS utilization,
        CASE
            WHEN PAY_0 >= 2
                 AND 100.0 * BILL_AMT1 / NULLIF(LIMIT_BAL, 0) >= 90
                THEN 'Critical'
            WHEN PAY_0 >= 2 THEN 'High'
            WHEN 100.0 * BILL_AMT1 / NULLIF(LIMIT_BAL, 0) >= 90
                THEN 'Medium'
            ELSE 'Not Flagged'
        END AS review_priority
    FROM credit_risk_customers
)
SELECT
    review_priority,
    COUNT(*) AS customers,
    SUM("default payment next month") AS defaults,
    ROUND(
        100.0 * SUM("default payment next month") / COUNT(*), 2
    ) AS default_rate,
    ROUND(AVG(utilization), 2) AS average_utilization
FROM customer_flags
GROUP BY review_priority
ORDER BY customers DESC;


-- 6. Flagged vs non-flagged portfolio comparison

WITH customer_flags AS (
    SELECT
        CASE
            WHEN PAY_0 >= 2
              OR 100.0 * BILL_AMT1 / NULLIF(LIMIT_BAL, 0) >= 90
            THEN 'Flagged'
            ELSE 'Not Flagged'
        END AS flag_status,
        "default payment next month" AS default_status
    FROM credit_risk_customers
)
SELECT
    flag_status,
    COUNT(*) AS customers,
    SUM(default_status) AS defaults,
    ROUND(
        100.0 * SUM(default_status) / COUNT(*), 2
    ) AS default_rate
FROM customer_flags
GROUP BY flag_status;
