# LASSO
 In the LASSO model, I used the dataset produced by one-hot encoding. To do 
this, the model.matrix function in R was used. The input data were not rescaled. Instead, 
the standardization in the glmnet package was set to be true. The same split datasets as 
in the RF model were used, and with the training dataset, the same seed for oversampling 
was set to ensure the same subset was selected. 

The value of lambda, i.e., the weight given to the regularization L1 term, is the key 
parameter in the LASSO model. Before tuning the lambda, in the training dataset, I first 
plotted the lambda against different coefficient values taken by the variables. 
The plot showed that the most sustainable variables, the ones that disappeared later 
while holding a substantial coefficient when lambda grew, were the variables of “party 
preference”, “Donald Trump”, “race, Black”, “race, Hispanic”, “race, mix”, and “gender”.
Except for the variable “gender”, the LASSO seemed to be sensitive to the classification 
type of variables. In the case of  the variable “race”, there were multiple important 
attributes, some being positively, and some being negatively affected. In the next step, I 
only used these important features, and with cross-validation, I would choose the best 
lambda to consider. Using K=10, the lowest misclassification error was found at 0.354 
when lambda was 0.005282. Although the error of misclassification seemed 
to be a little high, I evaluated the model performance in the test dataset. 

The predictive accuracy from the LASSO turned out to be 70.8%, significantly lower 
than that of the RF model. The recall rate (i.e. 54%) was nearly double the RF recall.
However, a low precision rate (16%) indicated that the LASSO model 
had a higher false positive value. This also led to a slightly lower value of F1 (i.e. 0.25) 
and of AUC (0.70), compared to the RF corresponding values.       
