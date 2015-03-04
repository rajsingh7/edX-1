Problem Set 6-3
========================================================
PREDICTING MEDICAL COSTS WITH CLUSTER-THEN-PREDICT

In the second lecture sequence this week, we heard about cluster-then-predict, a methodology in which you first cluster observations and then build cluster-specific prediction models. In the lecture sequence, we saw how this methodology helped improve the prediction of heart attack risk. In this assignment, we'll use cluster-then-predict to predict future medical costs using medical claims data.

In Week 4, we discussed the importance of high-quality predictions of future medical costs based on information available in medical claims data. In this problem, you will predict future medical claims using part of the DE-SynPUF dataset, published by the United States Centers for Medicare and Medicaid Services (CMS). This dataset, available in reimbursement.csv, is structured to represent a sample of patients in the Medicare program, which provides health insurance to Americans aged 65 and older as well as some younger people with certain medical conditions. To protect the privacy of patients represented in this publicly available dataset, CMS performs a number of steps to anonymize the data, so we would need to re-train the models we develop in this problem on de-anonymized data if we wanted to apply our models in the real world.

The observations in the dataset represent a 1% random sample of Medicare beneficiaries in 2008, limited to those still alive at the end of 2008. The dependent variable, reimbursement2009, represents the total value of all Medicare reimbursements for a patient in 2009, which is the cost of the patient's care to the Medicare system. The following independent variables are available:

age: The patient's age in years at the beginning of 2009
alzheimers: Binary variable for whether the patient had diagnosis codes for Alzheimer's disease or a related disorder in 2008
arthritis: Binary variable for whether the patient had diagnosis codes for rheumatoid arthritis or osteoarthritis in 2008
cancer: Binary variable for whether the patient had diagnosis codes for cancer in 2008
copd: Binary variable for whether the patient had diagnosis codes for Chronic Obstructive Pulmonary Disease (COPD) in 2008
depression: Binary variable for whether the patient had diagnosis codes for depression in 2008
diabetes: Binary variable for whether the patient had diagnosis codes for diabetes in 2008
heart.failure: Binary variable for whether the patient had diagnosis codes for heart failure in 2008
ihd: Binary variable for whether the patient had diagnosis codes for ischemic heart disease (IHD) in 2008
kidney: Binary variable for whether the patient had diagnosis codes for chronic kidney disease in 2008
osteoporosis: Binary variable for whether the patient had diagnosis codes for osteoporosis in 2008
stroke: Binary variable for whether the patient had diagnosis codes for a stroke/transient ischemic attack (TIA) in 2008
reimbursement2008: The total amount of Medicare reimbursements for this patient for 2008

###PROBLEM 1.1 - PREPARING THE DATASET  (1 point possible)
Load reimbursement.csv into a data frame called claims.

```r
claims <- read.csv("reimbursement.csv")
nrow(claims)
```

```
## [1] 458005
```


How many Medicare beneficiaries are included in the dataset?

###PROBLEM 1.2 - PREPARING THE DATASET  (1 point possible)
What proportion of patients have at least one of the chronic conditions described in the independent variables alzheimers, arthritis, cancer, copd, depression, diabetes, heart.failure, ihd, kidney, osteoporosis, and stroke?

```r
s <- ((claims$alzheimers >= 1) | (claims$arthritis >= 1) | (claims$cancer >= 
    1) | (claims$copd >= 1) | (claims$depression >= 1) | (claims$diabetes >= 
    1) | (claims$heart.failure >= 1) | (claims$ihd >= 1) | (claims$kidney >= 
    1) | (claims$osteoporosis >= 1) | (claims$stroke >= 1))
sum(s)
```

```
## [1] 280427
```

```r
280427/458005
```

```
## [1] 0.6123
```


###PROBLEM 1.3 - PREPARING THE DATASET  (1 point possible)
What is the maximum correlation between independent variables in the dataset?

```r
cor(claims)
```

