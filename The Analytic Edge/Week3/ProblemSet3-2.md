Problem Set 3-2 
========================================================
PROBLEM 1.1 - LIMITING TO TEAMS MAKING THE PLAYOFFS  (1 point possible)
Each row in the baseball dataset represents a team in a particular year.

How many team/year pairs are there in the whole dataset?


```r
baseball <- read.csv(file.choose())

nrow(baseball)
```

```
## [1] 1232
```


PROBLEM 1.2 - LIMITING TO TEAMS MAKING THE PLAYOFFS  (1 point possible)
Though the dataset contains data from 1962 until 2012, we removed several years with shorter-than-usual seasons. Using the table() function, identify the total number of years included in this dataset.


```r
nrow(table(baseball$Year))
```

```
## [1] 47
```


PROBLEM 1.3 - LIMITING TO TEAMS MAKING THE PLAYOFFS  (1 point possible)
Because we're only analyzing teams that made the playoffs, use the subset() function to replace baseball with a data frame limited to teams that made the playoffs (so your subsetted data frame should still be called "baseball"). How many team/year pairs are included in the new dataset?


```r
baseball <- subset(baseball, baseball$Playoffs == 1)

nrow(baseball)
```

```
## [1] 244
```


PROBLEM 1.4 - LIMITING TO TEAMS MAKING THE PLAYOFFS  (1 point possible)
Through the years, different numbers of teams have been invited to the playoffs. Which of the following has been the number of teams making the playoffs in some season?

```r
unique(table(baseball$Year))
```

```
## [1]  2  4  8 10
```


PROBLEM 2.1 - ADDING AN IMPORTANT PREDICTOR  (1 point possible)
It's much harder to win the World Series if there are 10 teams competing for the championship versus just two. Therefore, we will add the predictor variable NumCompetitors to the baseball data frame. NumCompetitors will contain the number of total teams making the playoffs in the year of a particular team/year pair. For instance, NumCompetitors should be 2 for the 1962 New York Yankees, but it should be 8 for the 1998 Boston Red Sox.

We start by storing the output of the table() function that counts the number of playoff teams from each year:

```r
PlayoffTable = table(baseball$Year)
```

You can output the table with the following command:

```r
PlayoffTable
```

```
## 
## 1962 1963 1964 1965 1966 1967 1968 1969 1970 1971 1973 1974 1975 1976 1977 
##    2    2    2    2    2    2    2    4    4    4    4    4    4    4    4 
## 1978 1979 1980 1982 1983 1984 1985 1986 1987 1988 1989 1990 1991 1992 1993 
##    4    4    4    4    4    4    4    4    4    4    4    4    4    4    4 
## 1996 1997 1998 1999 2000 2001 2002 2003 2004 2005 2006 2007 2008 2009 2010 
##    8    8    8    8    8    8    8    8    8    8    8    8    8    8    8 
## 2011 2012 
##    8   10
```

We will use this stored table to look up the number of teams in the playoffs in the year of each team/year pair.

Just as we can use the names() function to get the names of a data frame's columns, we can use it to get the names of the entries in a table. What best describes the output of names(PlayoffTable)?

```r
names(PlayoffTable)
```

```
##  [1] "1962" "1963" "1964" "1965" "1966" "1967" "1968" "1969" "1970" "1971"
## [11] "1973" "1974" "1975" "1976" "1977" "1978" "1979" "1980" "1982" "1983"
## [21] "1984" "1985" "1986" "1987" "1988" "1989" "1990" "1991" "1992" "1993"
## [31] "1996" "1997" "1998" "1999" "2000" "2001" "2002" "2003" "2004" "2005"
## [41] "2006" "2007" "2008" "2009" "2010" "2011" "2012"
```

Ans: Vector of years stored as strings (type chr) 

PROBLEM 2.2 - ADDING AN IMPORTANT PREDICTOR  (1 point possible)
Given a vector of names, the table will return a vector of frequencies. Which function call returns the number of playoff teams in 1990 and 2001? (HINT: If you are not sure how these commands work, go ahead and try them out in your R console!)


```r
PlayoffTable[c("1990", "2001")]
```

```
## 
## 1990 2001 
##    4    8
```


PROBLEM 2.3 - ADDING AN IMPORTANT PREDICTOR  (1 point possible)
Putting it all together, we want to look up the number of teams in the playoffs for each team/year pair in the dataset, and store it as a new variable named NumCompetitors in the baseball data frame. While of the following function calls accomplishes this? (HINT: Test out the functions if you are not sure what they do.)


