
library(DMwR)

data <- read.csv("data_bf_categorical.txt",stringsAsFactors = TRUE)

d <- data[c(3, 4, 17)]
d_impute <- knnImputation(d, k = 6, scale = T, meth = "weighAvg", distData = NULL)
write.csv(d_impute, file = "mean_temp_impute.csv")

