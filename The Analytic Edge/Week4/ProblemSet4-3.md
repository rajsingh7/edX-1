ProblemSet4-3
========================================================
STATE DATA REVISITED

We will be revisiting the "state" dataset from Week 2. Recall that this dataset has, for each of the fifty U.S. states, the population, per capita income, illiteracy rate, murder rate, high school graduation rate, average number of frost days, area, latitude and longitude, division the state belongs to, region the state belongs to, and two-letter abbreviation. This dataset comes from the U.S. Department of Commerce, Bureau of the Census.

Load the dataset into R and convert it to a data frame by running the following two commands in R:

```r
data(state)
statedata = data.frame(state.x77)
```


Inspect the data set using the command:


```r
str(statedata)
```

```
## 'data.frame':	50 obs. of  8 variables:
##  $ Population: num  3615 365 2212 2110 21198 ...
##  $ Income    : num  3624 6315 4530 3378 5114 ...
##  $ Illiteracy: num  2.1 1.5 1.8 1.9 1.1 0.7 1.1 0.9 1.3 2 ...
##  $ Life.Exp  : num  69 69.3 70.5 70.7 71.7 ...
##  $ Murder    : num  15.1 11.3 7.8 10.1 10.3 6.8 3.1 6.2 10.7 13.9 ...
##  $ HS.Grad   : num  41.3 66.7 58.1 39.9 62.6 63.9 56 54.6 52.6 40.6 ...
##  $ Frost     : num  20 152 15 65 20 166 139 103 11 60 ...
##  $ Area      : num  50708 566432 113417 51945 156361 ...
```


We will try to build a model for life expectancy using regression trees, and employ cross-validation to improve our tree's performance.

PROBLEM 1.1 - LINEAR REGRESSION MODELS  (1 point possible)
-------------------------------------------------------------
Let's recreate the linear regression models we made in the previous homework question. First, predict Life.Exp using all of the other variables as the independent variables (Population, Income, Illiteracy, Murder, HS.Grad, Frost, Area ). Use the entire dataset to build the model.


```r
linModel0 <- lm(Life.Exp ~ ., data = statedata)
summary(linModel0)
```

```
## 
## Call:
## lm(formula = Life.Exp ~ ., data = statedata)
## 
## Residuals:
##     Min      1Q  Median      3Q     Max 
## -1.4890 -0.5123 -0.0275  0.5700  1.4945 
## 
## Coefficients:
##              Estimate Std. Error t value Pr(>|t|)    
## (Intercept)  7.09e+01   1.75e+00   40.59  < 2e-16 ***
## Population   5.18e-05   2.92e-05    1.77    0.083 .  
## Income      -2.18e-05   2.44e-04   -0.09    0.929    
## Illiteracy   3.38e-02   3.66e-01    0.09    0.927    
## Murder      -3.01e-01   4.66e-02   -6.46  8.7e-08 ***
## HS.Grad      4.89e-02   2.33e-02    2.10    0.042 *  
## Frost       -5.74e-03   3.14e-03   -1.82    0.075 .  
## Area        -7.38e-08   1.67e-06   -0.04    0.965    
## ---
## Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1
## 
## Residual standard error: 0.745 on 42 degrees of freedom
## Multiple R-squared:  0.736,	Adjusted R-squared:  0.692 
## F-statistic: 16.7 on 7 and 42 DF,  p-value: 2.53e-10
```



What is the adjusted R-squared of the model?

PROBLEM 1.2 - LINEAR REGRESSION MODELS  (1 point possible)
-------------------------------------------------------------
Calculate the sum of squared errors (SSE) between the predicted life expectancies using this model and the actual life expectancies:


```r
linModel0Pred = predict(linModel0, newdata = statedata, type = "response")
sum((linModel0Pred - statedata$Life.Exp)^2)
```

```
## [1] 23.3
```


PROBLEM 1.3 - LINEAR REGRESSION MODELS  (1 point possible)
-------------------------------------------------------------
Build a second linear regression model using just Population, Murder, Frost, and HS.Grad as independent variables (the best 4 variable model from the previous homework). What is the adjusted R-squared for this model?


