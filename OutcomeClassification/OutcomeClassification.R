
data.cat <- read.csv("data_bf_categorical_tem_impute_stay_never.txt",stringsAsFactors = TRUE)
cutoff <- quantile(data.cat$covid_case., 0.9)
data.cat$covid_case. <- as.factor(ifelse(data.cat$covid_case. < cutoff, 0, 1))