```
##                       age alzheimers arthritis cancer    copd depression
## age               1.00000    0.04556   0.04178 0.0376 0.04395    0.01584
## alzheimers        0.04556    1.00000   0.20593 0.1375 0.28151    0.28940
## arthritis         0.04178    0.20593   1.00000 0.1188 0.21783    0.23046
## cancer            0.03760    0.13748   0.11879 1.0000 0.17465    0.12064
## copd              0.04395    0.28151   0.21783 0.1747 1.00000    0.26298
## depression        0.01584    0.28940   0.23046 0.1206 0.26298    1.00000
## diabetes          0.06695    0.34001   0.32348 0.1803 0.33593    0.34687
## heart.failure     0.06684    0.33335   0.26437 0.1742 0.37643    0.30394
## ihd               0.07348    0.32573   0.31029 0.1923 0.34052    0.32391
## kidney            0.05588    0.30254   0.24986 0.1877 0.36082    0.27422
## osteoporosis      0.03957    0.19098   0.21953 0.1131 0.18372    0.19291
## stroke            0.03557    0.21971   0.11612 0.1010 0.20853    0.15788
## reimbursement2008 0.04824    0.31267   0.24884 0.2451 0.41401    0.27457
## reimbursement2009 0.03848    0.22547   0.20199 0.1591 0.26251    0.22512
##                   diabetes heart.failure     ihd  kidney osteoporosis
## age                0.06695       0.06684 0.07348 0.05588      0.03957
## alzheimers         0.34001       0.33335 0.32573 0.30254      0.19098
## arthritis          0.32348       0.26437 0.31029 0.24986      0.21953
## cancer             0.18030       0.17424 0.19226 0.18766      0.11306
## copd               0.33593       0.37643 0.34052 0.36082      0.18372
## depression         0.34687       0.30394 0.32391 0.27422      0.19291
## diabetes           1.00000       0.44658 0.51461 0.41119      0.27449
## heart.failure      0.44658       1.00000 0.46778 0.41974      0.22192
## ihd                0.51461       0.46778 1.00000 0.37823      0.26574
## kidney             0.41119       0.41974 0.37823 1.00000      0.19282
## osteoporosis       0.27449       0.22192 0.26574 0.19282      1.00000
## stroke             0.19330       0.22167 0.19447 0.23142      0.09936
## reimbursement2008  0.34888       0.39655 0.36137 0.48207      0.18311
## reimbursement2009  0.31297       0.30220 0.31225 0.31884      0.16157
##                    stroke reimbursement2008 reimbursement2009
## age               0.03557           0.04824           0.03848
## alzheimers        0.21971           0.31267           0.22547
## arthritis         0.11612           0.24884           0.20199
## cancer            0.10105           0.24512           0.15906
## copd              0.20853           0.41401           0.26251
## depression        0.15788           0.27457           0.22512
## diabetes          0.19330           0.34888           0.31297
## heart.failure     0.22167           0.39655           0.30220
## ihd               0.19447           0.36137           0.31225
## kidney            0.23142           0.48207           0.31884
## osteoporosis      0.09936           0.18311           0.16157
## stroke            1.00000           0.29429           0.16367
## reimbursement2008 0.29429           1.00000           0.34959
## reimbursement2009 0.16367           0.34959           1.00000
```

```r
sort(cor(claims))
```

