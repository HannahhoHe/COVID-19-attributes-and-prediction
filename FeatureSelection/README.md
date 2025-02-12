# Feature Selection 
Two of the models, RF and LASSO, are able to learn which features 
can best contribute to the predicting accuracy while the model is being built. In other 
words, they do not require prior feature selection. Instead, I will run the best features 
resulting from these two models to the other models, SVM and QDA. To minimize the 
possibility that certain features may cause noise and affect the predicting power, I further 
introduce another feature selection algorithm, called recursive feature elimination (RFE), 
basically a backward selection but based on a random forest function, and create an 
additional set of features. To avoid overfitting, a cross-validation method will be used 
during the RFE modeling. In summary, there are expected to be three different sets of 
features, one from RF, one from LASSO, and one from RFE. In the SVMs, all the three 
sets will be used for comparison. In the QDA model, features from RF and from LASSO 
will be used. The process of RFE will be described in the section of machine-learning 
modeling.      
