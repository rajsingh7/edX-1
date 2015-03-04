Final Exam 1
========================================================
##FORECASTING ELANTRA SALES

An important application of the predictive models studied in this course is to understanding sales. Consider a company that produces and sells a product. In a given period, if the company produces more units than how many consumers will buy, the company will not earn money on the unsold units and will incur additional costs due to having to store those units in inventory before they can be sold. If it produces fewer units than how many consumers will buy, the company will earn less than it potentially could have earned. Being able to predict consumer sales, therefore, is of first order importance to the company.

In this problem, we will try to predict monthly sales of the Hyundai Elantra in the United States. The Hyundai Motor Company is a major automobile manufacturer based in South Korea. The Elantra is a car model that has been produced by Hyundai since 1990 and is sold all over the world, including the United States. We will build a simple model to predict monthly sales using economic indicators of the United States as well as Google search queries.

The file elantra.csv contains data for the problem. Each observation is a month, from January 2010 to February 2014. For each month, we have the following variables:

Month: the month of the year for the observation (1 = January, 2 = February, 3 = March, ...).
Year: the year of the observation.
ElantraSales: the number of units of the Hyundai Elantra sold in the United States in the given month.
Unemployment: the estimated unemployment percentage in the United States in the given month.
Queries: a (normalized) approximation of the number of Google searches for "hyundai elantra" in the given month.
CPI_energy: the monthly consumer price index (CPI) for energy for the given month.
CPI_all: the consumer price index (CPI) for all products for the given month; this is a measure of the magnitude of the prices paid by consumer households for goods and services (e.g., food, clothing, electricity, etc.).
###PROBLEM 1 - LOADING THE DATA  (1 point possible)
Load the data set. Split the data set into training and testing sets as follows: place all observations for 2012 and earlier in the training set, and all observations for 2013 and on into the testing set.

How many observations are in the training set?

```r
data <- read.csv("elantra.csv")
train <- subset(data, data$Year <= 2012)
test <- subset(data, data$Year > 2012)
nrow(train)
```

```
## [1] 36
```


###PROBLEM 2 - A LINEAR REGRESSION MODEL  (1 point possible)
Build a linear regression model to predict monthly Elantra sales using Unemployment, CPI_all, CPI_energy and Queries. Use all of the training set data to do this.


```r
lm1 <- lm(ElantraSales ~ Unemployment + CPI_all + CPI_energy + Queries, data = train)
```


What is the model R-squared? Note: In this problem, we will always be asking for the "Multiple R-Squared" of the model.


```r
summary(lm1)
```

```
## 
## Call:
## lm(formula = ElantraSales ~ Unemployment + CPI_all + CPI_energy + 
##     Queries, data = train)
## 
## Residuals:
##    Min     1Q Median     3Q    Max 
##  -6785  -2102   -563   2902   7021 
## 
## Coefficients:
##              Estimate Std. Error t value Pr(>|t|)
## (Intercept)   95385.4   170663.8    0.56     0.58
## Unemployment  -3179.9     3610.3   -0.88     0.39
## CPI_all        -297.6      704.8   -0.42     0.68
## CPI_energy       38.5      109.6    0.35     0.73
## Queries          19.0       11.3    1.69     0.10
## 
## Residual standard error: 3290 on 31 degrees of freedom
## Multiple R-squared:  0.428,	Adjusted R-squared:  0.354 
## F-statistic:  5.8 on 4 and 31 DF,  p-value: 0.00132
```


###PROBLEM 3 - SIGNIFICANT VARIABLES  (1 point possible)
Which variables are significant, or have levels that are significant? Use 0.10 as your p-value cutoff. You can select 0-4 of the variables here.


```r
summary(lm1)
```