```
##   [1] 0.01584 0.01584 0.03557 0.03557 0.03760 0.03760 0.03848 0.03848
##   [9] 0.03957 0.03957 0.04178 0.04178 0.04395 0.04395 0.04556 0.04556
##  [17] 0.04824 0.04824 0.05588 0.05588 0.06684 0.06684 0.06695 0.06695
##  [25] 0.07348 0.07348 0.09936 0.09936 0.10105 0.10105 0.11306 0.11306
##  [33] 0.11612 0.11612 0.11879 0.11879 0.12064 0.12064 0.13748 0.13748
##  [41] 0.15788 0.15788 0.15906 0.15906 0.16157 0.16157 0.16367 0.16367
##  [49] 0.17424 0.17424 0.17465 0.17465 0.18030 0.18030 0.18311 0.18311
##  [57] 0.18372 0.18372 0.18766 0.18766 0.19098 0.19098 0.19226 0.19226
##  [65] 0.19282 0.19282 0.19291 0.19291 0.19330 0.19330 0.19447 0.19447
##  [73] 0.20199 0.20199 0.20593 0.20593 0.20853 0.20853 0.21783 0.21783
##  [81] 0.21953 0.21953 0.21971 0.21971 0.22167 0.22167 0.22192 0.22192
##  [89] 0.22512 0.22512 0.22547 0.22547 0.23046 0.23046 0.23142 0.23142
##  [97] 0.24512 0.24512 0.24884 0.24884 0.24986 0.24986 0.26251 0.26251
## [105] 0.26298 0.26298 0.26437 0.26437 0.26574 0.26574 0.27422 0.27422
## [113] 0.27449 0.27449 0.27457 0.27457 0.28151 0.28151 0.28940 0.28940
## [121] 0.29429 0.29429 0.30220 0.30220 0.30254 0.30254 0.30394 0.30394
## [129] 0.31029 0.31029 0.31225 0.31225 0.31267 0.31267 0.31297 0.31297
## [137] 0.31884 0.31884 0.32348 0.32348 0.32391 0.32391 0.32573 0.32573
## [145] 0.33335 0.33335 0.33593 0.33593 0.34001 0.34001 0.34052 0.34052
## [153] 0.34687 0.34687 0.34888 0.34888 0.34959 0.34959 0.36082 0.36082
## [161] 0.36137 0.36137 0.37643 0.37643 0.37823 0.37823 0.39655 0.39655
## [169] 0.41119 0.41119 0.41401 0.41401 0.41974 0.41974 0.44658 0.44658
## [177] 0.46778 0.46778 0.48207 0.48207 0.51461 0.51461 1.00000 1.00000
## [185] 1.00000 1.00000 1.00000 1.00000 1.00000 1.00000 1.00000 1.00000
## [193] 1.00000 1.00000 1.00000 1.00000
```


###PROBLEM 1.4 - PREPARING THE DATASET  (1 point possible)
Plot the histogram of the dependent variable. What is the shape of the distribution?

```r
hist(claims$reimbursement2008)
```

![plot of chunk unnamed-chunk-4](figure/unnamed-chunk-4.png) 


Skew right -- there are a large number of observations with a small value, but only a small number of observations with a large value.

###PROBLEM 1.5 - PREPARING THE DATASET  (1 point possible)
To address the shape of the data identified in the previous problem, we will log transform the two reimbursement variables with the following code:

```r
claims$reimbursement2008 = log(claims$reimbursement2008 + 1)
claims$reimbursement2009 = log(claims$reimbursement2009 + 1)
```


Why did we take the log of the reimbursement value plus 1 instead of the log of the reimbursement value? Hint -- What happens when a patient has a reimbursement cost of $0?

To avoid log-transformed values of negative infinity 

###PROBLEM 1.6 - PREPARING THE DATASET  (1 point possible)
Plot the histogram of the log-transformed dependent variable. The distribution is reasonably balanced, other than a large number of people with variable value 0, corresponding to having had $0 in reimbursements in 2009. What proportion of beneficiaries had $0 in reimbursements in 2009?

```r
hist(claims$reimbursement2008)
```

![plot of chunk unnamed-chunk-6](figure/unnamed-chunk-61.png) 

```r
hist(claims$reimbursement2009)
```

![plot of chunk unnamed-chunk-6](figure/unnamed-chunk-62.png) 

```r
sum(claims$reimbursement2009 == 0)/nrow(claims)
```

```
## [1] 0.1976
```


###PROBLEM 2.1 - INITIAL LINEAR REGRESSION MODEL  (1 point possible)
In Week 3 when we learned about the sample.split function, we mentioned that you split data into a training and testing set a bit differently when there is a continuous outcome. Run the following commands to randomly select 70% of the data for the training set and 30% of the data for the testing set:

```r
set.seed(144)
spl = sample(1:nrow(claims), size = 0.7 * nrow(claims))
train = claims[spl, ]
test = claims[-spl, ]
```


