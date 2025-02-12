
# Random Forest

The dataset previously generated by integer coding for classification variables, and 
with no re-scaling for continuous variables, will be applied to the random forests model. 
Prior to modeling, the data was split into training dataset and test dataset (1:1), from which 
the former would be used for tuning the hyperparameter and fitting the model, and the 
latter would be used to get the predictive metrics. After splitting the original data, 
oversampling will be performed only on the training dataset, keeping the test dataset 
unchanged (this is done in the Oversampling folder). I will compare the results of predictive metrics from the training dataset before 
and after oversampling.  

Before modeling, I first used grid search for hyperparameter tuning: the tuning of the 
number of trees in the forest, and the number of features to consider per split. Both tuning 
processes were incorporated with a cross-validation method to avoid overfitting (K = 10). 
The tuning started with the numbers of features per split at a range of 1-10, the size of 
node was set at 14, and the number of trees was at 300, such conditions were repeated 
10 times. In the second tuning, I applied the results from the first tuning, and found the 
best number of trees. The optimal tree size was determined to be 450 and 250, and the 
best numbers of features in each split was at 7 and 4, for the training data with and without 
oversampling, respectively. A low rate of error was achieved in both sets (<0.015). The 
resultant two sets of values would be used by the corresponding training datasets for the 
RF model runs. 

After training, the RF models were fed with the test dataset to predict which class of 
the scenario of COVID-19 each county would fall into. Here, I assessed the performance 
of the model on the test dataset with the following metrics – accuracy, precision, recall, 
and F1 scores. The predicting probability of classes in each test subject was used to 
obtain ROC curve and AUC values. 

The results showed that a high accuracy was achieved at 91% which matched with 
the RFE runs. However, the predicting power to identify the minority class, i.e., the heavily 
infected county, is weak. Using the original imbalanced training dataset, recall and F1  on 
the test dataset were determined only 0.16 and 0.26, respectively. With oversampling, I 
observed a substantial improvement of recall and F1, which became 0.26 and 0.34, nearly 
1.5 times higher. There is only a subtle enhancement for precision by oversampling, 
which changed from 0.58 to 0.62. Regardless of these low values, the ROC curves using both types of 
training datasets showed the curves far above the reference line, projecting 
into the upper left half of the graph, with an AUC value at 0.77 - 0.78. Since 
the training dataset with oversampling seemed capable of providing with a more reliable 
recall and F1, in the other models, I will only use the training dataset that had  oversampling.   

The exclusion of variables “senior population”, “air-ozone pollution”, and “household 
income”, abruptly decreased the predictive accuracy, followed by the variables of 
“population” and “daily temperature”. This was observed using the
oversampled training dataset, which were found ~10 times more sensitive compared to 
that from the original training dataset. The Gini coefficient of “senior population” is distinct 
and indicates it is one of the most important variables in keeping the node purity. 
