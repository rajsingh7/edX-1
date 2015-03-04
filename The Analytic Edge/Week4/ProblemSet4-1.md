ProblemSet 4-1
========================================================
PROBLEM 1.1 - EXPLORATION AND LOGISTIC REGRESSION  (1 point possible)
We will first get familiar with the data. Load the CSV file gerber.csv into R. What proportion of people in this dataset voted in this election?


```r
gerber <- read.csv(file.choose())
table(gerber$voting)
```

```
## 
##      0      1 
## 235388 108696
```

```r
108696/(108696 + 235388)
```

```
## [1] 0.3159
```



PROBLEM 1.2 - EXPLORATION AND LOGISTIC REGRESSION  (1 point possible)
---------------------------------------------------------
Which of the four "treatment groups" had the largest fraction of voters?


```r
tapply(gerber$voting, gerber$civicduty, mean)
```

```
##      0      1 
## 0.3161 0.3145
```

```r
tapply(gerber$voting, gerber$hawthorne, mean)
```

```
##      0      1 
## 0.3151 0.3224
```

```r
tapply(gerber$voting, gerber$self, mean)
```

```
##      0      1 
## 0.3122 0.3452
```

```r
tapply(gerber$voting, gerber$neighbors, mean)
```

```
##      0      1 
## 0.3082 0.3779
```


PROBLEM 1.3 - EXPLORATION AND LOGISTIC REGRESSION  (1 point possible)
---------------------------------------------------------
Build a logistic regression model for voting using the four treatment group variables as the independent variables (civicduty, hawthorne, self, and neighbors). Use all the data to build the model (DO NOT split the data into a training set and testing set). Which of the following coefficients are significant in the logistic regression model?


```r
model0 <- glm(voting ~ civicduty + hawthorne + self + neighbors, data = gerber, 
    family = "binomial")
summary(model0)
```

```
## 
## Call:
## glm(formula = voting ~ civicduty + hawthorne + self + neighbors, 
##     family = "binomial", data = gerber)
## 
## Deviance Residuals: 
##    Min      1Q  Median      3Q     Max  
## -0.974  -0.869  -0.839   1.459   1.559  
## 
## Coefficients:
##             Estimate Std. Error z value Pr(>|z|)    
## (Intercept) -0.86336    0.00501 -172.46  < 2e-16 ***
## civicduty    0.08437    0.01210    6.97  3.1e-12 ***
## hawthorne    0.12048    0.01204   10.01  < 2e-16 ***
## self         0.22294    0.01187   18.79  < 2e-16 ***
## neighbors    0.36509    0.01168   31.26  < 2e-16 ***
## ---
## Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1
## 
## (Dispersion parameter for binomial family taken to be 1)
## 
##     Null deviance: 429238  on 344083  degrees of freedom
## Residual deviance: 428090  on 344079  degrees of freedom
## AIC: 428100
## 
## Number of Fisher Scoring iterations: 4
```



PROBLEM 1.4 - EXPLORATION AND LOGISTIC REGRESSION  (1 point possible)
---------------------------------------------------------
Using a threshold of 0.3, what is the accuracy of the logistic regression model? (When making predictions, you don't need to use the newdata argument since we didn't split our data.)


```r
model0Pred <- predict(model0, data = gerber, type = "response")
tb <- table(gerber$voting, model0Pred > 0.3)
(tb[1] + tb[4])/(tb[1] + tb[2] + tb[3] + tb[4])
```

```
## [1] 0.542
```


PROBLEM 1.5 - EXPLORATION AND LOGISTIC REGRESSION  (1 point possible)
---------------------------------------------------------
Using a threshold of 0.5, what is the accuracy of the logistic regression model?


```r
tb <- table(gerber$voting, model0Pred > 0.5)
tb[1]/(tb[1] + tb[2])
```

```
## [1] 0.6841
```


PROBLEM 1.6 - EXPLORATION AND LOGISTIC REGRESSION  (1 point possible)
---------------------------------------------------------
Compare your previous two answers to the percentage of people who did not vote (the baseline accuracy) and compute the AUC of the model. What is happening here?


```r
baseline = 1 - 108696/(108696 + 235388)
baseline
```

```
## [1] 0.6841
```

```r

library(ROCR)
```

```
## Warning: package 'ROCR' was built under R version 3.0.3
```

```
## Loading required package: gplots
```

```
## Warning: package 'gplots' was built under R version 3.0.3
```

```
## KernSmooth 2.23 loaded
## Copyright M. P. Wand 1997-2009
## 
## Attaching package: 'gplots'
## 
## 下列对象被屏蔽了from 'package:stats':
## 
##     lowess
```

