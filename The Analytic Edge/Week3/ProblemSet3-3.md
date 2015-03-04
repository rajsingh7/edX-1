Problem Set 3-3
========================================================
PROBLEM 1.1 - LOADING THE DATASET  (1 point possible)
Load the dataset parole.csv into a data frame called parole, and investigate it using the str() and summary() functions.

How many parolees are contained in the dataset?


```r
parole <- read.csv(file.choose())
str(parole)
```

```
## 'data.frame':	675 obs. of  9 variables:
##  $ male             : int  1 0 1 1 1 1 1 0 0 1 ...
##  $ race             : int  1 1 2 1 2 2 1 1 1 2 ...
##  $ age              : num  33.2 39.7 29.5 22.4 21.6 46.7 31 24.6 32.6 29.1 ...
##  $ state            : int  1 1 1 1 1 1 1 1 1 1 ...
##  $ time.served      : num  5.5 5.4 5.6 5.7 5.4 6 6 4.8 4.5 4.7 ...
##  $ max.sentence     : int  18 12 12 18 12 18 18 12 13 12 ...
##  $ multiple.offenses: int  0 0 0 0 0 0 0 0 0 0 ...
##  $ crime            : int  4 3 3 1 1 4 3 1 3 2 ...
##  $ violator         : int  0 0 0 0 0 0 0 0 0 0 ...
```

```r
summary(parole)
```

```
##       male            race           age           state     
##  Min.   :0.000   Min.   :1.00   Min.   :18.4   Min.   :1.00  
##  1st Qu.:1.000   1st Qu.:1.00   1st Qu.:25.4   1st Qu.:2.00  
##  Median :1.000   Median :1.00   Median :33.7   Median :3.00  
##  Mean   :0.807   Mean   :1.42   Mean   :34.5   Mean   :2.89  
##  3rd Qu.:1.000   3rd Qu.:2.00   3rd Qu.:42.5   3rd Qu.:4.00  
##  Max.   :1.000   Max.   :2.00   Max.   :67.0   Max.   :4.00  
##   time.served    max.sentence  multiple.offenses     crime     
##  Min.   :0.00   Min.   : 1.0   Min.   :0.000     Min.   :1.00  
##  1st Qu.:3.25   1st Qu.:12.0   1st Qu.:0.000     1st Qu.:1.00  
##  Median :4.40   Median :12.0   Median :1.000     Median :2.00  
##  Mean   :4.20   Mean   :13.1   Mean   :0.536     Mean   :2.06  
##  3rd Qu.:5.20   3rd Qu.:15.0   3rd Qu.:1.000     3rd Qu.:3.00  
##  Max.   :6.00   Max.   :18.0   Max.   :1.000     Max.   :4.00  
##     violator    
##  Min.   :0.000  
##  1st Qu.:0.000  
##  Median :0.000  
##  Mean   :0.116  
##  3rd Qu.:0.000  
##  Max.   :1.000
```


------------------------------
PROBLEM 1.2 - LOADING THE DATASET  (1 point possible)
How many of the parolees in the dataset violated the terms of their parole?


```r
table(parole$violator)
```

```
## 
##   0   1 
## 597  78
```


------------------------------
PROBLEM 1.3 - LOADING THE DATASET  (1 point possible)
You should be familiar with unordered factors (if not, review the Week 2 homework problem "Reading Test Scores"). Which variables in this dataset are unordered factors with at least three levels?

male race age state time.served max.sentence multiple.offenses crime violator

```r
unique(parole$male)
```

```
## [1] 1 0
```

```r
unique(parole$race)
```

```
## [1] 1 2
```

```r
unique(parole$age)
```

