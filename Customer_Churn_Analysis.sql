-- =====================================================
-- Project: Customer Churn Analysis
-- Section 1: Customer Churn Rate by Contract Type
-- Objective: Compare churn rates across contract types.
-- =====================================================

USE customer_churn_analysis;

SELECT
    Contract,
    COUNT(*) AS total_customers,
    SUM(CASE WHEN Churn = 'Yes' THEN 1 ELSE 0 END) AS churned_customers,
    ROUND(
        100.0 * SUM(CASE WHEN Churn = 'Yes' THEN 1 ELSE 0 END)
        / COUNT(*),
        2
    ) AS churn_rate_pct
FROM telco_churn_fixed
GROUP BY Contract
ORDER BY churn_rate_pct DESC;

-- Key findings:
-- Month-to-month: 3,875 customers; churn rate = 42.71%.
-- One year: 1,473 customers; churn rate = 11.27%.
-- Two year: 1,695 customers; churn rate = 2.83%.
--
-- Business insight:
-- Month-to-month customers have the highest observed churn rate.
-- This is an association and does not establish causation.
-- =====================================================
-- Section 2: Customer Churn Rate by Payment Method
-- Objective: Compare churn rates across payment methods.
-- =====================================================

SELECT
    PaymentMethod,
    COUNT(*) AS total_customers,
    SUM(CASE WHEN Churn = 'Yes' THEN 1 ELSE 0 END) AS churned_customers,
    ROUND(
        100.0 * SUM(CASE WHEN Churn = 'Yes' THEN 1 ELSE 0 END)
        / COUNT(*),
        2
    ) AS churn_rate_pct
FROM telco_churn_fixed
GROUP BY PaymentMethod
ORDER BY churn_rate_pct DESC;

-- Key findings:
-- Electronic check: 2,365 customers; churn rate = 45.29%.
-- Mailed check: 1,612 customers; churn rate = 19.11%.
-- Bank transfer (automatic): 1,544 customers; churn rate = 16.71%.
-- Credit card (automatic): 1,522 customers; churn rate = 15.24%.
--
-- Business insight:
-- Electronic check users have the highest observed churn rate.
-- Further investigation is needed to understand the relationship.
-- These results show association, not causation.
-- =====================================================
-- Section 3: Customer Churn Rate by Tenure Group
-- Objective: Compare churn rates across customer tenure groups.
-- =====================================================

SELECT
    CASE
        WHEN CAST(tenure AS UNSIGNED) BETWEEN 0 AND 12 THEN '0-12 months'
        WHEN CAST(tenure AS UNSIGNED) BETWEEN 13 AND 24 THEN '13-24 months'
        WHEN CAST(tenure AS UNSIGNED) BETWEEN 25 AND 48 THEN '25-48 months'
        WHEN CAST(tenure AS UNSIGNED) BETWEEN 49 AND 72 THEN '49-72 months'
        ELSE 'Other'
    END AS tenure_group,
    COUNT(*) AS total_customers,
    SUM(CASE WHEN Churn = 'Yes' THEN 1 ELSE 0 END) AS churned_customers,
    ROUND(
        100.0 * SUM(CASE WHEN Churn = 'Yes' THEN 1 ELSE 0 END)
        / COUNT(*),
        2
    ) AS churn_rate_pct
FROM telco_churn_fixed
GROUP BY tenure_group
ORDER BY
    CASE tenure_group
        WHEN '0-12 months' THEN 1
        WHEN '13-24 months' THEN 2
        WHEN '25-48 months' THEN 3
        WHEN '49-72 months' THEN 4
        ELSE 5
    END;

-- Key findings:
-- 0-12 months: 2,186 customers; churn rate = 47.44%.
-- 13-24 months: 1,024 customers; churn rate = 28.71%.
-- 25-48 months: 1,594 customers; churn rate = 20.39%.
-- 49-72 months: 2,239 customers; churn rate = 9.51%.
--
-- Business insight:
-- Customers in their first 12 months have the highest observed churn rate.
-- Retention efforts could prioritize early-tenure customers.
-- The observed relationship does not establish causation.

-- =====================================================
-- Section 4: Customer Churn Rate by Internet Service
-- Objective: Compare churn rates across internet service types.
-- =====================================================

SELECT
    InternetService,
    COUNT(*) AS total_customers,
    SUM(CASE WHEN Churn = 'Yes' THEN 1 ELSE 0 END) AS churned_customers,
    ROUND(
        100.0 * SUM(CASE WHEN Churn = 'Yes' THEN 1 ELSE 0 END)
        / COUNT(*),
        2
    ) AS churn_rate_pct
FROM telco_churn_fixed
GROUP BY InternetService
ORDER BY churn_rate_pct DESC;

-- Key findings:
-- Fiber optic: 3,096 customers; churn rate = 41.89%.
-- DSL: 2,421 customers; churn rate = 18.96%.
-- No internet service: 1,526 customers; churn rate = 7.40%.
--
-- Business insight:
-- Fiber optic customers have the highest observed churn rate.
-- The business should investigate possible reasons for this difference.
-- These results show association, not causation.

-- =====================================================
-- Section 5: Customer Churn Rate by Tech Support
-- Objective: Compare churn rates based on technical support availability.
-- =====================================================

SELECT
    TechSupport,
    COUNT(*) AS total_customers,
    SUM(CASE WHEN Churn = 'Yes' THEN 1 ELSE 0 END) AS churned_customers,
    ROUND(
        100.0 * SUM(CASE WHEN Churn = 'Yes' THEN 1 ELSE 0 END)
        / COUNT(*),
        2
    ) AS churn_rate_pct
FROM telco_churn_fixed
GROUP BY TechSupport
ORDER BY churn_rate_pct DESC;

-- Key findings:
-- No tech support: 3,473 customers; churn rate = 41.64%.
-- Tech support: 2,044 customers; churn rate = 15.17%.
-- No internet service: 1,526 customers; churn rate = 7.40%.
--
-- Business insight:
-- Customers without tech support have the highest observed churn rate.
-- The business could investigate whether support access and service
-- experience are associated with customer retention.
-- These results show association, not causation.

-- =====================================================
-- Section 6: Overall Customer Churn Rate
-- Objective: Calculate the overall customer churn rate.
-- =====================================================

SELECT
    COUNT(*) AS total_customers,
    SUM(CASE WHEN Churn = 'Yes' THEN 1 ELSE 0 END) AS churned_customers,
    SUM(CASE WHEN Churn = 'No' THEN 1 ELSE 0 END) AS retained_customers,
    ROUND(
        100.0 * SUM(CASE WHEN Churn = 'Yes' THEN 1 ELSE 0 END)
        / COUNT(*),
        2
    ) AS overall_churn_rate_pct
FROM telco_churn_fixed;

-- =====================================================
-- Overall Customer Churn: Key Findings
-- =====================================================
-- Total customers: 7,043.
-- Churned customers: 1,869.
-- Retained customers: 5,174.
-- Overall churn rate: 26.54%.
--
-- Business insight:
-- Approximately 26.54% of customers have churned.
-- Retention strategies should investigate high-churn segments,
-- particularly month-to-month customers and customers in their
-- first 12 months.
--
-- Note:
-- These analyses identify associations, not causal relationships.