Use the train data frame to train a linear regression model (name it lm.claims) to predict reimbursement2009 using all the independent variables.

```r
lm.claims <- lm(reimbursement2009 ~ ., data = train)
```


What is the training set Multiple R-squared value of lm.claims?

```r
summary(lm.claims)
```

```
## 
## Call:
## lm(formula = reimbursement2009 ~ ., data = train)
## 
## Residuals:
##     Min      1Q  Median      3Q     Max 
## -10.708  -1.428  -0.062   0.887   9.382 
## 
## Coefficients:
##                    Estimate Std. Error t value Pr(>|t|)    
## (Intercept)        1.857321   0.019604   94.74  < 2e-16 ***
## age               -0.001014   0.000262   -3.87  0.00011 ***
## alzheimers        -0.015690   0.009434   -1.66  0.09628 .  
## arthritis          0.047807   0.009933    4.81  1.5e-06 ***
## cancer            -0.040556   0.013893   -2.92  0.00351 ** 
## copd              -0.185806   0.010966  -16.94  < 2e-16 ***
## depression         0.089939   0.009008    9.98  < 2e-16 ***
## diabetes           0.251835   0.008958   28.11  < 2e-16 ***
## heart.failure      0.008988   0.009132    0.98  0.32501    
## ihd                0.154717   0.008999   17.19  < 2e-16 ***
## kidney            -0.226933   0.010635  -21.34  < 2e-16 ***
## osteoporosis       0.105285   0.009271   11.36  < 2e-16 ***
## stroke            -0.254776   0.016667  -15.29  < 2e-16 ***
## reimbursement2008  0.759142   0.001407  539.69  < 2e-16 ***
## ---
## Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1
## 
## Residual standard error: 1.85 on 320589 degrees of freedom
## Multiple R-squared:  0.692,	Adjusted R-squared:  0.692 
## F-statistic: 5.55e+04 on 13 and 320589 DF,  p-value: <2e-16
```


###PROBLEM 2.2 - INITIAL LINEAR REGRESSION MODEL  (1 point possible)
Obtain testing set predictions from lm.claims. What is the testing set RMSE of the model?

```r
lm.pred <- predict(lm.claims, newdata = test)
sqrt(mean((lm.pred - test$reimbursement2009)^2))
```

```
## [1] 1.849
```


###PROBLEM 2.3 - INITIAL LINEAR REGRESSION MODEL  (1 point possible)
What is the "naive baseline model" that we would typically use to compute the R-squared value of lm.claims?

Predict mean(train$reimbursement2009) for every observation 

###PROBLEM 2.4 - INITIAL LINEAR REGRESSION MODEL  (1 point possible)
What is the testing set RMSE of the naive baseline model?

```r
sqrt(mean((mean(train$reimbursement2009) - test$reimbursement2009)^2))
```

```
## [1] 3.335
```


###PROBLEM 2.5 - INITIAL LINEAR REGRESSION MODEL  (1 point possible)
In Week 4, we saw how D2Hawkeye used a "smart baseline model" that predicted that a patient's medical costs would be equal to their costs in the previous year. For our problem, this baseline would predict reimbursement2009 to be equal to reimbursement2008.

What is the testing set RMSE of this smart baseline model?

```r
sqrt(mean((test$reimbursement2008 - test$reimbursement2009)^2))
```

```
## [1] 2.095
```


###PROBLEM 3.1 - CLUSTERING MEDICARE BENEFICIARIES  (1 point possible)
In this section, we will cluster the Medicare beneficiaries. The first step in this process is to remove the dependent variable using the following commands:

```r
train.limited = train
train.limited$reimbursement2009 = NULL
test.limited = test
test.limited$reimbursement2009 = NULL
```


Why do we need to remove the dependent variable in the clustering phase of the cluster-then-predict methodology?

Needing to know the dependent variable value to assign an observation to a cluster defeats the purpose of the methodology

###PROBLEM 3.2 - CLUSTERING MEDICARE BENEFICIARIES  (2 points possible)
In the market segmentation assignment in this week's homework, you were introduced to the preProcess command from the caret package, which normalizes variables by subtracting by the mean and dividing by the standard deviation.