```r
ROCRpred = prediction(model0Pred, gerber$voting)
# ROCRperf = performance(ROCRpred, 'tpr', 'fpr') plot(ROCRperf,
# colorize=TRUE)
ROCRauc = performance(ROCRpred, "auc")
ROCRauc
```

```
## An object of class "performance"
## Slot "x.name":
## [1] "None"
## 
## Slot "y.name":
## [1] "Area under the ROC curve"
## 
## Slot "alpha.name":
## [1] "none"
## 
## Slot "x.values":
## list()
## 
## Slot "y.values":
## [[1]]
## [1] 0.5308
## 
## 
## Slot "alpha.values":
## list()
```


Even though all of the variables are significant, this is a weak predictive model.

PROBLEM 2.1 - TREES  (1 point possible)
---------------------------------------------------------
We will now try out trees. Build a CART tree for voting using all data and the same four treatment variables we used before. Don't set the option method="class" - we are actually going to create a regression tree here. We are interested in building a tree to explore the fraction of people who vote, or the probability of voting. We’d like CART to split our groups if they have different probabilities of voting. If we used method=‘class’, CART would only split if one of the groups had a probability of voting above 50% and the other had a probability of voting less than 50% (since the predicted outcomes would be different). However, with regression trees, CART will split even if both groups have probability less than 50%.

Leave all the parameters at their default values. You can use the following command in R to build the tree:

```r
CARTmodel = rpart(voting ~ civicduty + hawthorne + self + neighbors, data = gerber)
```

```
## Error: 没有"rpart"这个函数
```

```r
prp(CARTmodel)
```

```
## Error: 没有"prp"这个函数
```

Plot the tree. What happens, and if relevant, why?

No variables are used (the tree is only a root node) - none of the variables make a big enough effect to be split on. 

PROBLEM 2.2 - TREES  (1 point possible)
-----------------------------------------------------------------
Now build the tree using the command:

```r
CARTmodel2 = rpart(voting ~ civicduty + hawthorne + self + neighbors, data = gerber, 
    cp = 0)
```

```
## Error: 没有"rpart"这个函数
```

```r
prp(CARTmodel2)
```

```
## Error: 没有"prp"这个函数
```

to force the complete tree to be built. Then plot the tree. What do you observe about the order of the splits?

Neighbor is the first split, civic duty is the last

PROBLEM 2.3 - TREES  (1 point possible)
----------------------------------------------------------------
Using only the CART tree plot, determine what fraction (a number between 0 and 1) of "Civic Duty" people voted:

0.31

PROBLEM 2.4 - TREES  (2 points possible)
----------------------------------------------------------------
Make a new tree that includes the "sex" variable, again with cp = 0.0. Notice that sex appears as a split that is of secondary importance to the treatment group.

```r
CARTmodel3 = rpart(voting ~ civicduty + hawthorne + self + neighbors + sex, 
    data = gerber, cp = 0)
```

```
## Error: 没有"rpart"这个函数
```

```r
prp(CARTmodel3)
```

```
## Error: 没有"prp"这个函数
```


In the control group, which gender is more likely to vote?
Men(0)
In the "Civic Duty" group, which gender is more likely to vote?
Men(0)

PROBLEM 3.1 - INTERACTION TERMS  (1 point possible)
----------------------------------------------------
We know trees can handle "nonlinear" relationships, e.g. "in the 'Civic Duty' group and female", but as we will see in the next few questions, it is possible to do the same for logistic regression. First, let's explore what trees can tell us some more.

Let's just focus on the "Control" treatment group. Create a regression tree using just the "control" variable, then create another tree with the "control" and "sex" variables, both with cp=0.0.


```r
CARTmodel4 = rpart(voting ~ control, data = gerber, cp = 0)
```

```
## Error: 没有"rpart"这个函数
```

```r
prp(CARTmodel4, digits = 6)
```

```
## Error: 没有"prp"这个函数
```

```r

CARTmodel5 = rpart(voting ~ control + sex, data = gerber, cp = 0)
```

```
## Error: 没有"rpart"这个函数
```

```r
prp(CARTmodel5, digits = 6)
```

```
## Error: 没有"prp"这个函数
```


In the "control" only tree, what is the difference in the predicted probability of voting between being in the control group versus being in a different group, i.e. (Control Prediction - Non-Control Prediction)? Add the argument "digits = 6" to the prp command to get a more accurate estimate.

PROBLEM 3.2 - INTERACTION TERMS  (1 point possible)
---------------------------------------------------------
Now, using the second tree (with control and sex), determine who is affected more by NOT being in the control group (being in any of the four treatment groups):

They are affected about the same (change in probability within 0.001 of each other). 