```r
baseball$NumCompetitors = PlayoffTable[as.character(baseball$Year)]
```


PROBLEM 2.4 - ADDING AN IMPORTANT PREDICTOR  (1 point possible)
Add the NumCompetitors variable to your baseball data frame. How many playoff team/year pairs are there in our dataset from years where 8 teams were invited to the playoffs?


```r
sum(baseball$NumCompetitors == 8)
```

```
## [1] 128
```


PROBLEM 3.1 - BIVARIATE MODELS FOR PREDICTING WORLD SERIES WINNER (1 point possible)
In this problem, we seek to predict whether a team won the World Series; in our dataset this is denoted with a RankPlayoffs value of 1. Add a variable named WorldSeries to the baseball data frame, by typing the following command in your R console:


```r
baseball$WorldSeries = as.numeric(baseball$RankPlayoffs == 1)
```


WorldSeries takes value 1 if a team won the World Series in the indicated year and a 0 otherwise. How many observations do we have in our dataset where a team did NOT win the World Series?


```r
sum(baseball$WorldSeries != 1)
```

```
## [1] 197
```


PROBLEM 3.2 - BIVARIATE MODELS FOR PREDICTING WORLD SERIES WINNER (1 point possible)
When we're not sure which of our variables are useful in predicting a particular outcome, it's often helpful to build bivariate models, which are models that predict the outcome using a single independent variable. Which of the following variables is a significant predictor of the WorldSeries variable in a bivariate logistic regression model? To determine significance, remember to look at the stars in the summary output of the model. We'll define an independent variable as significant if there is at least one star at the end of the coefficients row for that variable (this is equivalent to the probability column having a value smaller than 0.05). Note that you have to build 12 models to answer this question! Use the entire dataset baseball to build the models.

Year  0.00115

```r
model1 <- glm(WorldSeries ~ Year, data = baseball, family = "binomial")
summary(model1)
```

```
## 
## Call:
## glm(formula = WorldSeries ~ Year, family = "binomial", data = baseball)
## 
## Deviance Residuals: 
##    Min      1Q  Median      3Q     Max  
## -1.030  -0.680  -0.543  -0.465   2.150  
## 
## Coefficients:
##             Estimate Std. Error z value Pr(>|z|)   
## (Intercept)  72.2360    22.6441    3.19   0.0014 **
## Year         -0.0370     0.0114   -3.25   0.0012 **
## ---
## Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1
## 
## (Dispersion parameter for binomial family taken to be 1)
## 
##     Null deviance: 239.12  on 243  degrees of freedom
## Residual deviance: 228.35  on 242  degrees of freedom
## AIC: 232.4
## 
## Number of Fisher Scoring iterations: 4
```


RS 0.201

```r
model2 <- glm(WorldSeries ~ RS, data = baseball, family = "binomial")
summary(model2)
```

```
## 
## Call:
## glm(formula = WorldSeries ~ RS, family = "binomial", data = baseball)
## 
## Deviance Residuals: 
##    Min      1Q  Median      3Q     Max  
## -0.825  -0.682  -0.636  -0.556   2.031  
## 
## Coefficients:
##             Estimate Std. Error z value Pr(>|z|)
## (Intercept)  0.66123    1.63649    0.40     0.69
## RS          -0.00268    0.00210   -1.28     0.20
## 
## (Dispersion parameter for binomial family taken to be 1)
## 
##     Null deviance: 239.12  on 243  degrees of freedom
## Residual deviance: 237.45  on 242  degrees of freedom
## AIC: 241.5
## 
## Number of Fisher Scoring iterations: 4
```


RA 0.0262

```r
model3 <- glm(WorldSeries ~ RA, data = baseball, family = "binomial")
summary(model3)
```

```
## 
## Call:
## glm(formula = WorldSeries ~ RA, family = "binomial", data = baseball)
## 
## Deviance Residuals: 
##    Min      1Q  Median      3Q     Max  
## -0.975  -0.688  -0.612  -0.475   2.158  
## 
## Coefficients:
##             Estimate Std. Error z value Pr(>|z|)  
## (Intercept)  1.88817    1.48383    1.27    0.203  
## RA          -0.00505    0.00227   -2.22    0.026 *
## ---
## Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1
## 
## (Dispersion parameter for binomial family taken to be 1)
## 
##     Null deviance: 239.12  on 243  degrees of freedom
## Residual deviance: 233.88  on 242  degrees of freedom
## AIC: 237.9
## 
## Number of Fisher Scoring iterations: 4
```


