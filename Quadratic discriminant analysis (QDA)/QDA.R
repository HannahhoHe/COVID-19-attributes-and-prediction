library(MASS)
library(e1071)
library(caret)
library(ggplot2)
library(lattice)
library(ROCR)
library(mlr)
library(ROCit)
library(useful)
library(tidyverse)
library(klaR)
library(raster) 
library('plot.matrix')



# Use variables selected from RF
f.rfs.11 <- paste(names(data.cat.train.up.xy)[1], "~", paste(names(data.cat.train.up.xy)[c(21, 2, 14, 10, 3)], collapse=" + "))
qda.fit.rfs.11 <- qda(as.formula(paste(f.rfs.11)), data = data.cat.train.up.xy)
qda.rfs.11.pred <- predict(qda.fit.rfs.11, data.cat.xy[-train, ])
qda.rfs.11.class <- predict(qda.fit.rfs.11, data.cat.xy[-train, ])$class
rf5.train.error <- predict(qda.fit.rfs.11, data.cat.train.up.xy)$class
mean(rf5.train.error!=data.cat.train.up.xy$y.train) 
# test dataset
confusion.table <- table(qda.rfs.11.class, data.cat.xy[-train, ]$y)
qda.rfs.11 <- measure(confusion.table)
df.prob <- df.pred.prob(qda.rfs.11.pred)
qda.rfs.11.prob.ROCit_obj <- rocit(score = df.prob$pred, class = df.prob$truth)                  
plot(qda.rfs.11.prob.ROCit_obj)
qda.rfs.11.auc = qda.rfs.11.prob.ROCit_obj$AUC


# Use variables selected from. LASSO
f.lasso.5 <- paste(names(data.cat.train.up.xy)[1], "~", paste(names(data.cat.train.up.xy)[c(8, 16, 22, 4, 5)], collapse=" + "))
qda.fit.lasso.5 <- qda(as.formula(paste(f.lasso.5)), data = data.cat.train.up.xy)
qda.fit.lasso.5.pred <- predict(qda.fit.lasso.5, data.cat.xy[-train, ])
qda.fit.lasso.5.class <- predict(qda.fit.lasso.5, data.cat.xy[-train, ])$class
qda.fit.lasso.5.train.error <- predict(qda.fit.lasso.5, data.cat.train.up.xy)$class
mean(qda.fit.lasso.5.train.error!=data.cat.train.up.xy$y.train) 
# test dataset
confusion.table <- table(qda.fit.lasso.5.class, data.cat.xy[-train, ]$y)
qda.lasso.5 <- measure(confusion.table)
df.prob <- df.pred.prob(qda.fit.lasso.5.pred)
qda.lasso.5.prob.ROCit_obj <- rocit(score = df.prob$pred, class = df.prob$truth)                  
plot(qda.lasso.5.prob.ROCit_obj)
qda.lasso.5.auc = qda.lasso.5.prob.ROCit_obj$AUC






# Combine results together
measure.sum <- rbind("RF_conti" = qda.rfs.11, "LASSO" = qda.lasso.5)
rownames(measure.sum) <- c("RF_continuous features", "LASSO feautres")
write.csv(measure.sum, file = "qda.measure.sum.csv")
pdf("qda.measures.pdf")
par(mfrow = c(2, 2))
barplot(measure.sum[, 1], ylab = "accuracy")
barplot(measure.sum[, 2], ylab = "precision")
barplot(measure.sum[, 3], ylab = "recall")
barplot(measure.sum[, 4], ylab = "F1")
dev.off()
# ROC & AUC 
auc <- rbind("qda.rfs.11.auc" = qda.rfs.11.auc, "qda.lasso.5.auc" = qda.lasso.5.auc)
colnames(auc) <- "auc"
write.csv(auc, file = "qda.auc.csv")
pdf("qda.ROC.pdf")
par(mfrow = c(3, 2))
plot(qda.rfs.11.prob.ROCit_obj, main = "qda.rfs.11.prob.ROCit_obj")
plot(qda.lasso.5.prob.ROCit_obj, main = "qda.lasso.5.prob.ROCit_obj")
dev.off()
