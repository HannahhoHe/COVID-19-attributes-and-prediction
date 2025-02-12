# Data exploration by k-means clustering 
Prior to modeling, one quick way to investigate where a subset of variables has a 
combinatorial effect on the COVID-19 infection is to use the k-means clustering algorithm 
to seek any clustering behavior associated with COVID-19 status. The dataset used for 
this exploratory analysis has been integer coded, and the normalization was performed 
using a min-max method only on the continuous variables. The data was not oversampled. 
To start with, a series of k values from 1 to 15 was performed, from which total within
clusters sum of squares arising from different k clusters was plotted. The 
number of k larger than five seemed to result in a smaller error. However, with the 
visualization of the data points separated by different k clusters, k=2 was found to give a 
better clustering performance. Between these two clusters, there is a 
significant higher frequency of “heavily infected”  data points appeared in cluster 1 (p = 0.002**). 
Looking at the counties assigned with different clusters, I further inspected 
individual feature vectors and used the t-test to estimate if the vectors were distributed 
differently. The data showed that in the cluster 1, compared to cluster 2, the counties are 
more populated, people are younger, crime rates are higher, and the locations are warmer, 
contaminated with ozone, and less people drive alone to work. Additional 
data also showed that more counties in the cluster 1 voted for “Hillary Clinton” in the 2016 
presidential election. The implementation of k-means seemed capable of revealing pivotal 
features associated with COVID-19 infection status. However, I would keep all the 15 features and proceed with the 4 other machine-learning models in this article.    
