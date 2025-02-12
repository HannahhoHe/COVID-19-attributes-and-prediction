# SVM 
The dataset used for SVM was integer coded, and the scaling was performed by 
the default setting. The input data was the same as the RF model, except for the training 
dataset, only the oversampled data was used. In the following, I will only show the SVM 
with a radial basis function kernel since it outperformed both linear and polynomial kernels 
in this dataset (data not shown). The tuning of SVM parameters, i.e.,
cost and gamma, will incorporate a grid search and a 10-fold cross-validation. With each, the optimal cost 
will be sought in a range of values, 50, 100, 150, 250, and 500, and the optimal gamma 
in a range of values, 0.0001, 0.001, 0.005, and 0.05. In the initial step, all the 15 variable 
features in the training dataset were included. The return showed that the best cost value 
was at 500 and gamma at 0.05, which resulted in the best performance at 0.0518. I then 
tuned these parameters again with different sets of features, resulting from RFE (9 
features), from RF (5 features), and from LASSO (3 features). To my surprise, I did not 
observe any change in the values of the best cost and gamma, along with the different 
sets of variable features, although the best performance worsened gradually with less 
and less variables, to 0.054, 0.146 and 0.237, respectively. A plot figure displays a 
representative fitting of the SVM model with these two parameters, using feature vectors 
of “daily temperatures” and “population”, which demonstrated an acceptable performance in separating the two classes, 
in both training and test datasets. In the next paragraph, I will apply the models with the same cost (= 500) and gamma (= 0.05) and assess the 
predictive metrics arising from different feature sets.    

The resulting SVM modeling achieved the predictive accuracy in 71% - 85.6%. 
While less and less numbers of variables used in the model tends to decrease the 
predictive accuracy, surprisingly, the use of only 3 variables from LASSO, “party 
preference”, “race”, and “gender”, was able to reach a relatively high accuracy again 
(81.75 %). The recall rate seemed to respond to the set of features in a reverse pattern. 
The highest recall in SVM modeling was found at 62.6% when using the 5 features 
selected from the RF model, where they also contributed to the lowest accuracy (71%), 
and the worst precision (18%). The lowest recall is when all the variables were used (35%) 
and where a highest accuracy was reached (85.6%). The value of F1 in the SVM models 
seemed relatively stable at ~0.30, which showed less sensitivity to the different feature 
sets. In the ROC curves, using the 3 features from LASSO was able to give the best AUC 
value (0.79) while all others remained at a similar value (0.7-0.73).