W 0.0577

```r
model4 <- glm(WorldSeries ~ W, data = baseball, family = "binomial")
summary(model4)
```

```
## 
## Call:
## glm(formula = WorldSeries ~ W, family = "binomial", data = baseball)
## 
## Deviance Residuals: 
##    Min      1Q  Median      3Q     Max  
## -1.062  -0.678  -0.612  -0.537   2.125  
## 
## Coefficients:
##             Estimate Std. Error z value Pr(>|z|)  
## (Intercept)  -6.8557     2.8762   -2.38    0.017 *
## W             0.0567     0.0299    1.90    0.058 .
## ---
## Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1
## 
## (Dispersion parameter for binomial family taken to be 1)
## 
##     Null deviance: 239.12  on 243  degrees of freedom
## Residual deviance: 235.51  on 242  degrees of freedom
## AIC: 239.5
## 
## Number of Fisher Scoring iterations: 4
```

 
OBP 0.296

```r
model5 <- glm(WorldSeries ~ OBP, data = baseball, family = "binomial")
summary(model5)
```

```
## 
## Call:
## glm(formula = WorldSeries ~ OBP, family = "binomial", data = baseball)
## 
## Deviance Residuals: 
##    Min      1Q  Median      3Q     Max  
## -0.807  -0.675  -0.636  -0.580   1.975  
## 
## Coefficients:
##             Estimate Std. Error z value Pr(>|z|)
## (Intercept)     2.74       3.99    0.69     0.49
## OBP           -12.40      11.87   -1.05     0.30
## 
## (Dispersion parameter for binomial family taken to be 1)
## 
##     Null deviance: 239.12  on 243  degrees of freedom
## Residual deviance: 238.02  on 242  degrees of freedom
## AIC: 242
## 
## Number of Fisher Scoring iterations: 4
```


SLG 0.0504

```r
model6 <- glm(WorldSeries ~ SLG, data = baseball, family = "binomial")
summary(model6)
```

```
## 
## Call:
## glm(formula = WorldSeries ~ SLG, family = "binomial", data = baseball)
## 
## Deviance Residuals: 
##    Min      1Q  Median      3Q     Max  
## -0.950  -0.695  -0.609  -0.520   2.114  
## 
## Coefficients:
##             Estimate Std. Error z value Pr(>|z|)  
## (Intercept)     3.20       2.36    1.36     0.17  
## SLG           -11.13       5.69   -1.96     0.05 .
## ---
## Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1
## 
## (Dispersion parameter for binomial family taken to be 1)
## 
##     Null deviance: 239.12  on 243  degrees of freedom
## Residual deviance: 235.23  on 242  degrees of freedom
## AIC: 239.2
## 
## Number of Fisher Scoring iterations: 4
```


BA 0.839

```r
model7 <- glm(WorldSeries ~ BA, data = baseball, family = "binomial")
summary(model7)
```

```
## 
## Call:
## glm(formula = WorldSeries ~ BA, family = "binomial", data = baseball)
## 
## Deviance Residuals: 
##    Min      1Q  Median      3Q     Max  
## -0.680  -0.659  -0.651  -0.639   1.843  
## 
## Coefficients:
##             Estimate Std. Error z value Pr(>|z|)
## (Intercept)   -0.639      3.899   -0.16     0.87
## BA            -2.976     14.612   -0.20     0.84
## 
## (Dispersion parameter for binomial family taken to be 1)
## 
##     Null deviance: 239.12  on 243  degrees of freedom
## Residual deviance: 239.08  on 242  degrees of freedom
## AIC: 243.1
## 
## Number of Fisher Scoring iterations: 4
```


RankSeason 0.0438

```r
model8 <- glm(WorldSeries ~ RankSeason, data = baseball, family = "binomial")
summary(model8)
```

