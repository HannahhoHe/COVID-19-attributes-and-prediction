library(caret)
library(ggplot2)
library(lattice)
library(ROCR)
library(mlr)
library(ROCit)
library(leaps) 
library(glmnet) 
library(dplyr)
library(plotmo)



lasso.mod = glmnet(x.train, y.train, alpha = 1, standardize = TRUE, family = "binomial")
pdf("plt_glmnet.pdf")
plot_glmnet(lasso.mod, label = TRUE, col=1:8)
dev.off()

# Select best variables
x.train <- x.train[, c(15, 21, 3,  4, 7)]
set.seed(1)
cv.out = cv.glmnet(x.train, y.train, alpha = 1, family = "binomial", standardize = TRUE, 
                   type.measure = "class")
pdf("CV.pdf")
plot(cv.out)
dev.off()
lasso.pred = predict(lasso.mod, s = bestlam, newx = x[-train, ], family = "binomial", 
                     standardize = TRUE, type = "class")
lasso.pred.prob = predict(lasso.mod, s = bestlam, newx = x[-train, ], family = "binomial", 
                          standardize = TRUE, type = "response")
confusion.table <- table(true = y[-train], 
                         pred = lasso.pred)
L.all <- measure(confusion.table)                                            
df.prob <- df.pred.prob()
L.all.prob.ROCit_obj <- rocit(score = df.prob$pred, class = df.prob$truth)  
pdf("ROC.pdf")
plot(L.all.prob.ROCit_obj)
dev.off()
L.all.auc = L.all.prob.ROCit_obj$AUC
lasso.parameters <- cbind(L.all, bestlam, L.all.auc)
write.csv(lasso.parameters, file = "lasso.parameter.csv")