```r
linModel1 <- lm(Life.Exp ~ Population + Murder + Frost + HS.Grad, data = statedata)
summary(linModel1)
```

```
## 
## Call:
## lm(formula = Life.Exp ~ Population + Murder + Frost + HS.Grad, 
##     data = statedata)
## 
## Residuals:
##    Min     1Q Median     3Q    Max 
## -1.471 -0.535 -0.037  0.576  1.507 
## 
## Coefficients:
##              Estimate Std. Error t value Pr(>|t|)    
## (Intercept)  7.10e+01   9.53e-01   74.54  < 2e-16 ***
## Population   5.01e-05   2.51e-05    2.00    0.052 .  
## Murder      -3.00e-01   3.66e-02   -8.20  1.8e-10 ***
## Frost       -5.94e-03   2.42e-03   -2.46    0.018 *  
## HS.Grad      4.66e-02   1.48e-02    3.14    0.003 ** 
## ---
## Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1
## 
## Residual standard error: 0.72 on 45 degrees of freedom
## Multiple R-squared:  0.736,	Adjusted R-squared:  0.713 
## F-statistic: 31.4 on 4 and 45 DF,  p-value: 1.7e-12
```


PROBLEM 1.4 - LINEAR REGRESSION MODELS  (1 point possible)
---------------------------------------------------------------
Calculate the sum of squared errors again, using this reduced model:

```r
linModel1Pred = predict(linModel1, newdata = statedata, type = "response")
sum((linModel1Pred - statedata$Life.Exp)^2)
```

```
## [1] 23.31
```


PROBLEM 1.5 - LINEAR REGRESSION MODELS  (1 point possible)
Which of the following is correct?

A Trying different combinations of variables in linear regression is like trying different numbers of splits in a tree - this controls the complexity of the model. 
B Using many variables in a linear regression is always better than using just a few. 
C The variables we removed were uncorrelated with Life.Exp

ANS A

PROBLEM 2.1 - CART MODELS  (1 point possible)
-----------------------------------------------------
Let's now build a CART model to predict Life.Exp using all of the other variables as independent variables (Population, Income, Illiteracy, Murder, HS.Grad, Frost, Area). We'll use the default minbucket parameter, so don't add the minbucket argument. Remember that in this problem we are not as interested in predicting life expectancies for new observations as we are understanding how they relate to the other variables we have, so we'll use all of the data to build our model. You shouldn't use the method="class" argument since this is a regression tree.

Plot the tree. Which of these variables appear in the tree?


```r
library(rpart)
```

```
## Warning: package 'rpart' was built under R version 3.0.3
```

```r
library(rpart.plot)
```

```
## Warning: package 'rpart.plot' was built under R version 3.0.3
```

```r
CARTModel0 <- rpart(Life.Exp ~ ., data = statedata)
prp(CARTModel0)
```

![plot of chunk unnamed-chunk-7](figure/unnamed-chunk-7.png) 


PROBLEM 2.2 - CART MODELS  (1 point possible)
--------------------------------------------------
Use the regression tree you just built to predict life expectancies (using the predict function), and calculate the sum-of-squared-errors (SSE) like you did for linear regression. What is the SSE?


```r
CARTModel0Pred <- predict(CARTModel0, newdata = statedata)
sum((CARTModel0Pred - statedata$Life.Exp)^2)
```

```
## [1] 29
```


PROBLEM 2.3 - CART MODELS  (1 point possible)
--------------------------------------------------------
The error is higher than for the linear regression models. One reason might be that we haven't made the tree big enough. Set the minbucket parameter to 5, and recreate the tree.


```r
CARTModel1 <- rpart(Life.Exp ~ ., data = statedata, control = rpart.control(minbucket = 5))
prp(CARTModel1)
```

![plot of chunk unnamed-chunk-9](figure/unnamed-chunk-9.png) 


Which variables appear in this new tree?