```
##   [1] 33.2 39.7 29.5 22.4 21.6 46.7 31.0 24.6 32.6 29.1 28.4 20.5 30.1 37.8
##  [15] 41.7 43.5 42.3 21.3 24.5 31.6 35.4 41.9 38.9 23.0 32.8 32.4 29.7 28.7
##  [29] 50.2 25.9 49.9 47.1 36.7 37.2 23.2 31.4 39.1 50.6 36.3 29.9 27.5 28.1
##  [43] 34.2 36.5 33.5 55.0 31.2 39.6 37.3 21.1 34.9 24.9 61.6 48.0 21.4 54.5
##  [57] 38.8 20.2 41.4 48.2 32.2 33.7 35.0 57.5 42.4 25.3 37.5 22.3 40.1 40.3
##  [71] 43.6 20.6 34.8 25.0 39.0 30.8 37.4 41.1 26.6 51.1 27.7 25.7 22.0 26.9
##  [85] 47.2 31.5 21.0 24.2 22.6 51.2 41.0 27.0 21.9 21.5 18.8 32.5 24.3 50.5
##  [99] 23.4 45.0 41.3 43.4 40.4 23.3 18.7 32.0 28.3 35.1 39.8 29.0 36.2 44.4
## [113] 32.3 45.9 26.8 56.8 48.9 39.2 38.3 25.6 30.2 53.5 43.0 21.8 32.7 26.3
## [127] 44.0 27.4 19.2 19.5 46.1 46.3 45.1 45.4 48.5 48.7 39.4 20.7 46.5 43.8
## [141] 41.2 38.7 44.9 44.7 48.8 37.0 35.5 35.2 35.9 28.8 45.8 34.5 38.4 28.9
## [155] 51.4 26.4 30.7 27.3 23.7 52.5 38.1 28.0 49.3 27.2 21.2 25.8 23.6 21.7
## [169] 19.9 22.5 20.3 42.1 43.2 43.3 30.0 20.0 22.8 31.1 18.4 25.5 34.1 35.8
## [183] 47.5 54.4 39.9 31.3 35.6 51.8 44.8 26.0 19.6 48.4 63.4 20.9 34.7 19.4
## [197] 33.3 54.9 19.1 61.4 25.1 59.4 56.4 53.0 54.8 52.1 47.7 42.0 33.9 26.5
## [211] 58.5 53.9 42.6 24.0 50.9 44.6 36.1 30.3 55.7 19.7 29.6 34.6 45.5 44.3
## [225] 53.8 47.8 23.1 42.5 20.8 31.7 34.4 31.8 39.5 29.2 46.0 38.0 40.8 33.8
## [239] 52.6 38.6 22.1 46.9 40.9 27.1 36.6 28.5 24.7 18.5 32.9 45.6 33.4 20.4
## [253] 51.7 46.4 27.9 23.8 34.3 65.1 46.2 32.1 67.0 41.6 47.0 49.0 35.3 50.1
## [267] 42.8 25.2 51.3 44.1 22.9 27.8 51.0 24.4 36.8 38.5 24.8 38.2 28.2 36.0
## [281] 19.0 37.6 46.6 30.4 40.0 43.1 33.6 27.6 33.0 44.2 40.6 34.0 22.2 19.3
## [295] 43.7 46.8 47.3 54.1 44.5 56.5 36.4 25.4
```

```r
unique(parole$state)
```

```
## [1] 1 2 3 4
```

```r
unique(parole$time.served)
```

```
##  [1] 5.5 5.4 5.6 5.7 6.0 4.8 4.5 4.7 5.9 5.3 5.2 5.1 5.8 4.9 3.9 0.5 0.9
## [18] 2.0 0.7 0.0 3.0 3.8 4.2 4.4 4.6 0.1 4.3 4.1 3.7 2.1 0.2 1.2 3.6 4.0
## [35] 2.5 2.6 3.2 3.5 5.0 3.4 1.8 2.4 1.1 2.7 2.9 0.8 2.2 2.8 1.3 1.7 1.9
## [52] 1.6 0.3 1.4 3.1 1.5 3.3 2.3
```

```r
unique(parole$max.sentence)
```

```
##  [1] 18 12 13 16  8 15 14  1  9 10  3  4  6  2 11  5 17
```

```r
unique(parole$multiple.offenses)
```

```
## [1] 0 1
```

```r
unique(parole$crime)
```

```
## [1] 4 3 1 2
```

```r
unique(parole$violator)
```

```
## [1] 0 1
```


ans state and crime

------------------------------

PROBLEM 2.1 - PREPARING THE DATASET  (1 point possible)
In the last subproblem, we identified variables that are unordered factors with at least 3 levels, so we need to convert them to factors for our prediction problem (we introduced this idea in the "Reading Test Scores" problem last week). Using the as.factor() function, convert these variables to factors. Keep in mind that we are not changing the values, just the way R understands them (the values are still numbers).

How does the output of summary() change for a factor variable as compared to a numerical variable?


