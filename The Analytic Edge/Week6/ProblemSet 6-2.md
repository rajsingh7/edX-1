Problem Set 6-2
========================================================
MARKET SEGMENTATION FOR AIRLINES

Market segmentation is a strategy that divides a broad target market of customers into smaller, more similar groups, and then designs a marketing strategy specifically for each group. Clustering is a common technique for market segmentation since it automatically finds similar groups given a data set. 

In this problem, we'll see how clustering can be used to find similar groups of customers who belong to an airline's frequent flyer program. The airline is trying to learn more about its customers so that it can target different customer segments with different types of mileage offers. 

The file AirlinesCluster.csv contains information on 3,999 members of the frequent flyer program. This data comes from the textbook "Data Mining for Business Intelligence," by Galit Shmueli, Nitin R. Patel, and Peter C. Bruce. For more information, see the website for the book.

There are seven different variables in the dataset, described below:

Balance = number of miles eligible for award travel
QualMiles = number of miles qualifying for TopFlight status
BonusMiles = number of miles earned from non-flight bonus transactions in the past 12 months
BonusTrans = number of non-flight bonus transactions in the past 12 months
FlightMiles = number of flight miles in the past 12 months
FlightTrans = number of flight transactions in the past 12 months
DaysSinceEnroll = number of days since enrolled in the frequent flyer program

####PROBLEM 1.1 - NORMALIZING THE DATA  (2 points possible)
Read the dataset AirlinesCluster.csv into R and call it "airlines".

```r
airlines <- read.csv("AirlinesCluster.csv")
```


Looking at the summary of airlines, which two variables have (on average) the smallest values?

```r
summary(airlines)
```

```
##     Balance          QualMiles       BonusMiles       BonusTrans  
##  Min.   :      0   Min.   :    0   Min.   :     0   Min.   : 0.0  
##  1st Qu.:  18528   1st Qu.:    0   1st Qu.:  1250   1st Qu.: 3.0  
##  Median :  43097   Median :    0   Median :  7171   Median :12.0  
##  Mean   :  73601   Mean   :  144   Mean   : 17145   Mean   :11.6  
##  3rd Qu.:  92404   3rd Qu.:    0   3rd Qu.: 23800   3rd Qu.:17.0  
##  Max.   :1704838   Max.   :11148   Max.   :263685   Max.   :86.0  
##   FlightMiles     FlightTrans    DaysSinceEnroll
##  Min.   :    0   Min.   : 0.00   Min.   :   2   
##  1st Qu.:    0   1st Qu.: 0.00   1st Qu.:2330   
##  Median :    0   Median : 0.00   Median :4096   
##  Mean   :  460   Mean   : 1.37   Mean   :4119   
##  3rd Qu.:  311   3rd Qu.: 1.00   3rd Qu.:5790   
##  Max.   :30817   Max.   :53.00   Max.   :8296
```


####PROBLEM 1.2 - NORMALIZING THE DATA  (1 point possible)
In this problem, we will normalize our data before we run the clustering algorithms. Why is it important to normalize the data before clustering?

If we don't normalize the data, the clustering will be dominated by the variables that are on a larger scale. 

####PROBLEM 1.3 - NORMALIZING THE DATA  (2 points possible)
Let's go ahead and normalize our data. You can normalize the variables in a data frame by using the preProcess function in the "caret" package. You should already have this package installed from Week 4, but if not, go ahead and install it with install.packages("caret"). Then load the package with library(caret).

```r
library(caret)
```

```
## Loading required package: lattice
## Loading required package: ggplot2
```


Now, create a normalized data frame called "airlinesNorm" by running the following commands:


```r
preproc = preProcess(airlines)
airlinesNorm = predict(preproc, airlines)
```


The first command pre-processes the data, and the second command performs the normalization. If you look at the summary of airlinesNorm, you should see that all of the variables now have mean zero. You can also see that each of the variables has standard deviation 1 by using the sd() function.

```r
summary(airlinesNorm)
```

```
##     Balance         QualMiles        BonusMiles       BonusTrans    
##  Min.   :-0.730   Min.   :-0.186   Min.   :-0.710   Min.   :-1.208  
##  1st Qu.:-0.546   1st Qu.:-0.186   1st Qu.:-0.658   1st Qu.:-0.896  
##  Median :-0.303   Median :-0.186   Median :-0.413   Median : 0.041  
##  Mean   : 0.000   Mean   : 0.000   Mean   : 0.000   Mean   : 0.000  
##  3rd Qu.: 0.187   3rd Qu.:-0.186   3rd Qu.: 0.276   3rd Qu.: 0.562  
##  Max.   :16.187   Max.   :14.223   Max.   :10.208   Max.   : 7.747  
##   FlightMiles      FlightTrans     DaysSinceEnroll  
##  Min.   :-0.329   Min.   :-0.362   Min.   :-1.9934  
##  1st Qu.:-0.329   1st Qu.:-0.362   1st Qu.:-0.8661  
##  Median :-0.329   Median :-0.362   Median :-0.0109  
##  Mean   : 0.000   Mean   : 0.000   Mean   : 0.0000  
##  3rd Qu.:-0.106   3rd Qu.:-0.098   3rd Qu.: 0.8096  
##  Max.   :21.680   Max.   :13.610   Max.   : 2.0228
```


In the normalized data, which variable has the largest maximum value?

In the normalized data, which variable has the smallest minimum value?

