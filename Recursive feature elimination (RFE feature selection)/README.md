# RFE Feature Selection

The RFE will provide the best informative set of variables, based 
on the subset that would result in the highest accuracy of prediction. To test this model, I 
used the dataset produced by integer coding, with no scaling and oversampling. All the 
15 attributes will be used to generate a subset of variables. A 10-fold cross validation will 
be incorporated to estimate the performance accuracy. Since the model uses the random 
forest function, I will run 3 iterations of RFE, from which I will select the features that 
consistently appear. As a result, in all the 3 runs, RFE were able to achieve a high 
accuracy of prediction (≥ 91%), where the optimal sizes of variables were 9, 11, and 11. 
Among the sets, the most robust 9 attributes are “daily temperatures”, 
“population”, “air-ozone pollution”, “household income”, “atmospheric PM2.5”, “senior 
population”, “race”, “smoking rates”, “effective time of stay-at-home orders”. The other 2 
attributes which only appeared in the latter two runs were both “party preference” and 
“crime rates”. From using the RFE, I managed to keep the 9 most robust variables and 
drop the other 6 variables. This set will be referred to as “RFE set” in the later paragraphs. 