PROBLEM 2.4 - CART MODELS  (1 point possible)
--------------------------------------------------------
Do you think the default minbucket parameter is smaller or larger than 5 based on the tree that was built?

ANS Larger

PROBLEM 2.5 - CART MODELS  (1 point possible)
---------------------------------------------------------
What is the SSE of this tree?


```r
CARTModel1Pred <- predict(CARTModel1, newdata = statedata)
sum((CARTModel1Pred - statedata$Life.Exp)^2)
```

```
## [1] 23.64
```


This is much closer to the linear regression model's error. By changing the parameters we have improved the fit of our model.

PROBLEM 2.6 - CART MODELS  (1 point possible)
----------------------------------------------------
Can we do even better? Create a tree that predicts Life.Exp using only Area, with the minbucket parameter to 1. What is the SSE of this newest tree?

```r
CARTModel2 <- rpart(Life.Exp ~ Area, data = statedata, control = rpart.control(minbucket = 1))
prp(CARTModel2)
```

![plot of chunk unnamed-chunk-11](figure/unnamed-chunk-11.png) 

```r
CARTModel2Pred <- predict(CARTModel2, newdata = statedata)
sum((CARTModel2Pred - statedata$Life.Exp)^2)
```

```
## [1] 9.312
```


PROBLEM 2.7 - CART MODELS  (1 point possible)
-------------------------------------------------------
This is the lowest error we have seen so far. What would be the best interpretation of this result?

We can build almost perfect models given the right parameters, even if they violate our intuition of what a good model should be. 

PROBLEM 3.1 - CROSS-VALIDATION  (1 point possible)
------------------------------------------------------------
Adjusting the variables included in a linear regression model is a form of model tuning. In Problem 1 we showed that by removing variables in our linear regression model (tuning the model), we were able to maintain the fit of the model while using a simpler model. A rule of thumb is that simpler models are more interpretable and generalizeable. We will now tune our regression tree to see if we can improve the fit of our tree while keeping it as simple as possible.

Load the caret library, and set the seed to 111. Set up the controls exactly like we did in the lecture (10-fold cross-validation) with cp varying over the range 0.01 to 0.50 in increments of 0.01. Use the train function to determine the best cp value. What value of cp does the train function recommend? (Remember that the train function tells you to pick the largest value of cp with the lowest error when there are ties, and explains this at the bottom of the output.)


```r
library(caret)
```

```
## Warning: package 'caret' was built under R version 3.0.3
```

```
## Loading required package: lattice
```

```
## Warning: package 'lattice' was built under R version 3.0.3
```

```
## Loading required package: ggplot2
```

```r
set.seed(111)
fitControl = trainControl(method = "cv", number = 10)
cartGrid = expand.grid(.cp = (1:50) * 0.01)
train(Life.Exp ~ ., data = statedata, method = "rpart", trControl = fitControl, 
    tuneGrid = cartGrid)
```

```
## Warning: There were missing values in resampled performance measures.
```