```r
summary(parole)
```

```
##       male            race           age           state     
##  Min.   :0.000   Min.   :1.00   Min.   :18.4   Min.   :1.00  
##  1st Qu.:1.000   1st Qu.:1.00   1st Qu.:25.4   1st Qu.:2.00  
##  Median :1.000   Median :1.00   Median :33.7   Median :3.00  
##  Mean   :0.807   Mean   :1.42   Mean   :34.5   Mean   :2.89  
##  3rd Qu.:1.000   3rd Qu.:2.00   3rd Qu.:42.5   3rd Qu.:4.00  
##  Max.   :1.000   Max.   :2.00   Max.   :67.0   Max.   :4.00  
##   time.served    max.sentence  multiple.offenses     crime     
##  Min.   :0.00   Min.   : 1.0   Min.   :0.000     Min.   :1.00  
##  1st Qu.:3.25   1st Qu.:12.0   1st Qu.:0.000     1st Qu.:1.00  
##  Median :4.40   Median :12.0   Median :1.000     Median :2.00  
##  Mean   :4.20   Mean   :13.1   Mean   :0.536     Mean   :2.06  
##  3rd Qu.:5.20   3rd Qu.:15.0   3rd Qu.:1.000     3rd Qu.:3.00  
##  Max.   :6.00   Max.   :18.0   Max.   :1.000     Max.   :4.00  
##     violator    
##  Min.   :0.000  
##  1st Qu.:0.000  
##  Median :0.000  
##  Mean   :0.116  
##  3rd Qu.:0.000  
##  Max.   :1.000
```



```r
parole$state <- as.factor(parole$state)
parole$crime <- as.factor(parole$crime)
summary(parole)
```

```
##       male            race           age       state    time.served  
##  Min.   :0.000   Min.   :1.00   Min.   :18.4   1:143   Min.   :0.00  
##  1st Qu.:1.000   1st Qu.:1.00   1st Qu.:25.4   2:120   1st Qu.:3.25  
##  Median :1.000   Median :1.00   Median :33.7   3: 82   Median :4.40  
##  Mean   :0.807   Mean   :1.42   Mean   :34.5   4:330   Mean   :4.20  
##  3rd Qu.:1.000   3rd Qu.:2.00   3rd Qu.:42.5           3rd Qu.:5.20  
##  Max.   :1.000   Max.   :2.00   Max.   :67.0           Max.   :6.00  
##   max.sentence  multiple.offenses crime      violator    
##  Min.   : 1.0   Min.   :0.000     1:315   Min.   :0.000  
##  1st Qu.:12.0   1st Qu.:0.000     2:106   1st Qu.:0.000  
##  Median :12.0   Median :1.000     3:153   Median :0.000  
##  Mean   :13.1   Mean   :0.536     4:101   Mean   :0.116  
##  3rd Qu.:15.0   3rd Qu.:1.000             3rd Qu.:0.000  
##  Max.   :18.0   Max.   :1.000             Max.   :1.000
```


ans The output becomes similar to that of the table() function applied to that variable

------------------------------
PROBLEM 2.2 - PREPARING THE DATASET  (1 point possible)
Why are we taking this step of preparing the variables before splitting the data into a training and testing set?

ans Preparing the data before splitting the dataset saves work: we only need to do these steps once instead of twice 

------------------------------
PROBLEM 3.1 - SPLITTING INTO A TRAINING AND TESTING SET  (1 point possible)
To ensure consistent training/testing set splits, run the following 5 lines of code (do not include the line numbers at the beginning):


```r
set.seed(144)
library(caTools)
```

```
## Warning: package 'caTools' was built under R version 3.0.3
```

```r
split = sample.split(parole$violator, SplitRatio = 0.7)
train = subset(parole, split == TRUE)
test = subset(parole, split == FALSE)
```

Roughly what proportion of parolees have been allocated to the training and testing sets?

```r
nrow(train)/(nrow(test) + nrow(train))
```

```
## [1] 0.7007
```

```r
nrow(test)/(nrow(test) + nrow(train))
```

```
## [1] 0.2993
```


------------------------------
Problem 3.2 - Splitting into a Training and Testing Set 
 
(3 points possible)
 
Now, suppose you re-ran lines [1]-[5] of Problem 3.1. What would you expect?

