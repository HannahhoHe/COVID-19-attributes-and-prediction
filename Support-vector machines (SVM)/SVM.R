library(e1071)
library(caret)
library(ggplot2)
library(lattice)
library(ROCR)
library(mlr)
library(ROCit)




# Use all 15 variables
tune.out <- tune(svm, covid_case.~., data = data.cat.train.up, kernel = "radial", scale = TRUE, 
                 ranges = list(cost = c(500, 250, 150, 100, 50), gamma = c(0.05, 0.005, 0.001, 0.0001),
                               probability = TRUE))

confusion.table <- table(true = data.cat[-train, "covid_case."], 
                         pred = predict(tune.out$best.model, newdata = data.cat[-train, ]))

r.all.tune <- measure(confusion.table)                                            
r.all.par.tune <- tune.out$best.parameters
r.all.par <- c(tune.out$best.parameters$cost, tune.out$best.parameters$gamma)

df.prob <- df.pred.prob(tune.out$best.model, data.cat)
r.all.prob.ROCit_obj <- rocit(score = df.prob$pred, class = df.prob$truth)                  
plot(r.all.prob.ROCit_obj)

r.all.prob.ROCit_obj$AUC
tune.out$best.performance




# Use 9 variables from RFE
data.cat.train.up.9 <- data.cat.train.up[, c(1, 16, 2, 11, 7, 12, 3, 4, 9, 15)]
tune.out <- tune(svm, covid_case.~., data = data.cat.train.up.9, kernel = "radial", scale = TRUE, 
                 ranges = list(cost = c(500, 250, 150, 100, 50), gamma = c(0.05, 0.005, 0.001, 0.0001),
                               probability = TRUE))

confusion.table <- table(true = data.cat[-train, "covid_case."], 
                         pred = predict(tune.out$best.model, newdata = data.cat[-train, ]))

r.9.tune <- measure(confusion.table)                                            
r.9.par.tune <- tune.out$best.parameters
r.9.par <- c(tune.out$best.parameters$cost, tune.out$best.parameters$gamma)

df.prob.9 <- df.pred.prob(tune.out$best.model, data.cat)
r.9.prob.ROCit_obj <- rocit(score = df.prob.9$pred, class = df.prob.9$truth)                  
plot(r.9.prob.ROCit_obj)

r.9.prob.ROCit_obj$AUC
tune.out$best.performance




# Use 5 variables from RF 
data.cat.train.up.5 <- data.cat.train.up[, c(1, 3, 11, 7, 2, 16 )]
tune.out <- tune(svm, covid_case.~., data = data.cat.train.up.5, kernel = "radial", scale = TRUE, 
                 ranges = list(cost = c(500, 250, 150, 100, 50), gamma = c(0.05, 0.005, 0.001, 0.0001),
                               probability = TRUE))

confusion.table <- table(true = data.cat[-train, "covid_case."], 
                         pred = predict(tune.out$best.model, newdata = data.cat[-train, ]))

r.5.tune <- measure(confusion.table)                                            
r.5.par.tune <- tune.out$best.parameters
r.5.par <- c(tune.out$best.parameters$cost, tune.out$best.parameters$gamma)

df.prob.5 <- df.pred.prob(tune.out$best.model, data.cat)
r.5.prob.ROCit_obj <- rocit(score = df.prob.5$pred, class = df.prob.5$truth)                  
plot(r.5.prob.ROCit_obj)

r.5.prob.ROCit_obj$AUC
tune.out$best.performance




# Use 3 variables from LASSO 
data.cat.train.up.3 <- data.cat.train.up[, c(1, 5, 13, 4)]
tune.out <- tune(svm, covid_case.~., data = data.cat.train.up.3, kernel = "radial", scale = TRUE, 
                 ranges = list(cost = c(500, 250, 150, 100, 50), gamma = c(0.05, 0.005, 0.001, 0.0001),
                               probability = TRUE))

confusion.table <- table(true = data.cat[-train, "covid_case."], 
                         pred = predict(tune.out$best.model, newdata = data.cat[-train, ]))

r.3.tune <- measure(confusion.table)                                            
r.3.par.tune <- tune.out$best.parameters
r.3.par <- c(tune.out$best.parameters$cost, tune.out$best.parameters$gamma)

df.prob.3 <- df.pred.prob(tune.out$best.model, data.cat)
r.3.prob.ROCit_obj <- rocit(score = df.prob.3$pred, class = df.prob.3$truth)                  
plot(r.3.prob.ROCit_obj)

r.3.prob.ROCit_obj$AUC
tune.out$best.performance








# Combine all above results together
measure.sum <- rbind("Radial.all" = r.all.tune, "RFE" = r.9.tune,
                     "RF" = r.5.tune, "LASSO" = r.3.tune)

rownames(measure.sum) <- c("Radial.all", "rfe.9", "rf5", "lasso.3")
write.csv(measure.sum, file = "measure.sum.csv")

parameters.sum <- rbind("Radial.all" = r.all.par, "rfe" = r.9.par,
                     "RF" = r.5.par, "LASSO" = r.3.par)

colnames(parameters.sum) <- c("cost", "gamma")
write.csv(parameters.sum, file = "parameters.sum.csv")

pdf("measures.pdf")
par(mfrow = c(2, 2))
barplot(measure.sum[, 1], ylab = "accuracy")
barplot(measure.sum[, 2], ylab = "precision")
barplot(measure.sum[, 3], ylab = "recall")
barplot(measure.sum[, 4], ylab = "F1")
dev.off()

# tune.values 
par.tune <- rbind("Radial.all" = r.all.par.tune, "rfe" = r.9.par.tune,
             "rf" = r.5.par.tune, "lasso" = r.3.par.tune)

colnames(par.tune) <- "par.tune"
write.csv(par.tune, file = "par.tune.csv")

# AUC
r.all.auc = r.all.prob.ROCit_obj$AUC
r.9.auc = r.9.prob.ROCit_obj$AUC
r.5.auc = r.5.prob.ROCit_obj$AUC
r.3.auc = r.3.prob.ROCit_obj$AUC
auc <- rbind("Radial.all" = r.all.auc, "rfe" = r.9.auc,
     "rf" = r.5.auc, "lasso" = r.3.auc)
colnames(auc) <- "auc"
write.csv(auc, file = "auc.csv")

pdf("ROC.pdf")
par(mfrow = c(3, 2))

plot(r.all.prob.ROCit_obj)
plot(r.9.prob.ROCit_obj, add = T, col = "red")
plot(r.5.prob.ROCit_obj, col="blue")
plot(r.3.prob.ROCit_obj, add = T, col = "yellow")
dev.off()







# 2-dimension representative plot with SVM (radialSVM)
data.cat.tain.up.2 <- data.cat.train.up[c(1, 2, 16)]
svmfit <- svm(covid_case.~., data = data.cat.tain.up.2, probability = TRUE, 
              kernel = "radial", cost = 500, gamma=0.05, scale = TRUE)

pdf("SVM.train.pdf")
plot(svmfit, data.cat.tain.up.2, main = "Radial, 2 variables", las=0)
dev.off()

pdf("SVM.test.pdf")
plot(svmfit, data.cat[-train, ][c(1, 2, 16)], main = "Radial, 2 variables", las=0)
dev.off()

