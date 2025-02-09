library(e1071)
library(caret)
library(ggplot2)
library(lattice)
library(ROCR)
library(mlr)
library(ROCit)
library(randomForest)
library(dplyr)
library(ggraph)
library(igraph)
library(resample)
library(boot)



# No Upsampling

set.seed(1)
trControl <- trainControl(method = "cv",
                          number = 10,
                          search = "grid")

# search for best mtry
set.seed(1)
tuneGrid <- expand.grid(.mtry = c(1:10))
rf_mtry <- caret::train(covid_case.~., data = data.cat[train, ], 
                        method = "rf", 
                        metric = "Accuracy", 
                        trControl = trControl,
                        tuneGrid = tuneGrid,
                        importance = TRUE,
                        nodesize = 14,
                        ntree = 300)

mtry.best <- rf_mtry$bestTune$mtry
mtry.best.accuracy <-max(rf_mtry$results$Accuracy)
mtry.cv <- c(mtry.best, mtry.best.accuracy)
names(mtry.cv) <- c("mtry.best", "mtry.best.accuracy")

write.csv(mtry.cv, file = "RF.tune.mtry.best.csv")
write.csv(rf_mtry$results, file ="RF.tune.mtry.csv")
write.csv(summary(rf_mtry), file ="RF.tune.mtry.summary.csv")

# search for best ntree
tuneGrid <- expand.grid(.mtry = mtry.best)
store_maxtrees <- list()
for (ntree in c(250, 300, 350, 400, 450, 500, 550, 600, 800, 1000, 2000)) {
  set.seed(1)
  rf_maxtrees <- caret::train(covid_case.~., data = data.cat[train, ], 
                       method = "rf", 
                       metric = "Accuracy",
                       tuneGrid = tuneGrid,
                       trControl = trControl,
                       importance = TRUE,
                       nodesize = 14,
                       maxnodes = 24,
                       ntree = ntree)
  key <- toString(ntree)
  store_maxtrees[[key]] <- rf_maxtrees
}
results_tree <- resamples(store_maxtrees)
write.csv(results_tree, file ="RF.tune.ntree.csv")
summary(results_tree)

# RF Modeling
mtry.best = 7
ntree = 250

set.seed(1)
rf.data.cat <- randomForest(covid_case.~., data = data.cat, subset = train, mtry = mtry.best, importance = TRUE, ntree=ntree) 

confusion.table <- table(true = data.cat[-train, "covid_case."], 
                         pred = predict(rf.data.cat, newdata = data.cat[-train, ]))

rf.measure <- measure(confusion.table) 
write.csv(rf.measure, file ="rf.measure.csv")

df.prob <- df.pred.prob(rf.data.cat, data.cat)
rf.prob.ROCit_obj <- rocit(score = df.prob$pred, class = df.prob$truth)                  
pdf("rf.auc.pdf")
plot(rf.prob.ROCit_obj)
rf.auc = rf.prob.ROCit_obj$AUC
dev.off()

importance(rf.data.cat)
pdf("rf.varImpPlot.pdf")
varImpPlot(rf.data.cat, n.var=min(10, nrow(rf.data.cat$importance)), 
           scale = FALSE, type = 1)
dev.off()

pdf("rf.varImpPlotGini.pdf")
varImpPlot(rf.data.cat, n.var=min(10, nrow(rf.data.cat$importance)), 
           scale = FALSE, type = 2)
dev.off()








# With Upsampling
set.seed(1)
trControl <- trainControl(method = "cv",
                          number = 10,
                          search = "grid")

# search for best mtry
set.seed(1)
tuneGrid <- expand.grid(.mtry = c(1:10))
rf_mtry <- caret::train(covid_case.~., data = data.cat.train.up, 
                        method = "rf", 
                        metric = "Accuracy", 
                        trControl = trControl,
                        tuneGrid = tuneGrid,
                        importance = TRUE,
                        nodesize = 14,
                        ntree = 300)

mtry.best <- rf_mtry$bestTune$mtry
mtry.best.accuracy <-max(rf_mtry$results$Accuracy)
mtry.cv <- c(mtry.best, mtry.best.accuracy)
names(mtry.cv) <- c("mtry.best.ups", "mtry.best.accuracy")

rf_mtry$resample
rf_mtry$results

write.csv(mtry.cv, file = "RF.tune.mtry.best.upsample.csv")
write.csv(rf_mtry$results, file ="RF.tune.mtry.upsample.csv")
write.csv(summary(rf_mtry), file ="RF.tune.mtry.summary.upsample.csv")

# search for best ntree
tuneGrid <- expand.grid(.mtry = mtry.best)
store_maxtrees <- list()
for (ntree in c(250, 300, 350, 400, 450, 500, 550, 600, 800, 1000, 2000)) {
  set.seed(1)
  rf_maxtrees <- caret::train(covid_case.~., data = data.cat.train.up, 
                              method = "rf", 
                              metric = "Accuracy",
                              tuneGrid = tuneGrid,
                              trControl = trControl,
                              importance = TRUE,
                              nodesize = 14,
                              maxnodes = 24,
                              ntree = ntree)
  key <- toString(ntree)
  store_maxtrees[[key]] <- rf_maxtrees
}
results_tree <- resamples(store_maxtrees)
write.csv(results_tree, file ="RF.tune.ntree.upsample.csv")
summary(results_tree)

# RF Modeling
mtry.best = 4
ntree = 450

set.seed(1)
rf.data.cat <- randomForest(covid_case.~., data = data.cat.train.up, mtry = mtry.best, importance = TRUE, ntree=ntree) 

confusion.table <- table(true = data.cat[-train, "covid_case."], 
                         pred = predict(rf.data.cat, newdata = data.cat[-train, ]))

rf.measure <- measure(confusion.table) 
write.csv(rf.measure, file ="rf.measure.upsampling.csv")

df.prob <- df.pred.prob(rf.data.cat, data.cat)
rf.prob.ROCit_obj <- rocit(score = df.prob$pred, class = df.prob$truth)                  
pdf("rf.auc.upsampling.pdf")
plot(rf.prob.ROCit_obj)
rf.upsampling.auc = rf.prob.ROCit_obj$AUC
auc <- (c("rf" = rf.auc, "rf.upsampling" = rf.upsampling.auc)) #with both auc
write.csv(auc, file ="RF.auc.csv")
dev.off()

importance(rf.data.cat)
pdf("rf.varImpPlot.upsampling.pdf")
varImpPlot(rf.data.cat, n.var=min(10, nrow(rf.data.cat$importance)), 
           scale = FALSE, type = 1)
dev.off()

pdf("rf.varImpPlotGini.upsampling.pdf")
varImpPlot(rf.data.cat, n.var=min(10, nrow(rf.data.cat$importance)), 
           scale = FALSE, type = 2)
dev.off()