```
## 
## Call:
## lm(formula = ElantraSales ~ Unemployment + CPI_all + CPI_energy + 
##     Queries, data = train)
## 
## Residuals:
##    Min     1Q Median     3Q    Max 
##  -6785  -2102   -563   2902   7021 
## 
## Coefficients:
##              Estimate Std. Error t value Pr(>|t|)
## (Intercept)   95385.4   170663.8    0.56     0.58
## Unemployment  -3179.9     3610.3   -0.88     0.39
## CPI_all        -297.6      704.8   -0.42     0.68
## CPI_energy       38.5      109.6    0.35     0.73
## Queries          19.0       11.3    1.69     0.10
## 
## Residual standard error: 3290 on 31 degrees of freedom
## Multiple R-squared:  0.428,	Adjusted R-squared:  0.354 
## F-statistic:  5.8 on 4 and 31 DF,  p-value: 0.00132
```



###PROBLEM 4 - COEFFICIENTS  (1 point possible)
What is the coefficient of the Unemployment variable?


```r
summary(lm1)
```

```
## 
## Call:
## lm(formula = ElantraSales ~ Unemployment + CPI_all + CPI_energy + 
##     Queries, data = train)
## 
## Residuals:
##    Min     1Q Median     3Q    Max 
##  -6785  -2102   -563   2902   7021 
## 
## Coefficients:
##              Estimate Std. Error t value Pr(>|t|)
## (Intercept)   95385.4   170663.8    0.56     0.58
## Unemployment  -3179.9     3610.3   -0.88     0.39
## CPI_all        -297.6      704.8   -0.42     0.68
## CPI_energy       38.5      109.6    0.35     0.73
## Queries          19.0       11.3    1.69     0.10
## 
## Residual standard error: 3290 on 31 degrees of freedom
## Multiple R-squared:  0.428,	Adjusted R-squared:  0.354 
## F-statistic:  5.8 on 4 and 31 DF,  p-value: 0.00132
```


###PROBLEM 5 - INTERPRETING THE COEFFICIENT  (1 point possible)
What is the interpretation of this coefficient?

For an increase of 1 in Unemployment, the prediction of Elantra sales decreases by approximately 3000. 

###PROBLEM 6 - MODELING SEASONALITY  (1 point possible)
Our model R-Squared is relatively low, so we would now like to improve our model. In modeling demand and sales, it is often useful to model seasonality. Seasonality refers to the fact that demand is often cyclical/periodic in time. For example, in countries with different seasons, demand for warm outerwear (like jackets and coats) is higher in fall/autumn and winter (due to the colder weather) than in spring and summer. (In contrast, demand for swimsuits and sunscreen is higher in the summer than in the other seasons.) Another example is the "back to school" period in North America: demand for stationary (pencils, notebooks and so on) in late July and all of August is higher than the rest of the year due to the start of the school year in September.

In our problem, since our data includes the month of the year in which the units were sold, it is feasible for us to incorporate monthly seasonality. From a modeling point of view, it may be reasonable that the month plays an effect in how many Elantra units are sold.

To incorporate the seasonal effect due to the month, build a new linear regression model that predicts monthly Elantra sales using Month as well as Unemployment, CPI_all, CPI_energy and Queries. Do not modify the training and testing data frames before building the model.


```r
lm2 <- lm(ElantraSales ~ Month + Unemployment + CPI_all + CPI_energy + Queries, 
    data = train)
```


What is the model R-Squared?


```r
summary(lm2)
```

```
## 
## Call:
## lm(formula = ElantraSales ~ Month + Unemployment + CPI_all + 
##     CPI_energy + Queries, data = train)
## 
## Residuals:
##    Min     1Q Median     3Q    Max 
##  -6417  -2069   -597   2616   7183 
## 
## Coefficients:
##              Estimate Std. Error t value Pr(>|t|)  
## (Intercept)  148330.5   195373.5    0.76    0.454  
## Month           110.7      191.7    0.58    0.568  
## Unemployment  -4137.3     4008.6   -1.03    0.310  
## CPI_all        -518.0      808.3   -0.64    0.526  
## CPI_energy       54.2      114.1    0.47    0.638  
## Queries          21.2       12.0    1.77    0.087 .
## ---
## Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1
## 
## Residual standard error: 3330 on 30 degrees of freedom
## Multiple R-squared:  0.434,	Adjusted R-squared:  0.34 
## F-statistic: 4.61 on 5 and 30 DF,  p-value: 0.00308
```


