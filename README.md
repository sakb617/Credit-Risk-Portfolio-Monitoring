# Credit-Risk-Portfolio-Monitoring
Credit Risk Portfolio Monitoring & Oversight Analytics

Project Overview

This project analyses historical credit-card customer data to demonstrate portfolio monitoring, credit risk oversight, exception identification, and predictive model evaluation.

Using Python, SQL, statistical analysis, and machine learning, the project examines portfolio-level risk indicators, delinquency patterns, credit utilisation, high-risk customer segments, and model performance.

The objective is to simulate how a Credit Risk Oversight team can monitor portfolio quality, identify emerging risk indicators, challenge model performance, and communicate actionable findings.

Business Objectives

Monitor portfolio-level default rates and credit exposure indicators.

Analyse repayment behaviour and delinquency trends.

Identify high-risk customer segments.

Develop illustrative Key Risk Indicators (KRIs).

Build exception-monitoring rules for manual review.

Evaluate logistic regression models for default prediction.

Assess model performance across credit-limit segments.

Translate analytical findings into oversight recommendations.

Dataset

Source: UCI Machine Learning Repository – Default of Credit Card Clients

30,000 customer records

25 original columns

Historical Taiwanese credit-card data from 2005

Six months of repayment, billing, and payment history

Target variable: Default payment next month

This is a historical public dataset and is not proprietary American Express data.

Tools & Technologies

Python

Pandas and NumPy

Matplotlib and Seaborn

SQL (SQLite)

Scikit-learn

Logistic Regression

Statistical hypothesis testing

Google Colab

Project Workflow

Data understanding and quality assessment

Exploratory data analysis

Credit utilisation and delinquency feature engineering

Portfolio-level monitoring and KRI development

Credit-limit and delinquency segmentation

Exception monitoring and prioritisation

SQL-based portfolio analysis

Statistical association testing

Logistic regression modelling

Model threshold evaluation and segment-level validation

Oversight findings and recommendations

Key Findings

Overall historical default rate: 22.12%

Customers with two or more months of repayment delay: 10.43%

Default rate among customers with two or more months of delay: 69.55%

Flagged portfolio default rate: 38.27%

Non-flagged portfolio default rate: 16.06%

Model ROC-AUC: 0.728

Model recall in the 200K+ credit-limit segment: 28.8%

The analysis indicates a strong association between repayment delinquency and subsequent default. It also identifies potential model blind spots, particularly among customers without a positive recorded repayment delay.

Model Evaluation

Three logistic regression approaches were compared:

Model

Precision

Recall

F1-score

ROC-AUC

Original Logistic Regression

0.70

0.25

0.37

0.697

Class-Weighted Logistic Regression

0.38

0.59

0.46

0.697

Categorical PAY_0 Logistic Regression

0.51

0.48

0.50

0.728

The categorical PAY_0 model achieved the strongest F1-score and ROC-AUC among the three tested approaches.

The model is intended for analytical evaluation and potential manual-review prioritisation, not automated credit decisions.

Oversight Recommendations

Monitor delinquency concentrations and changes in portfolio risk.

Investigate customers with elevated utilisation and repayment delays.

Review flagged accounts through appropriate manual-review processes.

Investigate model performance differences across credit-limit segments.

Explore additional early-warning indicators beyond recent repayment status.

Validate KRI thresholds and model performance before operational use.

Limitations

The dataset represents Taiwan's credit-card market in 2005.

It does not represent American Express portfolios or current market conditions.

The dataset is not a true monthly account-level panel.

Risk appetite thresholds and exception rules are illustrative.

Model performance requires further validation, calibration, and testing.

Associations identified in the analysis should not be interpreted as causal relationships.