In cases where we have a training and testing set, we'll want to normalize by the mean and standard deviation of the variables in the training set. We can do this by passing just the training set to the preProcess function:

```r
library(caret)
```

```
## Loading required package: lattice
## Loading required package: ggplot2
```

```r

preproc = preProcess(train.limited)

train.norm = predict(preproc, train.limited)

test.norm = predict(preproc, test.limited)
```


What is the mean of the arthritis variable in train.norm?

```r
mean(train.norm$arthritis)
```

```
## [1] 2.049e-17
```


What is the mean of the arthritis variable in test.norm?

```r
mean(test.norm$arthritis)
```

```
## [1] -0.006125
```


###PROBLEM 3.3 - CLUSTERING MEDICARE BENEFICIARIES  (1 point possible)
Why is the mean arthritis variable much closer to 0 in train.norm than in test.norm?

The distribution of the arthritis variable is different in the training and testing set

###PROBLEM 3.4 - CLUSTERING MEDICARE BENEFICIARIES  (1 point possible)
Set the random seed to 144 (it is important to do this again, even though we did it earlier). Run k-means clustering with 3 clusters on train.norm, storing the result in an object called km.

```r
k = 3
set.seed(144)
km = kmeans(train.norm, centers = k)
```


The description "older-than-average beneficiaries with below average incidence of stroke and above-average 2008 reimbursements" uniquely describes which cluster center?

```r
km$centers
```

```
##        age alzheimers arthritis   cancer    copd depression diabetes
## 1  0.14799    1.01893    0.8219  0.63518  1.3529     0.8948   1.0260
## 2 -0.10237   -0.43237   -0.3959 -0.23297 -0.3746    -0.4447  -0.7613
## 3  0.05684    0.05456    0.1023 -0.01118 -0.1742     0.1282   0.4578
##   heart.failure     ihd  kidney osteoporosis  stroke reimbursement2008
## 1        1.1909  0.9646  1.4830       0.5605  0.8531            0.9973
## 2       -0.5741 -0.8342 -0.4219      -0.3907 -0.2059           -0.8435
## 3        0.1487  0.5769 -0.1769       0.2189 -0.1473            0.5730
```


###PROBLEM 3.5 - CLUSTERING MEDICARE BENEFICIARIES  (1 point possible)
Recall from the recitation that we can use the flexclust package to obtain training set and testing set cluster assignments for our observations (note that the call to as.kcca may take a while to complete):

```r
install.packages("flexclust")
```

```
## Error: trying to use CRAN without setting a mirror
```

```r
library(flexclust)
```

```
## Loading required package: grid
## Loading required package: modeltools
## Loading required package: stats4
```

```r
km.kcca = as.kcca(km, train.norm)
cluster.train = predict(km.kcca)
cluster.test = predict(km.kcca, newdata = test.norm)
```


How many test-set observations were assigned to Cluster 2?

```r
sum(cluster.test == 2)
```

```
## [1] 62651
```


###PROBLEM 4.1 - CLUSTER-SPECIFIC PREDICTIONS  (1 point possible)
Using the subset function, build data frames train1, train2, and train3, containing the elements in the train data frame assigned to clusters 1, 2, and 3, respectively (be careful to take subsets of train, not of train.norm). Similarly build test1, test2, and test3 from the test data frame.


```r
train1 <- subset(train, cluster.train == 1)
train2 <- subset(train, cluster.train == 2)
train3 <- subset(train, cluster.train == 3)
test1 <- subset(test, cluster.test == 1)
test2 <- subset(test, cluster.test == 2)
test3 <- subset(test, cluster.test == 3)
```


Which training set data frame has the highest average value of the dependent variable?

```r
mean(train1$reimbursement2009)
```

```
## [1] 8.724
```

```r
mean(train2$reimbursement2009)
```

```
## [1] 3.661
```

```r
mean(train3$reimbursement2009)
```

```
## [1] 7.882
```

```r
mean(test1$reimbursement2009)
```

```
## [1] 8.706
```

```r
mean(test2$reimbursement2009)
```