```
## 
## Call:
## glm(formula = WorldSeries ~ RankSeason, family = "binomial", 
##     data = baseball)
## 
## Deviance Residuals: 
##    Min      1Q  Median      3Q     Max  
## -0.780  -0.713  -0.592  -0.488   2.178  
## 
## Coefficients:
##             Estimate Std. Error z value Pr(>|z|)  
## (Intercept)   -0.826      0.327   -2.53    0.012 *
## RankSeason    -0.207      0.103   -2.02    0.044 *
## ---
## Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1
## 
## (Dispersion parameter for binomial family taken to be 1)
## 
##     Null deviance: 239.12  on 243  degrees of freedom
## Residual deviance: 234.75  on 242  degrees of freedom
## AIC: 238.8
## 
## Number of Fisher Scoring iterations: 4
```


OOBP 0.902

```r
model9 <- glm(WorldSeries ~ OOBP, data = baseball, family = "binomial")
summary(model9)
```

```
## 
## Call:
## glm(formula = WorldSeries ~ OOBP, family = "binomial", data = baseball)
## 
## Deviance Residuals: 
##    Min      1Q  Median      3Q     Max  
## -0.532  -0.518  -0.511  -0.502   2.070  
## 
## Coefficients:
##             Estimate Std. Error z value Pr(>|z|)
## (Intercept)   -0.931      8.373   -0.11     0.91
## OOBP          -3.223     26.059   -0.12     0.90
## 
## (Dispersion parameter for binomial family taken to be 1)
## 
##     Null deviance: 84.926  on 113  degrees of freedom
## Residual deviance: 84.910  on 112  degrees of freedom
##   (130 observations deleted due to missingness)
## AIC: 88.91
## 
## Number of Fisher Scoring iterations: 4
```


OSLG 0.757

```r
model10 <- glm(WorldSeries ~ OSLG, data = baseball, family = "binomial")
summary(model10)
```

```
## 
## Call:
## glm(formula = WorldSeries ~ OSLG, family = "binomial", data = baseball)
## 
## Deviance Residuals: 
##    Min      1Q  Median      3Q     Max  
## -0.561  -0.521  -0.509  -0.490   2.127  
## 
## Coefficients:
##             Estimate Std. Error z value Pr(>|z|)
## (Intercept)  -0.0872     6.0729   -0.01     0.99
## OSLG         -4.6599    15.0688   -0.31     0.76
## 
## (Dispersion parameter for binomial family taken to be 1)
## 
##     Null deviance: 84.926  on 113  degrees of freedom
## Residual deviance: 84.830  on 112  degrees of freedom
##   (130 observations deleted due to missingness)
## AIC: 88.83
## 
## Number of Fisher Scoring iterations: 4
```


NumCompetitors 0.000678

```r
model11 <- glm(WorldSeries ~ NumCompetitors, data = baseball, family = "binomial")
summary(model11)
```

```
## 
## Call:
## glm(formula = WorldSeries ~ NumCompetitors, family = "binomial", 
##     data = baseball)
## 
## Deviance Residuals: 
##    Min      1Q  Median      3Q     Max  
## -0.987  -0.802  -0.509  -0.509   2.264  
## 
## Coefficients:
##                Estimate Std. Error z value Pr(>|z|)    
## (Intercept)      0.0387     0.4375    0.09  0.92956    
## NumCompetitors  -0.2522     0.0742   -3.40  0.00068 ***
## ---
## Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1
## 
## (Dispersion parameter for binomial family taken to be 1)
## 
##     Null deviance: 239.12  on 243  degrees of freedom
## Residual deviance: 226.96  on 242  degrees of freedom
## AIC: 231
## 
## Number of Fisher Scoring iterations: 4
```


League 0.626

```r
model12 <- glm(WorldSeries ~ League, data = baseball, family = "binomial")
summary(model12)
```

```
## 
## Call:
## glm(formula = WorldSeries ~ League, family = "binomial", data = baseball)
## 
## Deviance Residuals: 
##    Min      1Q  Median      3Q     Max  
## -0.677  -0.677  -0.631  -0.631   1.851  
## 
## Coefficients:
##             Estimate Std. Error z value Pr(>|z|)    
## (Intercept)   -1.356      0.224   -6.04  1.5e-09 ***
## LeagueNL      -0.158      0.325   -0.49     0.63    
## ---
## Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1
## 
## (Dispersion parameter for binomial family taken to be 1)
## 
##     Null deviance: 239.12  on 243  degrees of freedom
## Residual deviance: 238.88  on 242  degrees of freedom
## AIC: 242.9
## 
## Number of Fisher Scoring iterations: 4
```


Problem 4.1 - Multivariate Models for Predicting World Series Winner 
 
(1 point possible)

