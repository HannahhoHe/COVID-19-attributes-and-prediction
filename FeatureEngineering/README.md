# Feature Engineering

In the dataset, there are three variables that are text data, “race”, 
“party preference”, and “effective time of “stay-at-home orders”, that would need to be 
transformed to number variables. Among those, “party preference” has two different texts, 
“Hillary Clinton” and “Donald Trump”, which were then be replaced with one binary 
variable (0, 1), or with two binary vector variables. The text column of “race”, containing 
5 different words, “mix”, “Hispanic”, “Native”, “Black”, and “White”, will be transformed to 
the integers of (0, 1, 2, 3, 4), or, using one-hot encoding, to the 5 binary vectors 
corresponding to the race features. The last variable “stay-at-home orders” has total 17 
different dates, which will require conversion to meaningful class variables. Here, I re
defined any date in March as “early”, April as “late”, and kept the word “never”. This 3
class variable then applied to either integer coding as (0, 1, 2) or one-hot encoding and 
created 3 binary variables.  

Besides classification variables, most of the machine-learning models will require 
regression variables to be standardized, especially when they are measured in different 
units and in different ranges, which could lead to the model prioritizing a particular feature. 
In the dataset, 12 regression variables differ by orders of magnitude, for example, the 
variable “population” ranges from 103 to 107, and the variable “gender” ratio is in the range 
of 0.2 and 1.4. Application of standardization will be necessary for these variables. In this 
study, the Z-score normalization is used to re-scale all the 12 features. After re-scaling, 
all the vector distributions will have a mean value at 0, and standard deviation at 1. For 
this study, I demonstrated 4 different machine-learning models, RF, SVM, LASSO, and 
QDA. Among these models, the LASSO and SVM packages can perform the scaling by 
default settings without extra coding. As for RF model and QDA, re-scaling is not 
necessary; the models are invariant to a different scale.  


- One-Hot Encoding: Use the "One-Hot Encdoing".R
- Integer coding: In the "DataCleaning", un-commend the bottom line(s) in the corrsponding variables.        