```
## [1] 3.657
```

```r
mean(test3$reimbursement2009)
```

```
## [1] 7.88
```


###PROBLEM 4.2 - CLUSTER-SPECIFIC PREDICTIONS  (1 point possible)
Build linear regression models lm1, lm2, and lm3, which predict reimbursement2009 using all the variables. lm1 should be trained on train1, lm2 should be trained on train2, and lm3 should be trained on train3.

```r
lm1 <- lm(reimbursement2009 ~ ., data = train1)
lm2 <- lm(reimbursement2009 ~ ., data = train2)
lm3 <- lm(reimbursement2009 ~ ., data = train3)
```


Which variables have a positive sign for the coefficient in at least one of lm1, lm2, and lm3 and a negative sign for the coefficient in at least one of lm1, lm2, and lm3?

```r
summary(lm1)
```

```
## 
## Call:
## lm(formula = reimbursement2009 ~ ., data = train1)
## 
## Residuals:
##    Min     1Q Median     3Q    Max 
## -9.374 -0.645 -0.102  0.669  3.547 
## 
## Coefficients:
##                    Estimate Std. Error t value Pr(>|t|)    
## (Intercept)        6.128373   0.045509  134.66  < 2e-16 ***
## age               -0.000778   0.000332   -2.34    0.019 *  
## alzheimers         0.048863   0.009049    5.40  6.7e-08 ***
## arthritis          0.127756   0.008960   14.26  < 2e-16 ***
## cancer             0.167001   0.010825   15.43  < 2e-16 ***
## copd               0.101623   0.009457   10.75  < 2e-16 ***
## depression         0.140563   0.008948   15.71  < 2e-16 ***
## diabetes           0.279173   0.013516   20.66  < 2e-16 ***
## heart.failure      0.163891   0.011716   13.99  < 2e-16 ***
## ihd                0.183921   0.014718   12.50  < 2e-16 ***
## kidney             0.179917   0.010407   17.29  < 2e-16 ***
## osteoporosis       0.064333   0.009030    7.12  1.1e-12 ***
## stroke             0.046074   0.010844    4.25  2.2e-05 ***
## reimbursement2008  0.185733   0.004539   40.92  < 2e-16 ***
## ---
## Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1
## 
## Residual standard error: 1.03 on 55766 degrees of freedom
## Multiple R-squared:  0.0962,	Adjusted R-squared:  0.096 
## F-statistic:  457 on 13 and 55766 DF,  p-value: <2e-16
```

```r
summary(lm2)
```

```
## 
## Call:
## lm(formula = reimbursement2009 ~ ., data = train2)
## 
## Residuals:
##     Min      1Q  Median      3Q     Max 
## -10.247  -1.653  -0.617   1.393   9.471 
## 
## Coefficients:
##                    Estimate Std. Error t value Pr(>|t|)    
## (Intercept)        1.795041   0.036950   48.58  < 2e-16 ***
## age               -0.002001   0.000506   -3.95  7.8e-05 ***
## alzheimers         0.298556   0.043913    6.80  1.1e-11 ***
## arthritis          0.553770   0.059267    9.34  < 2e-16 ***
## cancer             0.423085   0.076207    5.55  2.8e-08 ***
## copd               0.217739   0.072533    3.00   0.0027 ** 
## depression         0.416892   0.037593   11.09  < 2e-16 ***
## diabetes           0.824799   0.062367   13.22  < 2e-16 ***
## heart.failure      0.314764   0.040683    7.74  1.0e-14 ***
## ihd                0.263823   0.067988    3.88   0.0001 ***
## kidney             0.132773   0.081331    1.63   0.1026    
## osteoporosis       0.467177   0.040381   11.57  < 2e-16 ***
## stroke             0.003150   0.133760    0.02   0.9812    
## reimbursement2008  0.770075   0.002401  320.71  < 2e-16 ***
## ---
## Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1
## 
## Residual standard error: 2.39 on 146383 degrees of freedom
## Multiple R-squared:  0.507,	Adjusted R-squared:  0.507 
## F-statistic: 1.16e+04 on 13 and 146383 DF,  p-value: <2e-16
```

