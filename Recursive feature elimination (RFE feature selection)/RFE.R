library(e1071)
library(caret)
library(ggplot2)
library(lattice)
library(ROCR)
library(mlr)
library(ROCit)



control <- rfeControl(functions = rfFuncs, method = "cv", number = 10)
results <- rfe(data.cat[, 2:16], data.cat[, 1], sizes = c(1:15), rfeControl = control) 
res <- as.data.frame(predictors(results))
write.csv(res, file = "rfs.csv")

pdf("rfs.pdf")
plot(results, type = c("g", "o"), main = "Recursive Feature Selection")
dev.off()



