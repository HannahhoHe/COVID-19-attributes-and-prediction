# COVID-19-Attributes-and-Prediction
COVID-19 Cases in US - 19th May, 2020

# Introduction
The COVID-19 epidemic has rapidly become a national crisis in the US ever since the first case was confirmed in February 2020. Cases and deaths arising from COVID-19, however, differed demographically, psychographically, and geographically. Important factors attributed to such heterogeneity are hard to measure, yet pivotal to the manipulation of the epidemic outbreak. Currently, there have been numerous studies using machine-learning approaches to tackle COVID-19 associated challenges. Among which, most aimed to forecast when or where a daily case or death would reach the peak, some using patient blood to predict end-of-life expectancy. In this article, instead of forecasting, the goal is to elucidate what contributes to such a heterogeneity of COVID-19 cases across the US. The results will provide important keys to manage the ongoing epidemic. Furthermore, some independent variables included in the models are specific, for example, air pollution and smoking may make people susceptible to respiratory disease, and the low rate of commuters driving alone to work may indicate a higher chance of being exposed to the virus when taking a public transportation. This article will treat the COVID-19 issue as a classification problem, since the aim is to pick up counties that are heavily affected and their associated features. As such, the classification performance metrics, i.e., predictive accuracy, precision, recall, F1, and areas under the curve (AUC) value under the ROC curves will be the main assessments.


# Table of Folders
- Database
- DataCleaning
 - DataCleaning
 - Imutation
 - DataCleaning_afterImputation
 
1.	Data source 	……………………………………………………………………………4
2.	Data cleaning 	…………………………………………………………………………..4
3.	Missing data and imputation	………………………………………………………….5
4.	Outcome variable 	………………………………………………………………………6
5.	Oversampling 	………………………………………………………………………….6
6.	Feature engineering 	…………………………………………………………………..6
7.	Feature selection 	………………………………………………………………………7
III. Data exploration by k-means clustering ………………………………	…………………8
IV. Machine-learning modeling
0. Recursive feature elimination (RFE feature selection)………………………	…10
1. Random forests (RF) ………	……………………………………………………...10
2. Least absolute shrinkage and selection operator (LASSO)  ………	………….12
3. Support-vector machines (SVM) ……………………………	…………………...13 
4. Quadratic discriminant analysis (QDA) ……………	……………………………16
V. Conclusion …………………………………………………	………………………………16