###PROBLEM 7 - EFFECT OF ADDING A NEW VARIABLE  (1 point possible)
Which of the following best describes the effect of adding Month?

The model is not better because the adjusted R-squared has gone down and none of the variables (including the new one) are very significant.

###PROBLEM 8 - UNDERSTANDING THE MODEL  (2 points possible)
Let us try to understand our model.

In the new model, given two monthly periods that are otherwise identical in Unemployment, CPI_all, CPI_energy and Queries, what is the absolute difference in predicted Elantra sales given that one period is in January and one is in March?


```r
2 * lm2$coefficients[2]
```

```
## Month 
## 221.4
```


 
In the new model, given two monthly periods that are otherwise identical in Unemployment, CPI_all, CPI_energy and Queries, what is the difference in Elantra sales given that one period is in January and one is in May?


```r
4 * lm2$coefficients[2]
```

```
## Month 
## 442.7
```


###PROBLEM 9 - NUMERIC VS. FACTORS  (1 point possible)
You may be experiencing an uneasy feeling that there is something not quite right in how we have modeled the effect of the calendar month on the monthly sales of Elantras. If so, you are right. In particular, we added Month as a variable, but Month is an ordinary numeric variable. In fact, we must convert Month to a factor variable before adding it to the model.

What is the best explanation for why we must do this?

By modeling Month as a factor variable, the effect of each calendar month is not restricted to be linear in the numerical coding of the month (as demonstrated in Problem 8). 

