

measure <- function(confusion.table){
  TP <- confusion.table[2, 2]
  TN <- confusion.table[1, 1]
  FP <- confusion.table[1, 2]
  FN <- confusion.table[2, 1]
  accuracy <- (TP + TN)/(TP + TN + FP + FN)
  precision <- TP/(TP + FP)
  recall <- TP/(TP + FN)
  F1 = 2*precision*recall/(precision + recall)
  measure.df <- cbind(accuracy, precision, recall, F1)
  return(measure.df)
}



df.pred.prob <- function(model, data){
  fitted.prob <- as.data.frame(attr(predict(model, newdata = data[-train, ], 
                                            probability = TRUE), "probabilities")[, 2])
  truth <- as.data.frame(data[-train, "covid_case."])
  df <- data.frame(truth, fitted.prob)
  colnames(df) <- c("truth", "pred.prob")
  return(df)
}
