# 🩺 Predicting Medical Insurance Costs using Linear Regression

![Python](https://img.shields.io/badge/Python-3776AB?style=for-the-badge&logo=python&logoColor=white)
![R](https://img.shields.io/badge/R-276DC3?style=for-the-badge&logo=r&logoColor=white)
![Scikit-learn](https://img.shields.io/badge/scikit--learn-%23F7931E.svg?style=for-the-badge&logo=scikit-learn&logoColor=white)
![Pandas](https://img.shields.io/badge/pandas-%23150458.svg?style=for-the-badge&logo=pandas&logoColor=white)

## 📖 Overview

This project addresses the challenge of rising healthcare costs by building a robust linear regression model to predict individual medical expenses. The primary objective is to identify and interpret the key demographic and personal factors that significantly influence insurance charges, such as age, BMI, and smoking habits.

## 📊 Dataset

The analysis is based on the "Medical Cost Personal Datasets" available on Kaggle.

* **Source:** Kaggle
* **Observations:** 1,338 entries
* **Predictor Variables:** `age`, `sex`, `bmi`, `children`, `smoker`, `region`
* **Response Variable:** `charges` (medical costs billed by insurance)

## ⚙️ Project Workflow

A comprehensive statistical modeling workflow was followed to ensure robust and reliable results:

1.  **Data Pre-processing:** The initial dataset of 1,338 observations was cleaned by identifying and removing outliers from the `charges` and `bmi` variables, resulting in a refined dataset of 1,116 observations for modeling.
2.  **Exploratory Data Analysis (EDA):** A correlation matrix and pair plots were used to understand the initial relationships between variables.
3.  **Model Development & Selection:** Three distinct linear regression models were developed, including a baseline model, a model with a custom interaction term (`smoker` & obesity), and a log-transformed model.
4.  **Model Selection:** **Model 2**, which included the interaction term, was selected as the best model due to its highest **Adjusted R-Squared of 0.8625**.
5.  **Rigorous Assumption Checking:** The final model was thoroughly validated against all key linear regression assumptions (Normality of Residuals, Linearity, Homoscedasticity, and Multicollinearity) using both visual diagnostics and formal statistical tests (Kolmogorov-Smirnov, Breusch-Pagan, VIF), all of which were successfully met.

## 📈 Final Model & Interpretation

The selected final model provides powerful insights into the factors driving medical costs.

> **Key Finding:** The model explains **86.25%** of the variance in insurance charges, indicating a very strong fit.

#### Final Model Equation:
$charges = -4967.3 + 263.7 \times age + 114.1 \times bmi + 516.8 \times children + 13383.2 \times smoker_{yes} - 869.8 \times bmi_{30} - 264.1 \times region_{northwest} - 823.4 \times region_{southeast} - 1221.1 \times region_{southwest} + 19744.7 \times (smoker_{yes} \times bmi_{30})$

#### Interpretation of Key Factors:
* **Smoking:** Being a smoker is a dominant factor, significantly increasing insurance charges.
* **Age & BMI:** Costs increase with `age` and `bmi`.
* **Crucial Interaction Effect:** The model reveals that being a smoker who is also obese (`smoker_yes` & `bmi30`) dramatically increases medical costs, far more than the individual effects combined.
* **Most Influential Predictor:** After analyzing correlations and VIF scores, `age` was determined to be the most influential standalone predictor variable.
