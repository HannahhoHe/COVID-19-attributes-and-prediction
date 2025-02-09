

#split train, test
set.seed(1)
train <- sample(nrow(data.cat), nrow(data.cat)/2)
data.cat.train <-data.cat[train, ] 


#### upsample the miority class 
data.cat.train.0 <- data.cat.train[data.cat.train$covid_case.==0, ]
data.cat.train.1 <- data.cat.train[data.cat.train$covid_case.==1, ]
set.seed(5)
unit.sample <- sample(nrow(data.cat.train.1), nrow(data.cat.train.0), replace = TRUE)
data.cat.train.1.upsample <- data.cat.train.1[unit.sample, ]
d.train <- rbind(data.cat.train.0, data.cat.train.1.upsample)
data.cat.train.up <-d.train
