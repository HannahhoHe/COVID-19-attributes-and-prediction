### hot-code the original samples
x1 <- model.matrix(covid_case.~., data.cat)[,-1]
x.b <- ifelse(data.cat$majority_race == "Black", 1, 0)
x.stay <- ifelse(data.cat$date_stay_at_home_effective == "early", 1, 0)
x <- cbind(x1, "majority_raceBlack"=x.b, "date_stay_at_home_effectiveearly"  = x.stay)
y <- data.cat$covid_case.
data.cat.xy <- data.frame(y, x)


### hot-code the upsampling training
x1 <- model.matrix(covid_case.~., data.cat.train.up)[,-1]
x.b <- ifelse(data.cat.train.up$majority_race == "Black", 1, 0)
x.stay <- ifelse(data.cat.train.up$date_stay_at_home_effective == "early", 1, 0)
x.train <- cbind(x1, "majority_raceBlack"=x.b, "date_stay_at_home_effectiveearly"  = x.stay)
y.train <- data.cat.train.up$covid_case.
data.cat.train.up.xy <- data.frame(y.train, x.train)