```
## CART 
## 
## 50 samples
##  7 predictors
## 
## No pre-processing
## Resampling: Cross-Validated (10 fold) 
## 
## Summary of sample sizes: 45, 45, 46, 45, 45, 43, ... 
## 
## Resampling results across tuning parameters:
## 
##   cp    RMSE  Rsquared  RMSE SD  Rsquared SD
##   0.01  1     0.5       0.3      0.3        
##   0.02  1     0.5       0.3      0.3        
##   0.03  1     0.5       0.3      0.3        
##   0.04  1     0.5       0.3      0.3        
##   0.05  1     0.5       0.3      0.3        
##   0.06  1     0.5       0.3      0.3        
##   0.07  1     0.5       0.3      0.3        
##   0.08  1     0.5       0.3      0.3        
##   0.09  1     0.5       0.3      0.3        
##   0.1   1     0.5       0.3      0.3        
##   0.1   1     0.5       0.3      0.3        
##   0.1   1     0.5       0.3      0.3        
##   0.1   1     0.5       0.3      0.3        
##   0.1   1     0.5       0.3      0.3        
##   0.2   1     0.4       0.3      0.3        
##   0.2   1     0.4       0.3      0.3        
##   0.2   1     0.4       0.3      0.3        
##   0.2   1     0.4       0.3      0.3        
##   0.2   1     0.4       0.3      0.3        
##   0.2   1     0.4       0.3      0.3        
##   0.2   1     0.4       0.3      0.3        
##   0.2   1     0.4       0.3      0.3        
##   0.2   1     0.4       0.3      0.3        
##   0.2   1     0.4       0.3      0.3        
##   0.2   1     0.4       0.3      0.3        
##   0.3   1     0.4       0.3      0.3        
##   0.3   1     0.4       0.3      0.3        
##   0.3   1     0.4       0.3      0.3        
##   0.3   1     0.4       0.3      0.3        
##   0.3   1     0.4       0.3      0.3        
##   0.3   1     0.4       0.3      0.3        
##   0.3   1     0.4       0.3      0.3        
##   0.3   1     0.4       0.3      0.3        
##   0.3   1     0.4       0.3      0.3        
##   0.4   1     0.4       0.3      0.3        
##   0.4   1     0.4       0.3      0.3        
##   0.4   1     0.4       0.3      0.3        
##   0.4   1     0.4       0.3      0.3        
##   0.4   1     0.4       0.3      0.3        
##   0.4   1     0.4       0.3      0.3        
##   0.4   1     0.4       0.3      0.3        
##   0.4   1     0.4       0.3      0.3        
##   0.4   1     0.4       0.3      0.3        
##   0.4   1     0.4       0.3      0.3        
##   0.4   1     0.4       0.3      0.3        
##   0.5   1     0.4       0.3      0.3        
##   0.5   1     0.3       0.2      0.3        
##   0.5   1     0.3       0.2      0.2        
##   0.5   1     0.2       0.2      0.2        
##   0.5   1     0.1       0.2      0.1        
## 
## RMSE was used to select the optimal model using  the smallest value.
## The final value used for the model was cp = 0.1.
```


PROBLEM 3.2 - CROSS-VALIDATION  (2 points possible)
--------------------------------------------------------
Create a tree with this value of cp. You'll notice that this is actually quite similar to the first tree we created with the initial model. Interpret the tree: we predict the life expectancy to be 70 if the murder rate is greater than or equal to

and is less than

```r
set.seed(111)
CARTModelCV = rpart(Life.Exp ~ ., data = statedata, cp = 0.12)
prp(CARTModelCV)
```

![plot of chunk unnamed-chunk-13](figure/unnamed-chunk-13.png) 


Problem 3.3 - Cross-Validation (1/1 point)
-------------------------------------------------
Calculate the SSE of this tree:


```r
CARTModelCVPred <- predict(CARTModelCV, newdata = statedata)
sum((CARTModelCVPred - statedata$Life.Exp)^2)
```

```
## [1] 32.87
```


Problem 3.4 - Cross-Validation (1 point possible)
---------------------------------------------------------------
Recall the first tree (default parameters), second tree (minbucket = 5), and the third tree (selected with cross validation) we made. Given what you have learned about cross-validation, which of the three models would you expect to be better if we did use it for prediction on a test set? For this question, suppose we had actually set aside a few observations (states) in a test set, and we want to make predictions on those states.

The model with the "best" CP

Problem 3.5 - Cross-Validation (1 point possible)
------------------------------------------------------------
At the end of Part 2 we made a very complex tree using just Area. Use train with the same parameters as before but just using Area as an independent variable to find the best cp value (set the seed to 111 first). Then build a new tree using just Area and this value of cp.

```r
set.seed(111)
train(Life.Exp ~ Area, data = statedata, method = "rpart", trControl = fitControl, 
    tuneGrid = cartGrid)
```

```
## Warning: There were missing values in resampled performance measures.
```