In this section, we'll consider multivariate models that combine the variables we found to be significant in bivariate models. Build a model using all of the variables that you found to be significant in the bivariate models. How many variables are significant in the combined model?


```r
modelMult <- glm(WorldSeries ~ Year + RA + RankSeason + NumCompetitors, data = baseball, 
    family = "binomial")
summary(modelMult)
```

```
## 
## Call:
## glm(formula = WorldSeries ~ Year + RA + RankSeason + NumCompetitors, 
##     family = "binomial", data = baseball)
## 
## Deviance Residuals: 
##    Min      1Q  Median      3Q     Max  
## -1.034  -0.769  -0.514  -0.458   2.220  
## 
## Coefficients:
##                 Estimate Std. Error z value Pr(>|z|)
## (Intercept)    12.587438  53.647421    0.23     0.81
## Year           -0.006142   0.027466   -0.22     0.82
## RA             -0.000824   0.002739   -0.30     0.76
## RankSeason     -0.068505   0.120346   -0.57     0.57
## NumCompetitors -0.179426   0.181593   -0.99     0.32
## 
## (Dispersion parameter for binomial family taken to be 1)
## 
##     Null deviance: 239.12  on 243  degrees of freedom
## Residual deviance: 226.37  on 239  degrees of freedom
## AIC: 236.4
## 
## Number of Fisher Scoring iterations: 4
```


PROBLEM 4.2 - MULTIVARIATE MODELS FOR PREDICTING WORLD SERIES WINNER (1 point possible)
Often, variables that were significant in bivariate models are no longer significant in multivariate analysis due to correlation between the variables. Which of the following variable pairs have a high degree of correlation (a correlation greater than 0.8 or less than -0.8)?


```r
cor(baseball$Year, baseball$RA)
```

```
## [1] 0.4762
```

```r
cor(baseball$Year, baseball$RankSeason)
```

```
## [1] 0.3852
```

```r
cor(baseball$Year, baseball$NumCompetitors)
```

```
## [1] 0.914
```

```r
cor(baseball$RA, baseball$RankSeason)
```

```
## [1] 0.3991
```

```r
cor(baseball$RA, baseball$NumCompetitors)
```

```
## [1] 0.5137
```

```r
cor(baseball$RankSeason, baseball$NumCompetitors)
```

```
## [1] 0.4247
```


PROBLEM 4.3 - MULTIVARIATE MODELS FOR PREDICTING WORLD SERIES WINNER (1 point possible)
Build all six of the two variable models listed in the previous problem. Together with the four bivariate models, you should have 10 different logistic regression models. Which model has the best AIC value (the minimum AIC value)?


```r
modelBio1 <- glm(WorldSeries ~ Year + RA, data = baseball, family = "binomial")
summary(modelBio1)
```

```
## 
## Call:
## glm(formula = WorldSeries ~ Year + RA, family = "binomial", data = baseball)
## 
## Deviance Residuals: 
##    Min      1Q  Median      3Q     Max  
## -1.040  -0.688  -0.530  -0.479   2.137  
## 
## Coefficients:
##             Estimate Std. Error z value Pr(>|z|)  
## (Intercept) 63.61074   25.65483    2.48    0.013 *
## Year        -0.03208    0.01332   -2.41    0.016 *
## RA          -0.00177    0.00259   -0.68    0.494  
## ---
## Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1
## 
## (Dispersion parameter for binomial family taken to be 1)
## 
##     Null deviance: 239.12  on 243  degrees of freedom
## Residual deviance: 227.88  on 241  degrees of freedom
## AIC: 233.9
## 
## Number of Fisher Scoring iterations: 4
```

```r

modelBio2 <- glm(WorldSeries ~ Year + RankSeason, data = baseball, family = "binomial")
summary(modelBio2)
```

```
## 
## Call:
## glm(formula = WorldSeries ~ Year + RankSeason, family = "binomial", 
##     data = baseball)
## 
## Deviance Residuals: 
##    Min      1Q  Median      3Q     Max  
## -1.056  -0.696  -0.538  -0.453   2.267  
## 
## Coefficients:
##             Estimate Std. Error z value Pr(>|z|)   
## (Intercept)  63.6486    24.3706    2.61   0.0090 **
## Year         -0.0325     0.0123   -2.64   0.0082 **
## RankSeason   -0.1006     0.1135   -0.89   0.3753   
## ---
## Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1
## 
## (Dispersion parameter for binomial family taken to be 1)
## 
##     Null deviance: 239.12  on 243  degrees of freedom
## Residual deviance: 227.55  on 241  degrees of freedom
## AIC: 233.6
## 
## Number of Fisher Scoring iterations: 4
```

