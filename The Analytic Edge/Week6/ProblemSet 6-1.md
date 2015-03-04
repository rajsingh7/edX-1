Problem Set 6-1
========================================================
DOCUMENT CLUSTERING WITH DAILY KOS

Document clustering, or text clustering, is a very popular application of clustering algorithms. A web search engine, like Google, often returns thousands of results for a simple query. For example, if you type the search term "jaguar" into Google, 406 million results are returned. This makes it very difficult to browse or find relevant information, especially if the search term has multiple meanings. If we search for "jaguar", we might be looking for information about the animal, the car, or the Jacksonville Jaguars football team. 

Clustering methods can be used to automatically group search results into categories, making it easier to find relavent results. This method is used in the search engines PolyMeta and Helioid, as well as on FirstGov.gov, the official Web portal for the U.S. government. The two most common algorithms used for document clustering are Hierarchical and k-means. 

In this problem, we'll be clustering articles published on Daily Kos, an American political blog that publishes news and opinion articles written from a progressive point of view. Daily Kos was founded by Markos Moulitsas in 2002, and as of 2010, the site had an average weekday traffic of hundreds of thousands of visits. 

The file dailykos.csv contains data on 3,430 news articles or blogs that have been posted on Daily Kos. These articles were posted in 2004, leading up to the United States Presidential Election. The leading candidates were incumbent President George W. Bush (republican) and John Kerry (democratic). Foreign policy was a dominant topic of the election, specifically, the 2003 invasion of Iraq. 

The variable "Document" gives an identifying number to each document. Each of the other variables in the dataset is a word that has appeared in at least 50 different articles (1,545 words in total). The set of  words has been trimmed according to the techniques covered in the previous week on text analytics (punctuation has been removed, stop words have been removed, and the words have been stemmed). For each document, the variable values are the number of times that word appeared in the document. 

 

####PROBLEM 1.1 - HIERARCHICAL CLUSTERING  (1 point possible)
Let's start by building a hierarchical clustering model. First, read the data set into R. Then, compute the distances (using method="euclidean"), and use hclust to build the model (using method="ward"). You should cluster on all of the variables EXCEPT the "Document" variable (see the Netflix lecture to remember how to exclude the first variable in the dataset from clustering).

```r
dailykos = read.csv("dailykos.csv")

kosDist = dist(dailykos[2:1546], method = "euclidean")

kosHierClust = hclust(kosDist, method = "ward")
```


Running the dist function will probably take you a while. Why? Select all that apply.

We have a lot of observations, so it takes a long time to compute the distance between each pair of observations. 
We have a lot of variables, so the distance computation is long. 

####PROBLEM 1.2 - HIERARCHICAL CLUSTERING  (1 point possible)
Plot the dendrogram of your hierarchical clustering model. Just looking at the dendrogram, which of the following seem like good choices for the number of clusters?

```r
plot(kosHierClust)
```

![plot of chunk unnamed-chunk-2](figure/unnamed-chunk-2.png) 


2 , 3

####PROBLEM 1.3 - HIERARCHICAL CLUSTERING  (1 point possible)
In this problem, we are trying to cluster news articles or blog posts into groups. This can be used to show readers categories to choose from when trying to decide what to read. Just thinking about this application, what are good choices for the number of clusters?

7 8
   
####PROBLEM 1.4 - HIERARCHICAL CLUSTERING  (3 points possible)
Let's pick 7 clusters. This number is reasonable according to the dendrogram, and also seems reasonable for the application. Use the cutree function to split your data into 7 clusters.

```r
hierGroups = cutree(kosHierClust, k = 7)
```


Now, we don't really want to run tapply on every single variable when we have over 1,000 different variables. Let's instead use the subset function to subset our data by cluster. Create 7 new datasets, each containing the observations from one of the clusters.

```r
HierCluster1 = subset(dailykos, hierGroups == 1)

HierCluster2 = subset(dailykos, hierGroups == 2)

HierCluster3 = subset(dailykos, hierGroups == 3)

HierCluster4 = subset(dailykos, hierGroups == 4)

HierCluster5 = subset(dailykos, hierGroups == 5)

HierCluster6 = subset(dailykos, hierGroups == 6)

HierCluster7 = subset(dailykos, hierGroups == 7)
```


How many observations are in cluster 3?
 
Which cluster has the most observations?

Which cluster has the fewest observations?


```r
table(hierGroups)
```

```
## hierGroups
##    1    2    3    4    5    6    7 
## 1266  321  374  139  407  714  209
```


####PROBLEM 1.5 - HIERARCHICAL CLUSTERING  (1 point possible)
Instead of looking at the average value in each variable individually, we'll just look at the top 6 words in each cluster. To do this for cluster 1, type the following in your R console (where "HierCluster1" should be replaced with the name of your first cluster subset):



```r
tail(sort(colMeans(HierCluster1[-1])))
```

```
##      state republican       poll   democrat      kerry       bush 
##     0.7575     0.7591     0.9036     0.9194     1.0624     1.7054
```


This computes the mean frequency values of each of the words in cluster 1, and then outputs the 6 words that occur the most frequently. The [-1] removes the first column of HierCluster1, the colMeans function computes the column (word) means, the sort function orders the words in increasing order of the mean values, and the tail function outputs the last 6 words listed, which are the ones with the largest column means.

What is the most frequent word in this cluster, in terms of average value? Enter the word exactly how you see it in the output:

bush