####PROBLEM 2.1 - HIERARCHICAL CLUSTERING  (1 point possible)
Compute the distances between data points (using euclidean distance) and then run the Hierarchical clustering algorithm (using method="ward") on the normalized data. It may take a few minutes for the commands to finish since the dataset has a large number of observations for hierarchical clustering.

```r
airdist <- dist(airlinesNorm, method = "euclidean")
airClust = hclust(airdist, method = "ward")
```


Then, plot the dendrogram of the hierarchical clustering process. Suppose the airline is looking for somewhere between 2 and 10 clusters. According to the dendrogram, which of the following is NOT a good choice for the number of clusters?

```r
plot(airClust)
```

![plot of chunk unnamed-chunk-7](figure/unnamed-chunk-7.png) 


6

####PROBLEM 2.2 - HIERARCHICAL CLUSTERING  (1 point possible)
Suppose that after looking at the dendrogram and discussing with the marketing department, the airline decides to proceed with 5 clusters. Divide the data points into 5 clusters by using the cutree function. How many data points are in Cluster 1?

```r
hierGroups = cutree(airClust, k = 5)
table(hierGroups)
```

```
## hierGroups
##    1    2    3    4    5 
##  776  519  494  868 1342
```


####PROBLEM 2.3 - HIERARCHICAL CLUSTERING  (2 points possible)
Now, use tapply to compare the average values in each of the variables for the 5 clusters (the centroids of the clusters). You may want to compute the average values of the unnormalized data so that it is easier to interpret. You can do this for the variable "Balance" with the following command:

```r
tapply(airlines$Balance, hierGroups, mean)
```

```
##      1      2      3      4      5 
##  57867 110669 198192  52336  36256
```

```r
tapply(airlines$QualMiles, hierGroups, mean)
```

```
##         1         2         3         4         5 
##    0.6443 1065.9827   30.3462    4.8479    2.5112
```

```r
tapply(airlines$BonusMiles, hierGroups, mean)
```

```
##     1     2     3     4     5 
## 10360 22882 55796 20789  2265
```

```r
tapply(airlines$BonusTrans, hierGroups, mean)
```

```
##      1      2      3      4      5 
## 10.823 18.229 19.664 17.088  2.973
```

```r
tapply(airlines$FlightMiles, hierGroups, mean)
```

```
##       1       2       3       4       5 
##   83.18 2613.42  327.68  111.57  119.32
```

```r
tapply(airlines$FlightTrans, hierGroups, mean)
```

```
##      1      2      3      4      5 
## 0.3028 7.4027 1.0688 0.3445 0.4389
```

```r
tapply(airlines$DaysSinceEnroll, hierGroups, mean)
```

```
##    1    2    3    4    5 
## 6235 4402 5616 2841 3060
```


Compared to the other clusters, Cluster 1 has the largest average values in which variables (if any)?

 DaysSinceEnroll
 
How would you describe the customers in Cluster 1?


Infrequent but loyal customers.

####PROBLEM 2.4 - HIERARCHICAL CLUSTERING  (2 points possible)
Compared to the other clusters, Cluster 2 has the largest average values in which variables (if any)?

QualMiles 
FlightMiles 
FlightTrans 

How would you describe the customers in Cluster 2?

Customers who have accumulated a large amount of miles, and the ones with the largest number of flight transactions. 

####PROBLEM 2.5 - HIERARCHICAL CLUSTERING  (2 points possible)
Compared to the other clusters, Cluster 3 has the largest average values in which variables (if any)?

Balance 
BonusMiles 
BonusTrans 

How would you describe the customers in Cluster 3?

Customers who have accumulated a large amount of miles, mostly through non-flight transactions. 

####PROBLEM 2.6 - HIERARCHICAL CLUSTERING  (2 points possible)
Compared to the other clusters, Cluster 4 has the largest average values in which variables (if any)?

None

How would you describe the customers in Cluster 4?

Relatively new customers who seem to be accumulating miles, mostly through non-flight transactions.

####PROBLEM 2.7 - HIERARCHICAL CLUSTERING  (2 points possible)
Compared to the other clusters, Cluster 5 has the largest average values in which variables (if any)?

None

How would you describe the customers in Cluster 5?

Relatively new customers who don't use the airline very often. 

####PROBLEM 3.1 - K-MEANS CLUSTERING  (1 point possible)
Now run the k-means clustering algorithm on the normalized data, again creating 5 clusters. Set the seed to 88 right before running the clustering algorithm, and set the argument iter.max to 1000.

```r
k = 5
set.seed(88)
airKMClust = kmeans(airlinesNorm, centers = k, iter.max = 1000)
```


How many clusters have more than 1,000 observations?

```r
table(airKMClust$cluster)
```

```
## 
##    1    2    3    4    5 
##  408  141  993 1182 1275
```



PROBLEM 3.2 - K-MEANS CLUSTERING  (1 point possible)
Now, compare the cluster centroids to each other either by dividing the data points into groups and then using tapply, or by looking at the output of kmeansClust$centers, where "kmeansClust" is the name of the output of the kmeans function. (Note that the output of kmeansClust$centers will be for the normalized data. If you want to look at the average values for the unnormalized data, you need to use tapply like we did for hierarchical clustering.)

Do you expect Cluster 1 of the K-Means clustering output to necessarily be similar to Cluster 1 of the Hierarchical clustering output?

```r
tapply(airlines$Balance, airKMClust$cluster, mean)
```

```
##      1      2      3      4      5 
## 219161 174432  67977  60166  32707
```


No, because cluster ordering is not meaningful in either k-means clustering or hierarchical clustering. 