```
## CART 
## 
## 50 samples
##  7 predictors
## 
## No pre-processing
## Resampling: Cross-Validated (10 fold) 
## 
## Summary of sample sizes: 45, 45, 46, 45, 45, 43, ... 
## 
## Resampling results across tuning parameters:
## 
##   cp    RMSE  Rsquared  RMSE SD  Rsquared SD
##   0.01  1     0.5       0.4      0.3        
##   0.02  1     0.5       0.4      0.3        
##   0.03  1     0.5       0.4      0.3        
##   0.04  1     0.5       0.4      0.3        
##   0.05  1     0.5       0.4      0.3        
##   0.06  1     0.5       0.4      0.3        
##   0.07  1     0.5       0.5      0.2        
##   0.08  1     0.5       0.5      0.2        
##   0.09  1     0.5       0.5      0.2        
##   0.1   1     0.5       0.5      0.2        
##   0.1   1     0.5       0.5      0.2        
##   0.1   1     0.5       0.5      0.2        
##   0.1   1     0.4       0.5      0.2        
##   0.1   1     0.4       0.5      0.2        
##   0.2   1     0.4       0.4      0.2        
##   0.2   1     0.4       0.4      0.1        
##   0.2   1     0.4       0.4      0.008      
##   0.2   1     0.4       0.4      0.008      
##   0.2   1     0.4       0.4      0.008      
##   0.2   1     0.4       0.4      0.008      
##   0.2   1     0.4       0.3      NA         
##   0.2   1     0.4       0.3      NA         
##   0.2   1     0.4       0.3      NA         
##   0.2   1     0.4       0.3      NA         
##   0.2   1     0.4       0.3      NA         
##   0.3   1     0.4       0.3      NA         
##   0.3   1     NaN       0.2      NA         
##   0.3   1     NaN       0.2      NA         
##   0.3   1     NaN       0.2      NA         
##   0.3   1     NaN       0.2      NA         
##   0.3   1     NaN       0.2      NA         
##   0.3   1     NaN       0.2      NA         
##   0.3   1     NaN       0.2      NA         
##   0.3   1     NaN       0.2      NA         
##   0.4   1     NaN       0.2      NA         
##   0.4   1     NaN       0.2      NA         
##   0.4   1     NaN       0.2      NA         
##   0.4   1     NaN       0.2      NA         
##   0.4   1     NaN       0.2      NA         
##   0.4   1     NaN       0.2      NA         
##   0.4   1     NaN       0.2      NA         
##   0.4   1     NaN       0.2      NA         
##   0.4   1     NaN       0.2      NA         
##   0.4   1     NaN       0.2      NA         
##   0.4   1     NaN       0.2      NA         
##   0.5   1     NaN       0.2      NA         
##   0.5   1     NaN       0.2      NA         
##   0.5   1     NaN       0.2      NA         
##   0.5   1     NaN       0.2      NA         
##   0.5   1     NaN       0.2      NA         
## 
## RMSE was used to select the optimal model using  the smallest value.
## The final value used for the model was cp = 0.02.
```

```r
CARTModelAreaCV = rpart(Life.Exp ~ Area, data = statedata, cp = 0.01)
prp(CARTModelAreaCV)
```

![plot of chunk unnamed-chunk-15](figure/unnamed-chunk-15.png) 


How many splits does the tree have?


Problem 3.6 - Cross-Validation (2 points possible)
-------------------------------------------------------------------
The lower left leaf (or bucket) corresponds to the lowest predicted Life.Exp, (70). Observations in this leaf correspond to states with area greater than _ and area less than _

Problem 3.7 - Cross-Validation (1 point possible)
-------------------------------------------------------------------
We have simplified the previous "Area tree" considerably by using cross-validation. Calculate the SSE of the cross-validated "Area tree", and select the correct statements:

```r
CARTModelAreaCVPred <- predict(CARTModelAreaCV, newdata = statedata)
sum((CARTModelAreaCVPred - statedata$Life.Exp)^2)
```

```
## [1] 44.27
```

ANS: The Area variable is not as predictive as Murder rate.