###PROBLEM 10 - A NEW MODEL  (1 point possible)
Re-run the regression with the Month variable modeled as a factor variable. (Create a new variable that models the Month as a factor instead of overwriting the current Month variable. We'll still use the numeric version of Month later in the problem.)


```r
lm3 <- lm(ElantraSales ~ as.factor(Month) + Unemployment + CPI_all + CPI_energy + 
    Queries, data = train)
```


What is the model R-Squared?


```r
summary(lm3)
```

```
## 
## Call:
## lm(formula = ElantraSales ~ as.factor(Month) + Unemployment + 
##     CPI_all + CPI_energy + Queries, data = train)
## 
## Residuals:
##    Min     1Q Median     3Q    Max 
##  -3865  -1212    -77   1207   3562 
## 
## Coefficients:
##                     Estimate Std. Error t value Pr(>|t|)    
## (Intercept)        312509.28  144061.87    2.17  0.04229 *  
## as.factor(Month)2    2255.00    1943.25    1.16  0.25954    
## as.factor(Month)3    6696.56    1991.63    3.36  0.00310 ** 
## as.factor(Month)4    7556.61    2038.02    3.71  0.00139 ** 
## as.factor(Month)5    7420.25    1950.14    3.80  0.00111 ** 
## as.factor(Month)6    9215.83    1995.23    4.62  0.00017 ***
## as.factor(Month)7    9929.46    2238.80    4.44  0.00025 ***
## as.factor(Month)8    7939.45    2064.63    3.85  0.00101 ** 
## as.factor(Month)9    5013.29    2010.74    2.49  0.02154 *  
## as.factor(Month)10   2500.18    2084.06    1.20  0.24429    
## as.factor(Month)11   3238.93    2397.23    1.35  0.19175    
## as.factor(Month)12   5293.91    2228.31    2.38  0.02762 *  
## Unemployment        -7739.38    2968.75   -2.61  0.01687 *  
## CPI_all             -1343.31     592.92   -2.27  0.03473 *  
## CPI_energy            288.63      97.97    2.95  0.00799 ** 
## Queries                -4.76      12.94   -0.37  0.71660    
## ---
## Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1
## 
## Residual standard error: 2310 on 20 degrees of freedom
## Multiple R-squared:  0.819,	Adjusted R-squared:  0.684 
## F-statistic: 6.04 on 15 and 20 DF,  p-value: 0.000147
```


###PROBLEM 11 - SIGNIFICANT VARIABLES  (1 point possible)
Which variables are significant, or have levels that are significant? Use 0.10 as your p-value cutoff.


```r
summary(lm3)
```

```
## 
## Call:
## lm(formula = ElantraSales ~ as.factor(Month) + Unemployment + 
##     CPI_all + CPI_energy + Queries, data = train)
## 
## Residuals:
##    Min     1Q Median     3Q    Max 
##  -3865  -1212    -77   1207   3562 
## 
## Coefficients:
##                     Estimate Std. Error t value Pr(>|t|)    
## (Intercept)        312509.28  144061.87    2.17  0.04229 *  
## as.factor(Month)2    2255.00    1943.25    1.16  0.25954    
## as.factor(Month)3    6696.56    1991.63    3.36  0.00310 ** 
## as.factor(Month)4    7556.61    2038.02    3.71  0.00139 ** 
## as.factor(Month)5    7420.25    1950.14    3.80  0.00111 ** 
## as.factor(Month)6    9215.83    1995.23    4.62  0.00017 ***
## as.factor(Month)7    9929.46    2238.80    4.44  0.00025 ***
## as.factor(Month)8    7939.45    2064.63    3.85  0.00101 ** 
## as.factor(Month)9    5013.29    2010.74    2.49  0.02154 *  
## as.factor(Month)10   2500.18    2084.06    1.20  0.24429    
## as.factor(Month)11   3238.93    2397.23    1.35  0.19175    
## as.factor(Month)12   5293.91    2228.31    2.38  0.02762 *  
## Unemployment        -7739.38    2968.75   -2.61  0.01687 *  
## CPI_all             -1343.31     592.92   -2.27  0.03473 *  
## CPI_energy            288.63      97.97    2.95  0.00799 ** 
## Queries                -4.76      12.94   -0.37  0.71660    
## ---
## Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1
## 
## Residual standard error: 2310 on 20 degrees of freedom
## Multiple R-squared:  0.819,	Adjusted R-squared:  0.684 
## F-statistic: 6.04 on 15 and 20 DF,  p-value: 0.000147
```


###PROBLEM 12 - FACTOR VARIABLES IN REGRESSION MODELS  (1 point possible)
There are only 11 coefficients provided in the output of the regression model for the Month variable when intuitively there should be 12 (corresponding to the 12 months of the year). In particular, the coefficient for Month = 1 is missing. Why is this?

ANS The effect of Month = 1 is captured in the intercept.
   
###PROBLEM 13 - MULTICOLINEARITY  (1 point possible)
Another peculiar observation about the regression is that the sign of the Queries variable has changed. In particular, when we naively modeled Month as a numeric variable, Queries had a positive coefficient. Now, Queries has a negative coefficient. Furthermore, CPI_energy has a positive coefficient -- as the overall price of energy increases, we expect Elantra sales to increase, which seems counter-intuitive (if the price of energy increases, we'd expect consumers to have less funds to purchase automobiles, leading to lower Elantra sales).

As we have seen before, changes in coefficient signs and signs that are counter to our intuition may be due to a multicolinearity problem. To check, compute the correlations of the variables in the training set.

Which of the following variables is CPI_energy highly correlated with? (Include only variables where the absolute value of the correlation exceeds 0.6. For the purpose of this question, treat Month as a numeric variable, not a factor variable.)


```r
cor(train$CPI_energy, train$Month)
```

```
## [1] 0.176
```

```r
cor(train$CPI_energy, train$Unemployment)
```

```
## [1] -0.8007
```

```r
cor(train$CPI_energy, train$CPI_all)
```

```
## [1] 0.9132
```

```r
cor(train$CPI_energy, train$Queries)
```

```
## [1] 0.8328
```

   
###PROBLEM 14 - CORRELATIONS  (1 point possible)
Which of the following variables is Queries highly correlated with? Again, compute the correlations on the training set. (Include only variables where the absolute value of the correlation exceeds 0.6. For the purpose of this question, treat Month as a numeric variable, not a factor variable.)


```r
cor(train$Queries, train$Month)
```

```
## [1] 0.01584
```

```r
cor(train$Queries, train$Unemployment)
```

```
## [1] -0.6411
```

```r
cor(train$Queries, train$CPI_all)
```

```
## [1] 0.7537
```

```r
cor(train$CPI_energy, train$Queries)
```

```
## [1] 0.8328
```


###PROBLEM 15 - A REDUCED MODEL  (1 point possible)
Let us now simplify our model (the model using the factor version of the Month variable). We will do this by iteratively removing variables, one at a time. Remove the variable with the highest p-value (i.e., the least statistically significant variable) from the model. Repeat this until there are no variables that are insignificant or variables for which all of the factor levels are insignificant. Use a threshold of 0.10 to determine whether a variable is significant.

Which variables, and in what order, are removed by this process?


```r
lm4 <- lm(ElantraSales ~ as.factor(Month) + Unemployment + CPI_all + CPI_energy, 
    data = train)
summary(lm4)
```

```
## 
## Call:
## lm(formula = ElantraSales ~ as.factor(Month) + Unemployment + 
##     CPI_all + CPI_energy, data = train)
## 
## Residuals:
##    Min     1Q Median     3Q    Max 
##  -3866  -1283   -107   1098   3650 
## 
## Coefficients:
##                    Estimate Std. Error t value Pr(>|t|)    
## (Intercept)        325709.1   136627.9    2.38  0.02664 *  
## as.factor(Month)2    2410.9     1857.1    1.30  0.20829    
## as.factor(Month)3    6880.1     1888.1    3.64  0.00152 ** 
## as.factor(Month)4    7697.4     1960.2    3.93  0.00077 ***
## as.factor(Month)5    7444.6     1908.5    3.90  0.00082 ***
## as.factor(Month)6    9223.1     1953.6    4.72  0.00012 ***
## as.factor(Month)7    9602.7     2012.7    4.77  0.00010 ***
## as.factor(Month)8    7919.5     2021.0    3.92  0.00079 ***
## as.factor(Month)9    5074.3     1962.2    2.59  0.01724 *  
## as.factor(Month)10   2724.2     1951.8    1.40  0.17737    
## as.factor(Month)11   3665.1     2055.7    1.78  0.08906 .  
## as.factor(Month)12   5643.2     1974.4    2.86  0.00941 ** 
## Unemployment        -7971.3     2840.8   -2.81  0.01059 *  
## CPI_all             -1377.6      573.4   -2.40  0.02561 *  
## CPI_energy            268.0       78.8    3.40  0.00268 ** 
## ---
## Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1
## 
## Residual standard error: 2260 on 21 degrees of freedom
## Multiple R-squared:  0.818,	Adjusted R-squared:  0.697 
## F-statistic: 6.74 on 14 and 21 DF,  p-value: 5.73e-05
```

   
###PROBLEM 16 - TEST SET PREDICTIONS  (1 point possible)
Using the model from Problem 15, make predictions on the test set. What is the sum of squared errors of the model on the test set?


```r
pred4 <- predict(lm4, newdata = test)
SSE <- sum((pred4 - test$ElantraSales)^2)
```


###PROBLEM 17 - COMPARING TO A BASELINE  (1 point possible)
What would the baseline method predict for all observations in the test set? Remember that the baseline method we use predicts the average outcome of all observations in the training set.


```r
baselineValue <- mean(train$ElantraSales)
baselineValue
```

```
## [1] 14462
```


###PROBLEM 18 - TEST SET R-SQUARED  (1 point possible)
What is the test set R-Squared?


```r
SST <- sum((test$ElantraSales - baselineValue)^2)
RSquared <- 1 - SSE/SST
```


###PROBLEM 19 - ABSOLUTE ERRORS  (1 point possible)
What is the largest absolute error that we make in our test set predictions?

```r
max(abs(test$ElantraSales - pred4))
```

```
## [1] 7491
```


###PROBLEM 20 - MONTH OF LARGEST ERROR  (1 point possible)
In which period (Month,Year pair) do we make the largest absolute error in our prediction?


```r
test$Month[which.max(abs(test$ElantraSales - pred4))]
```

```
## [1] 3
```