PROBLEM 3.3 - INTERACTION TERMS  (1 point possible)
---------------------------------------------------------
Going back to logistic regression now, create a model using "sex" and "control". Interpret the coefficient for "sex":


```r
model1 <- glm(voting ~ sex + control, data = gerber, family = "binomial")
summary(model1)
```

```
## 
## Call:
## glm(formula = voting ~ sex + control, family = "binomial", data = gerber)
## 
## Deviance Residuals: 
##    Min      1Q  Median      3Q     Max  
## -0.922  -0.901  -0.829   1.456   1.572  
## 
## Coefficients:
##             Estimate Std. Error z value Pr(>|z|)    
## (Intercept) -0.63554    0.00651   -97.6   <2e-16 ***
## sex         -0.05579    0.00734    -7.6    3e-14 ***
## control     -0.20014    0.00736   -27.2   <2e-16 ***
## ---
## Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1
## 
## (Dispersion parameter for binomial family taken to be 1)
## 
##     Null deviance: 429238  on 344083  degrees of freedom
## Residual deviance: 428443  on 344081  degrees of freedom
## AIC: 428449
## 
## Number of Fisher Scoring iterations: 4
```


Coefficient is negative, reflecting that women are less likely to vote

PROBLEM 3.4 - INTERACTION TERMS  (1 point possible)
--------------------------------------------------------------
The regression tree calculated the percentage voting exactly for every one of the four possibilities (Man, Not Control), (Man, Control), (Woman, Not Control), (Woman, Control). Logistic regression has attempted to do the same, although it wasn't able to do as well because it can't consider exactly the joint possibility of being a women and in the control group.

We can quantify this precisely. Create the following dataframe (this contains all of the possible values of sex and control), and evaluate your logistic regression using the predict function


```r
Possibilities = data.frame(sex = c(0, 0, 1, 1), control = c(0, 1, 0, 1))
predict(model1, newdata = Possibilities, type = "response")
```

```
##      1      2      3      4 
## 0.3463 0.3024 0.3337 0.2908
```


The four values in the results correspond to the four possibilities in the order they are stated above ( (Man, Not Control), (Man, Control), (Woman, Not Control), (Woman, Control) ). What is the absolute difference between the tree and the logistic regression for the (Woman, Control) case? Give an answer with five numbers after the decimal point.



```r
abs(0.290456 - 0.2908065)
```

```
## [1] 0.0003505
```


PROBLEM 3.5 - INTERACTION TERMS  (1 point possible)
----------------------------------------------------------
So the difference is not too big for this dataset, but it is there. We're going to add a new term to our logistic regression now, that is the combination of the "sex" and "control" variables - so if this new variable is 1, that means the person is a woman AND in the control group. We can do that with the following command:


```r
model2 = glm(voting ~ sex + control + sex:control, data = gerber, family = "binomial")
summary(model2)
```

```
## 
## Call:
## glm(formula = voting ~ sex + control + sex:control, family = "binomial", 
##     data = gerber)
## 
## Deviance Residuals: 
##    Min      1Q  Median      3Q     Max  
## -0.921  -0.902  -0.828   1.457   1.573  
## 
## Coefficients:
##             Estimate Std. Error z value Pr(>|z|)    
## (Intercept) -0.63747    0.00760  -83.84  < 2e-16 ***
## sex         -0.05189    0.01080   -4.80  1.6e-06 ***
## control     -0.19655    0.01036  -18.98  < 2e-16 ***
## sex:control -0.00726    0.01473   -0.49     0.62    
## ---
## Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1
## 
## (Dispersion parameter for binomial family taken to be 1)
## 
##     Null deviance: 429238  on 344083  degrees of freedom
## Residual deviance: 428442  on 344080  degrees of freedom
## AIC: 428450
## 
## Number of Fisher Scoring iterations: 4
```


How do you interpret the coefficient for the new variable in isolation? That is, how does it relate to the dependent variable?


PROBLEM 3.6 - INTERACTION TERMS  (1 point possible)
---------------------------------------------------------
Run the same code as before to calculate the average for each group:


```r
predict(model2, newdata = Possibilities, type = "response")
```

```
##      1      2      3      4 
## 0.3458 0.3028 0.3342 0.2905
```

```r
abs(0.290456 - 0.2904558)
```

```
## [1] 2e-07
```


PROBLEM 3.7 - INTERACTION TERMS  (1 point possible)
--------------------------------------------------------
This example has shown that trees can capture nonlinear relationships that logistic regression can not, but that we can get around this sometimes by using variables that are the combination of two variables. Should we always include all possible interaction terms of the independent variables when building a logistic regression model?

Now what is the difference between the logistic regression model and the CART model for the (Woman, Control) case? Again, give your answer with five numbers after the decimal point.