ANS The exact same training/testing set split as the first execution of [1]-[5] 

If you instead ONLY re-ran lines [3]-[5], what would you expect?
ANS A different training/testing set split from the first execution of [1]-[5] 

If you instead called set.seed() with a different number and then re-ran lines [3]-[5] of Problem 3.1, what would you expect?
ANS A different training/testing set split from the first execution of [1]-[5] 

------------------------------
PROBLEM 4.1 - BUILDING A LOGISTIC REGRESSION MODEL  (1 point possible)
If you tested other training/testing set splits in the previous section, please re-run the original 5 lines of code to obtain the original split.

Using glm (and remembering the parameter family="binomial"), train a logistic regression model on the training set. Your dependent variable is "violator", and you should use all of the other variables as independent variables.


```r
model0 <- glm(violator ~ ., data = train, family = "binomial")
```


What variables are significant in this model? Significant variables should have a least one star, or should have a probability less than 0.05 (the column Pr(>|z|) in the summary output).

```r
summary(model0)
```

```
## 
## Call:
## glm(formula = violator ~ ., family = "binomial", data = train)
## 
## Deviance Residuals: 
##    Min      1Q  Median      3Q     Max  
## -1.704  -0.424  -0.272  -0.169   2.837  
## 
## Coefficients:
##                    Estimate Std. Error z value Pr(>|z|)    
## (Intercept)       -4.241157   1.293885   -3.28    0.001 ** 
## male               0.386990   0.437961    0.88    0.377    
## race               0.886719   0.395066    2.24    0.025 *  
## age               -0.000176   0.016085   -0.01    0.991    
## state2             0.443301   0.481662    0.92    0.357    
## state3             0.834980   0.556270    1.50    0.133    
## state4            -3.396788   0.611586   -5.55  2.8e-08 ***
## time.served       -0.123887   0.120423   -1.03    0.304    
## max.sentence       0.080295   0.055375    1.45    0.147    
## multiple.offenses  1.611992   0.385305    4.18  2.9e-05 ***
## crime2             0.683714   0.500355    1.37    0.172    
## crime3            -0.278105   0.432836   -0.64    0.521    
## crime4            -0.011763   0.571304   -0.02    0.984    
## ---
## Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1
## 
## (Dispersion parameter for binomial family taken to be 1)
## 
##     Null deviance: 340.04  on 472  degrees of freedom
## Residual deviance: 251.48  on 460  degrees of freedom
## AIC: 277.5
## 
## Number of Fisher Scoring iterations: 6
```

ans : race state4 multiple.offenses

------------------------------
PROBLEM 4.2 - BUILDING A LOGISTIC REGRESSION MODEL  (1 point possible)
What can we say based on the coefficient of the multiple.offenses variable?

The following two properties might be useful to you when answering this question:

1) If we have a coefficient c for a variable, then that means the log odds (or Logit) are increased by c for a unit increase in the variable.

2) If we have a coefficient c for a variable, then that means the odds are multiplied by e^c for a unit increase in the variable.

```r
exp(1.6119919)
```

```
## [1] 5.013
```


ANS Our model predicts that a parolee who committed multiple offenses has 5.01 times higher odds of being a violator than a parolee who did not commit multiple offenses but is otherwise identical. Status: correct 

------------------------------
PROBLEM 4.3 - BUILDING A LOGISTIC REGRESSION MODEL  (2 points possible)
Consider a parolee who is male, of white race, aged 50 years at prison release, from the state of Maryland, served 3 months, had a maximum sentence of 12 months, did not commit multiple offenses, and committed a larceny. Answer the following questions based on the model's predictions for this individual. (HINT: You should use the coefficients of your model, the Logistic Response Function, and the Odds equation to solve this problem.)

According to the model, what are the odds this individual is a violator?

According to the model, what is the probability this individual is a violator?

```r
y = -4.2411574 + 0.3869904 + 0.8867192 - 0.0001756 * 50 - 0.1238867 * 3 + 12 * 
    0.0802954 + 0.6837143
odds = exp(y)
logit = log(odds)
Py = 1/(1 + exp(-1 * y))
```


------------------------------
Problem 5.1 - Evaluating the Model on the Testing Set 
 
(1 point possible)
 
Use the predict() function to obtain the model's predicted probabilities for parolees in the testing set, remembering to pass type="response".