####PROBLEM 1.6 - HIERARCHICAL CLUSTERING  (3 points possible)
Now repeat the command given in the previous problem for each of the other clusters, and answer the following questions.

Which words best describe cluster 2?


```r
tail(sort(colMeans(HierCluster2[-1])))
```

```
##      bush  democrat challenge      vote      poll  november 
##     2.847     2.850     4.097     4.399     4.847    10.340
```


Which cluster could best be described as the cluster related to the Iraq war?


```r
tail(sort(colMeans(HierCluster5[-1])))
```

```
##       american       presided administration            war           iraq 
##          1.091          1.120          1.231          1.776          2.428 
##           bush 
##          3.941
```


In 2004, one of the candidates for the Democratic nomination for the President of the United States was Howard Dean, John Kerry was the candidate who won the democratic nomination, and John Edwards with the running mate of John Kerry (the Vice President nominee). Given this information, which cluster best corresponds to the democratic party?


```r
tail(sort(colMeans(HierCluster7[-1])))
```

```
## democrat    clark   edward     poll    kerry     dean 
##    2.148    2.498    2.608    2.766    3.952    5.804
```


####PROBLEM 2.1 - K-MEANS CLUSTERING  (3 points possible)
Now, run k-means clustering, setting the seed to 1000 right before you run the kmeans function. Again, pick the number of clusters equal to 7. You don't need to add the iters.max argument. Don't forget to exclude the "Document" variable from your clustering.

```r
k = 7
set.seed(1000)
KMC = kmeans(dailykos[2:1546], centers = k)
```


Subset your data into the 7 clusters (7 new datasets) by using the "cluster" variable of your kmeans output.

```r
cluster1 <- subset(dailykos, KMC$cluster == 1)
cluster2 <- subset(dailykos, KMC$cluster == 2)
cluster3 <- subset(dailykos, KMC$cluster == 3)
cluster4 <- subset(dailykos, KMC$cluster == 4)
cluster5 <- subset(dailykos, KMC$cluster == 5)
cluster6 <- subset(dailykos, KMC$cluster == 6)
cluster7 <- subset(dailykos, KMC$cluster == 7)
table(KMC$cluster)
```

```
## 
##    1    2    3    4    5    6    7 
##  146  144  277 2063  163  329  308
```


How many observations are in Cluster 3?
 
Which cluster has the most observations?

Which cluster has the fewest number of observations?

####PROBLEM 2.2 - K-MEANS CLUSTERING  (2 points possible)
Now, output the six most frequent words in each cluster, like we did in the previous problem, for each of the k-means clusters.

```r
tail(sort(colMeans(cluster1[-1])))
```

```
##          state           iraq          kerry administration       presided 
##          1.610          1.616          1.637          2.664          2.767 
##           bush 
##         11.432
```

```r
tail(sort(colMeans(cluster2[-1])))
```

```
## primaries  democrat    edward     clark     kerry      dean 
##     2.319     2.694     2.799     3.090     4.979     8.278
```

```r
tail(sort(colMeans(cluster3[-1])))
```

```
## administration          iraqi       american           bush            war 
##          1.390          1.610          1.686          2.610          3.025 
##           iraq 
##          4.094
```

```r
tail(sort(colMeans(cluster4[-1])))
```

```
##      elect republican      kerry       poll   democrat       bush 
##     0.6011     0.6175     0.6495     0.7475     0.7891     1.1474
```

```r
tail(sort(colMeans(cluster5[-1])))
```

```
##       race     senate      state    parties republican   democrat 
##      2.485      2.650      3.521      3.620      4.638      6.994
```

```r
tail(sort(colMeans(cluster6[-1])))
```

```
##  democrat      bush challenge      vote      poll  november 
##     2.900     2.960     4.122     4.447     4.872    10.371
```

```r
tail(sort(colMeans(cluster7[-1])))
```

```
## presided    voter campaign     poll     bush    kerry 
##    1.325    1.334    1.383    2.789    5.971    6.481
```


Which k-means cluster best corresponds to the Iraq War?

Which k-means cluster best corresponds to the democratic party? (Remember that we are looking for the names of the key democratic party leaders.)

####PROBLEM 2.3 - K-MEANS CLUSTERING  (1 point possible)
For the rest of this problem, we'll ask you to compare how observations were assigned to clusters in the two different methods. Use the table function to compare the cluster assignment of hierarchical clustering to the cluster assignment of k-means clustering.

```r
table(hierGroups, KMC$cluster)
```

```
##           
## hierGroups    1    2    3    4    5    6    7
##          1    3   11   64 1045   32    0  111
##          2    0    0    0    0    0  320    1
##          3   85   10   42   79  126    8   24
##          4   10    5    0    0    1    0  123
##          5   48    0  171  145    3    1   39
##          6    0    2    0  712    0    0    0
##          7    0  116    0   82    1    0   10
```


Which Hierarchical Cluster best corresponds to K-Means Cluster 2?

####PROBLEM 2.4 - K-MEANS CLUSTERING  (1 point possible)
Which Hierarchical Cluster best corresponds to K-Means Cluster 3?

####PROBLEM 2.5 - K-MEANS CLUSTERING  (1 point possible)
Which Hierarchical Cluster best corresponds to K-Means Cluster 7?

No Hierarchical Cluster contains at least half of the points in K-Means Cluster 7.
   
####PROBLEM 2.6 - K-MEANS CLUSTERING  (1 point possible)
Which Hierarchical Cluster best corresponds to K-Means Cluster 6?