```r

modelBio3 <- glm(WorldSeries ~ Year + NumCompetitors, data = baseball, family = "binomial")
summary(modelBio3)
```

```
## 
## Call:
## glm(formula = WorldSeries ~ Year + NumCompetitors, family = "binomial", 
##     data = baseball)
## 
## Deviance Residuals: 
##    Min      1Q  Median      3Q     Max  
## -1.005  -0.782  -0.511  -0.497   2.255  
## 
## Coefficients:
##                Estimate Std. Error z value Pr(>|z|)
## (Intercept)     13.3505    53.4819    0.25     0.80
## Year            -0.0068     0.0273   -0.25     0.80
## NumCompetitors  -0.2126     0.1755   -1.21     0.23
## 
## (Dispersion parameter for binomial family taken to be 1)
## 
##     Null deviance: 239.12  on 243  degrees of freedom
## Residual deviance: 226.90  on 241  degrees of freedom
## AIC: 232.9
## 
## Number of Fisher Scoring iterations: 4
```

```r

modelBio4 <- glm(WorldSeries ~ RA + RankSeason, data = baseball, family = "binomial")
summary(modelBio4)
```

```
## 
## Call:
## glm(formula = WorldSeries ~ RA + RankSeason, family = "binomial", 
##     data = baseball)
## 
## Deviance Residuals: 
##    Min      1Q  Median      3Q     Max  
## -0.937  -0.693  -0.594  -0.456   2.198  
## 
## Coefficients:
##             Estimate Std. Error z value Pr(>|z|)
## (Intercept)  1.48746    1.50614    0.99     0.32
## RA          -0.00381    0.00244   -1.56     0.12
## RankSeason  -0.14082    0.11091   -1.27     0.20
## 
## (Dispersion parameter for binomial family taken to be 1)
## 
##     Null deviance: 239.12  on 243  degrees of freedom
## Residual deviance: 232.22  on 241  degrees of freedom
## AIC: 238.2
## 
## Number of Fisher Scoring iterations: 4
```

```r

modelBio5 <- glm(WorldSeries ~ RA + NumCompetitors, data = baseball, family = "binomial")
summary(modelBio5)
```

```
## 
## Call:
## glm(formula = WorldSeries ~ RA + NumCompetitors, family = "binomial", 
##     data = baseball)
## 
## Deviance Residuals: 
##    Min      1Q  Median      3Q     Max  
## -1.043  -0.783  -0.513  -0.470   2.221  
## 
## Coefficients:
##                Estimate Std. Error z value Pr(>|z|)   
## (Intercept)     0.71689    1.52874    0.47   0.6391   
## RA             -0.00123    0.00266   -0.46   0.6431   
## NumCompetitors -0.22939    0.08840   -2.59   0.0095 **
## ---
## Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1
## 
## (Dispersion parameter for binomial family taken to be 1)
## 
##     Null deviance: 239.12  on 243  degrees of freedom
## Residual deviance: 226.74  on 241  degrees of freedom
## AIC: 232.7
## 
## Number of Fisher Scoring iterations: 4
```

```r

modelBio6 <- glm(WorldSeries ~ RankSeason + NumCompetitors, data = baseball, 
    family = "binomial")
summary(modelBio6)
```

```
## 
## Call:
## glm(formula = WorldSeries ~ RankSeason + NumCompetitors, family = "binomial", 
##     data = baseball)
## 
## Deviance Residuals: 
##    Min      1Q  Median      3Q     Max  
## -1.009  -0.759  -0.520  -0.450   2.256  
## 
## Coefficients:
##                Estimate Std. Error z value Pr(>|z|)   
## (Intercept)       0.123      0.457    0.27   0.7884   
## RankSeason       -0.077      0.117   -0.66   0.5110   
## NumCompetitors   -0.228      0.082   -2.78   0.0055 **
## ---
## Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1
## 
## (Dispersion parameter for binomial family taken to be 1)
## 
##     Null deviance: 239.12  on 243  degrees of freedom
## Residual deviance: 226.52  on 241  degrees of freedom
## AIC: 232.5
## 
## Number of Fisher Scoring iterations: 4
```