What is the maximum predicted probability of a violation?

```r
parolePred <- predict(model0, newdata = test, type = "response")
summary(parolePred)
```

```
##    Min. 1st Qu.  Median    Mean 3rd Qu.    Max. 
##  0.0023  0.0238  0.0579  0.1470  0.1470  0.9070
```


------------------------------
PROBLEM 5.2 - EVALUATING THE MODEL ON THE TESTING SET (3 points possible)
In the following questions, evaluate the model's predictions on the test set using a threshold of 0.5.

What is the model's sensitivity?
What is the model's specificity?
What is the model's accuracy?

```r
TN = table(test$violator, parolePred > 0.5)[1]
FN = table(test$violator, parolePred > 0.5)[2]
FP = table(test$violator, parolePred > 0.5)[3]
TP = table(test$violator, parolePred > 0.5)[4]
Sen = TP/(TP + FN)
Sen
```

```
## [1] 0.5217
```

```r
Spec = TN/(TN + FP)
Spec
```

```
## [1] 0.933
```

```r
Acc = (TN + TP)/(TN + TP + FN + FP)
Acc
```

```
## [1] 0.8861
```


------------------------------
Problem 5.3 - Evaluating the Model on the Testing Set 
 
(1 point possible)
 
What is the accuracy of a simple model that predicts that every parolee is a non-violator? 

```r
Baseline = (TN + FP)/(TN + TP + FN + FP)
Baseline
```

```
## [1] 0.8861
```


------------------------------

PROBLEM 5.4 - EVALUATING THE MODEL ON THE TESTING SET (1 point possible)
Consider a parole board using the model to predict whether parolees will be violators or not. Which of the following most likely describes their preferences and best course of action?


```r
table(test$violator, parolePred > 0.5)
```

```
##    
##     FALSE TRUE
##   0   167   12
##   1    11   12
```

```r
table(test$violator, parolePred > 0.7)
```

```
##    
##     FALSE TRUE
##   0   176    3
##   1    20    3
```

```r
table(test$violator, parolePred > 0.3)
```

```
##    
##     FALSE TRUE
##   0   160   19
##   1     9   14
```


ANS The board assigns more cost to a false negative than a false positive, and should therefore use a logistic regression cutoff less than 0.5.

------------------------------
Problem 5.5 - Evaluating the Model on the Testing Set 
 
(1 point possible)
 
Which of the following is the most accurate assessment of the value of the logistic regression model with a cutoff 0.5 to a parole board, based on the model's accuracy as compared to the simple baseline model?

ANS The model is likely of value to the board, and using a different logistic regression cutoff is likely to improve the model's value.

------------------------------
Problem 5.6 - Evaluating the Model on the Testing Set 
 
(1 point possible)
 
Using the ROCR package, what is the AUC value for the model?


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
ROCRpred = prediction(parolePred, test$violator)
ROCRperf = performance(ROCRpred, "tpr", "fpr")
plot(ROCRperf, colorize = TRUE)
```

![plot of chunk unnamed-chunk-16](figure/unnamed-chunk-16.png) 

```r
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
## [1] 0.8946
## 
## 
## Slot "alpha.values":
## list()
```


------------------------------
Problem 5.7 - Evaluating the Model on the Testing Set 
 
(1 point possible)
 
Describe the meaning of AUC in this context.

ANS The probability the model can correctly differentiate between a randomly selected parole violator and a randomly selected parole non-violator. 

------------------------------
PROBLEM 6.1 - IDENTIFYING BIAS IN OBSERVATIONAL DATA  (1 point possible)
Our goal has been to predict the outcome of a parole decision, and we used a publicly available dataset of parole releases for predictions. In this final problem, we'll evaluate a potential source of bias associated with our analysis. It is always important to evaluate a dataset for possible sources of bias.

The dataset contains all individuals released from parole in 2004, either due to completing their parole term or violating the terms of their parole. However, it does not contain parolees who neither violated their parole nor completed their term in 2004, causing non-violators to be underrepresented. This is called "selection bias" or "selecting on the dependent variable," because only a subset of all relevant parolees were included in our analysis, based on our dependent variable in this analysis (parole violation). How could we improve our dataset to best address selection bias?

ANS We should use a dataset tracking a group of parolees from the start of their parole until either they violated parole or they completed their term. 
