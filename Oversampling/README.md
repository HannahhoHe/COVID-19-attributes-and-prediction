# Oversampling for the Training dataset
The dataset turned out to be very imbalanced between the mildly and 
heavily infected classes (9:1), which could severely skew the classification distribution 
and raise a bias in the training algorithm, leading to a low recall rate for the latter. To 
address this problem, a random resampling was performed in the heavily infected group 
and rebalanced the number of two classes in the training dataset.