```r
summary(lm3)
```

```
## 
## Call:
## lm(formula = reimbursement2009 ~ ., data = train3)
## 
## Residuals:
##    Min     1Q Median     3Q    Max 
## -9.098 -0.577 -0.062  0.570  4.302 
## 
## Coefficients:
##                   Estimate Std. Error t value Pr(>|t|)    
## (Intercept)       5.072540   0.033288  152.38   <2e-16 ***
## age               0.000487   0.000275    1.77    0.076 .  
## alzheimers        0.073427   0.008363    8.78   <2e-16 ***
## arthritis         0.234484   0.008828   26.56   <2e-16 ***
## cancer            0.277148   0.014359   19.30   <2e-16 ***
## copd              0.144986   0.012966   11.18   <2e-16 ***
## depression        0.136755   0.007778   17.58   <2e-16 ***
## diabetes          0.229013   0.007058   32.45   <2e-16 ***
## heart.failure     0.113918   0.007162   15.91   <2e-16 ***
## ihd               0.142788   0.007608   18.77   <2e-16 ***
## kidney            0.189291   0.011890   15.92   <2e-16 ***
## osteoporosis      0.094386   0.007774   12.14   <2e-16 ***
## stroke            0.033999   0.028590    1.19    0.234    
## reimbursement2008 0.308355   0.003738   82.49   <2e-16 ***
## ---
## Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1
## 
## Residual standard error: 1.16 on 118412 degrees of freedom
## Multiple R-squared:  0.118,	Adjusted R-squared:  0.117 
## F-statistic: 1.21e+03 on 13 and 118412 DF,  p-value: <2e-16
```


age 

###PROBLEM 4.3 - CLUSTER-SPECIFIC PREDICTIONS  (1 point possible)
Using lm1, make test-set predictions called pred.test1 on data frame test1. Using lm2, make test-set predictions called pred.test2 on data frame test2. Using lm3, make test-set predictions called pred.test3 on data frame test3.

```r
pred.test1 <- predict(lm1, newdata = test1)
pred.test2 <- predict(lm2, newdata = test2)
pred.test3 <- predict(lm3, newdata = test3)
```


Which vector of test-set predictions has the smallest average predicted reimbursement amount?

```r
mean(pred.test1)
```

```
## [1] 8.726
```

```r
mean(pred.test2)
```

```
## [1] 3.651
```

```r
mean(pred.test3)
```

```
## [1] 7.881
```


pred.test2

###PROBLEM 4.4 - CLUSTER-SPECIFIC PREDICTIONS  (1 point possible)
Obtain the test-set RMSE for each cluster. Which cluster has the largest test-set RMSE?

```r
sqrt(mean((pred.test1 - test1$reimbursement2009)^2))
```

```
## [1] 1.039
```

```r
sqrt(mean((pred.test2 - test2$reimbursement2009)^2))
```

```
## [1] 2.383
```

```r
sqrt(mean((pred.test3 - test3$reimbursement2009)^2))
```

```
## [1] 1.166
```


Cluster 2
   
###PROBLEM 4.5 - CLUSTER-SPECIFIC PREDICTIONS  (1 point possible)
To compute the overall test-set RMSE of the cluster-then-predict approach, we can combine all the test-set predictions into a single vector and all the true outcomes into a single vector:

```r
all.predictions = c(pred.test1, pred.test2, pred.test3)
all.outcomes = c(test1$reimbursement2009, test2$reimbursement2009, test3$reimbursement2009)
```


What is the test-set RMSE of the cluster-then-predict approach?

```r
sqrt(mean((all.predictions - all.outcomes)^2))
```

```
## [1] 1.811
```


- unanswered
\[\] 
We see a modest improvement over the original linear regression model, which is typical in situations where the observations do not cluster strongly into different "types" of observations. However, it is often a good idea to try the cluster-then-predict approach on datasets with a large number of observations to see if you can improve the accuracy of your model.

   You have used 0 of 3 submissions
Please remember not to ask for or post complete answers to homework questions in this discussion forum.
