# QDA
The dataset transformed by one-hot encoding was used for QDA modeling. No re-scaling
of the dataset was necessary. QDA is a dimensionality reduction algorithm where 
no parameters would need to be tuned. Since QDA is incapable of handling multiple 
variables which unfortunately grows after one-hot encoding. In this model, I only tested 
two small sets of features, one from the RF selection, and the other from the LASSO 
selection. After training, the data was found to have a high error rate (0.31-0.35), 
indicating that QDA might not be a good model for this study. 

The results of the QDA modeling showed that, compared to the features selected from 
the RF, those features from the LASSO modeling were able to achieve a much higher 
predictive accuracy (79.6%). Meanwhile, the same feature set had a better 
recall rate, F1 value, and the AUC value under the ROC curve. However, features from 
the RF selection had a more reliable precision rate (72.5%) than the LASSO set (47%), 
indicating a relative higher false positive was detected in the latter. 
