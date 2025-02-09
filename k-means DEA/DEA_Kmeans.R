library("factoextra")
library(ggplot2)
library(magrittr)
library(dplyr)
library(gridExtra)
library(purrr)
library(plyr)
library(stringr)
library(gmodels)
library(reshape2)
library(tidyverse)
library(lattice)


data <- na.omit(data)
data1 <- data[-c(1, 2, 3, 4, 5 , 21)] 
regression.data1 <- data1[c(2, 3, 5, 6, 7, 8, 9, 10, 11, 12, 14, 16)]
class.data1 <- data1[c(1, 4, 13, 15)]



# normalization
normalize <- function(x){
  return((x - min(x))/(max(x) - min(x)))
}
regression.data_n <- as.data.frame(lapply(regression.data1, normalize))



# k-means start: 
data <- data.frame(regression.data_n, class.data1)






# Evaluate k values 
wss <- function(k) {
  kmeans(data, k, nstart = 10 )$tot.withinss
}

k.values <- 1:15
wss_values <- map_dbl(k.values, wss)
pdf("k-means.pdf")
plot(k.values, wss_values,
     type="b", pch = 19, frame = FALSE, 
     xlab="Number of clusters K",
     ylab="Total within-clusters sum of squares")
dev.off()





# Visually evaluate k values
k2 <- kmeans(data, centers = 2)
k3 <- kmeans(data, centers = 3)
k4 <- kmeans(data, centers = 4)
k5 <- kmeans(data, centers = 5)

pdf("clusters.pdf")
p2 <- fviz_cluster(k2, geom = "point",  data = data) + ggtitle("k = 2")
p3 <- fviz_cluster(k3, geom = "point",  data = data) + ggtitle("k = 3")
p4 <- fviz_cluster(k4, geom = "point",  data = data) + ggtitle("k = 4")
p5 <- fviz_cluster(k5, geom = "point", data = data) + ggtitle("k = 5")
grid.arrange(p2, p3, p4, p5, nrow = 2)
dev.off()




#Below use k=2, list mean values of variables in different clusters and p in t.test   

data.cluster <- data.frame(data, k2$cluster)
cluster1 <- subset(data.cluster, data.cluster$k2.cluster == 1)
cluster2 <- subset(data.cluster, data.cluster$k2.cluster == 2)
cluster1 <- cluster1[-17]
cluster2 <- cluster2[-17]
for (i in names(cluster1)){
  a <- select(cluster1, i)
  b <- select(cluster2, i)
  t <- t.test(a, b)
  print(c(i, mean((t(a))), mean((t(b))) , t$p.value))
}





# Look at data assigned in each cluster
cluster <- as.data.frame(data.cluster$k2.cluster)
data1.cluster <- cbind(data, cluster)

#Show numerical variables between cluster1 and cluster2
data1.cluster[data1.cluster$`data.cluster$k2.cluster` == 1,]$`data.cluster$k2.cluster` = "Cluster1"
data1.cluster[data1.cluster$`data.cluster$k2.cluster` == 2,]$`data.cluster$k2.cluster` = "Cluster2"
names(data1.cluster)[17]<-paste("cluster")

# regression variables look
data1.cluster.groups <- data1.cluster[-c(13, 14, 15, 16)]
data1.cluster.m <- melt(data1.cluster.groups, id.var = "cluster")

pdf("numerical variables between 2 cluster.pdf")
bwplot(value~cluster |variable,     
       data=data1.cluster.m,
       between=list(y=1))
dev.off()
