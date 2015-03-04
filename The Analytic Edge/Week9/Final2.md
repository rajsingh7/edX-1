Final Exam 2
========================================================
##PREDICTING THE POPULARITY OF NEWS STORIES

Newspapers and online news aggregators like Google News need to prioritize news stories to determine which will be the most popular. In this problem, you will predict the popularity of a set of New York Times articles containing the words "Google", "Microsoft", or "Yahoo" from the time period May 2012-December 2013. The dependent variable in this problem is the variable popular, which labels if an article had 100 or more comments in its online comment section. The independent variables consist of a number of pieces of article metadata available at the time of publication:

print: 1 if an article appeared in the print edition, 0 if only online
type: the type of the article, either "Blog," "News," or "Other"
snippet: a text snippet from the article
headline: the text headline of the article
word.count: the number of words in the article

###PROBLEM 1 - LOADING THE DATASET  (1 point possible)
Load nytimes.csv into a data frame called articles, using the stringsAsFactors=FALSE option.

```r
data <- read.csv("nytimes.csv", stringsAsFactors = F)
```


What proportion of articles had at least 100 comments?

```r
table(data$popular)[2]/sum(table(data$popular))
```

```
##      1 
## 0.1079
```

 
##PROBLEM 2 - COMPUTING A CORRELATION  (1 point possible)
What is the correlation between the number of characters in an article's headline and whether the popular flag is set?


```r
cor(nchar(data$headline), data$popular)
```

```
## [1] -0.1127
```


###PROBLEM 3 - CONVERTING VARIABLES TO FACTORS  (1 point possible)
Convert the "popular" and "type" variables to be factor variables with the as.factor() function.


```r
data$popular <- as.factor(data$popular)
data$type <- as.factor(data$type)
```


Which of the following methods requires the dependent variable be stored as a factor variable when training a model for classification?

Random forest 

###PROBLEM 4 - SPLITTING INTO A TRAINING AND TESTING SET  (1 point possible)
Set the random seed to 144 and then obtain a 70/30 training/testing split using the sample.split() function from the caTools package. Store the split variable in a variable called "spl", which we will use later on. Split articles into a training data frame called "train" and a testing data frame called "test".


```r
library(caTools)
set.seed(144)
spl <- sample.split(data$popular, SplitRatio = 0.7)
train <- subset(data, spl == T)
test <- subset(data, spl == F)
```


Why do we use the sample.split() function to split into a training and testing set?

ANS It balances the dependent variable between the training and testing sets
   
###PROBLEM 5 - TRAINING A LOGISTIC REGRESSION MODEL  (1 point possible)
Train a logistic regression model (using the train data frame) to predict the "popular" outcome, using variables "print", "type", and "word.count".

Which of the following coefficients are significant at the p=0.05 level (at least one star)?


```r
logModel1 <- glm(popular ~ print + type + word.count, data = train, family = "binomial")
summary(logModel1)
```

```
## 
## Call:
## glm(formula = popular ~ print + type + word.count, family = "binomial", 
##     data = train)
## 
## Deviance Residuals: 
##    Min      1Q  Median      3Q     Max  
## -1.177  -0.457  -0.427  -0.285   2.558  
## 
## Coefficients:
##              Estimate Std. Error z value Pr(>|z|)    
## (Intercept) -2.507557   0.501969   -5.00  5.9e-07 ***
## print       -0.846833   0.306755   -2.76   0.0058 ** 
## typeNews     0.905593   0.403253    2.25   0.0247 *  
## typeOther    0.944076   0.605789    1.56   0.1191    
## word.count   0.000260   0.000106    2.45   0.0143 *  
## ---
## Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1
## 
## (Dispersion parameter for binomial family taken to be 1)
## 
##     Null deviance: 468.37  on 681  degrees of freedom
## Residual deviance: 432.05  on 677  degrees of freedom
## AIC: 442.1
## 
## Number of Fisher Scoring iterations: 5
```


###PROBLEM 6 - PREDICTING USING A LOGISTIC REGRESSION MODEL  (1 point possible)
Consider an article that was printed in the newspaper (print = 1) with type = "News" and a total word count of 682. What is the predicted probability of this observation being popular, according to this model?

```r
coeff <- logModel1$coefficients
1/(1 + exp(-1 * (coeff[1] + coeff[2] * 1 + coeff[3] * 1 + coeff[5] * 682)))
```

```
## (Intercept) 
##     0.09351
```


###PROBLEM 7 - INTERPRETING MODEL COEFFICIENTS  (1 point possible)
What is the meaning of the coefficient on the print variable in the logistic regression model?

```r
exp(coeff[2])
```

```
##  print 
## 0.4288
```


ANS Articles from the print section of the newspaper are predicted to be 57.1% less likely to be popular than an otherwise identical article not from the print section.

###PROBLEM 8 - OBTAINING TEST SET PREDICTIONS  (1 point possible)
Obtain test-set predictions for your logistic regression model. Using a probability threshold of 0.5, on how many observations does the logistic regression make a different prediction than the naive baseline model? Remember that the naive baseline model always predicts the most frequent outcome in the training set.


```r
table(test$popular)
```

```
## 
##   0   1 
## 260  31
```

```r
logPred <- predict(logModel1, newdata = test, type = "response")
sum(logPred < 0.5)
```

```
## [1] 291
```


###PROBLEM 9 - COMPUTING TEST SET AUC  (1 point possible)
What is the test-set AUC of the logistic regression model?

```r
library(ROCR)
```

```
## Loading required package: gplots
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
ROCRpred = prediction(logPred, test$popular)
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
## [1] 0.7854
## 
## 
## Slot "alpha.values":
## list()
```


###PROBLEM 10 - COMPUTING TEST SET AUC  (1 point possible)
What is the meaning of the AUC?

ANS The proportion of the time the model can differentiate between a

###PROBLEM 11 - ROC CURVES  (1 point possible)
Which cutoffs are plotted on an ROC curve for a logistic regression model?

ANS All cutoffs between 0 and 1

###PROBLEM 12 - READING ROC CURVES  (1 point possible)
Plot the colorized ROC curve for the logistic regression model.


```r
ROCRperf = performance(ROCRpred, "tpr", "fpr")
plot(ROCRperf, colorize = TRUE)
```

![plot of chunk unnamed-chunk-11](figure/unnamed-chunk-11.png) 


At roughly which logistic regression cutoff does the model achieve a true positive rate of 0.39 and a false positive rate of 0.04?

ANS 0.22
   
###PROBLEM 13 - CROSS-VALIDATION TO SELECT PARAMETERS  (1 point possible)
Which of the following best describes how 10-fold cross-validation works when selecting between 3 different parameter values?

ANS 30 models are trained on subsets of the training set and evaluated on a portion of the training set 

###PROBLEM 14 - CROSS-VALIDATION FOR A CART MODEL  (1 point possible)
Set the random seed to 144 (even though you have already done so earlier in the problem). Then use the caret package and the train function to perform 10-fold cross validation with the data set train, to select the best cp value for a CART model that predicts the dependent variable using "print", "type", and "word.count". Select the cp value from a grid consisting of the 50 values 0.01, 0.02, ..., 0.5.


```r
library(caret)
```

```
## Loading required package: lattice
## Loading required package: ggplot2
```

```r
library(rpart)
fitControl = trainControl(method = "cv", number = 10)
cartGrid = expand.grid(.cp = seq(0.01, 0.5, 0.01))
set.seed(144)
train(popular ~ print + type + word.count, data = train, method = "rpart", trControl = fitControl, 
    tuneGrid = cartGrid)
```

```
## CART 
## 
## 682 samples
##   5 predictors
##   2 classes: '0', '1' 
## 
## No pre-processing
## Resampling: Cross-Validated (10 fold) 
## 
## Summary of sample sizes: 614, 614, 614, 613, 614, 614, ... 
## 
## Resampling results across tuning parameters:
## 
##   cp    Accuracy  Kappa  Accuracy SD  Kappa SD
##   0.01  0.9       0      0.007        0       
##   0.02  0.9       0      0.007        0       
##   0.03  0.9       0      0.007        0       
##   0.04  0.9       0      0.007        0       
##   0.05  0.9       0      0.007        0       
##   0.06  0.9       0      0.007        0       
##   0.07  0.9       0      0.007        0       
##   0.08  0.9       0      0.007        0       
##   0.09  0.9       0      0.007        0       
##   0.1   0.9       0      0.007        0       
##   0.1   0.9       0      0.007        0       
##   0.1   0.9       0      0.007        0       
##   0.1   0.9       0      0.007        0       
##   0.1   0.9       0      0.007        0       
##   0.2   0.9       0      0.007        0       
##   0.2   0.9       0      0.007        0       
##   0.2   0.9       0      0.007        0       
##   0.2   0.9       0      0.007        0       
##   0.2   0.9       0      0.007        0       
##   0.2   0.9       0      0.007        0       
##   0.2   0.9       0      0.007        0       
##   0.2   0.9       0      0.007        0       
##   0.2   0.9       0      0.007        0       
##   0.2   0.9       0      0.007        0       
##   0.2   0.9       0      0.007        0       
##   0.3   0.9       0      0.007        0       
##   0.3   0.9       0      0.007        0       
##   0.3   0.9       0      0.007        0       
##   0.3   0.9       0      0.007        0       
##   0.3   0.9       0      0.007        0       
##   0.3   0.9       0      0.007        0       
##   0.3   0.9       0      0.007        0       
##   0.3   0.9       0      0.007        0       
##   0.3   0.9       0      0.007        0       
##   0.4   0.9       0      0.007        0       
##   0.4   0.9       0      0.007        0       
##   0.4   0.9       0      0.007        0       
##   0.4   0.9       0      0.007        0       
##   0.4   0.9       0      0.007        0       
##   0.4   0.9       0      0.007        0       
##   0.4   0.9       0      0.007        0       
##   0.4   0.9       0      0.007        0       
##   0.4   0.9       0      0.007        0       
##   0.4   0.9       0      0.007        0       
##   0.4   0.9       0      0.007        0       
##   0.5   0.9       0      0.007        0       
##   0.5   0.9       0      0.007        0       
##   0.5   0.9       0      0.007        0       
##   0.5   0.9       0      0.007        0       
##   0.5   0.9       0      0.007        0       
## 
## Accuracy was used to select the optimal model using  the largest value.
## The final value used for the model was cp = 0.5.
```


How many of the 50 parameter values achieve the maximum cross-validation accuracy?

ANS 50

###PROBLEM 15 - TRAIN CART MODEL  (1 point possible)
Build and plot the CART model trained with cp=0.01. How many variables are used as splits in this tree?


```r
CARTModelCV <- rpart(popular ~ print + type + word.count, data = train, cp = 0.01)
library(rpart.plot)
prp(CARTModelCV)
```

![plot of chunk unnamed-chunk-13](figure/unnamed-chunk-13.png) 


ANS 0
 
###PROBLEM 16 - BUILDING A CORPUS FROM ARTICLE SNIPPETS  (1 point possible)
In the last part of this problem, we will determine if text analytics can be used to improve the quality of predictions of which articles will be popular.

Build a corpus called "corpus" using the snippet variable. Using the tm_map() function, perform the following pre-processing steps on the corpus:

```r
library(tm)
library(SnowballC)
corpus = Corpus(VectorSource(data$snippet))
```


1) Convert all words to lowercase

```r
corpus = tm_map(corpus, tolower)
```


2) Remove punctuation

```r
corpus = tm_map(corpus, removePunctuation)
```


3) Remove English stop words. As in the Text Analytics week, if you have a non-standard set of English-language stop words, please load the stopwords stored in stopwords.txt and use variable sw instead of stopwords("english") when removing the stopwords.

```r
sw = c("i", "me", "my", "myself", "we", "our", "ours", "ourselves", "you", "your", 
    "yours", "yourself", "yourselves", "he", "him", "his", "himself", "she", 
    "her", "hers", "herself", "it", "its", "itself", "they", "them", "their", 
    "theirs", "themselves", "what", "which", "who", "whom", "this", "that", 
    "these", "those", "am", "is", "are", "was", "were", "be", "been", "being", 
    "have", "has", "had", "having", "do", "does", "did", "doing", "would", "should", 
    "could", "ought", "i'm", "you're", "he's", "she's", "it's", "we're", "they're", 
    "i've", "you've", "we've", "they've", "i'd", "you'd", "he'd", "she'd", "we'd", 
    "they'd", "i'll", "you'll", "he'll", "she'll", "we'll", "they'll", "isn't", 
    "aren't", "wasn't", "weren't", "hasn't", "haven't", "hadn't", "doesn't", 
    "don't", "didn't", "won't", "wouldn't", "shan't", "shouldn't", "can't", 
    "cannot", "couldn't", "mustn't", "let's", "that's", "who's", "what's", "here's", 
    "there's", "when's", "where's", "why's", "how's", "a", "an", "the", "and", 
    "but", "if", "or", "because", "as", "until", "while", "of", "at", "by", 
    "for", "with", "about", "against", "between", "into", "through", "during", 
    "before", "after", "above", "below", "to", "from", "up", "down", "in", "out", 
    "on", "off", "over", "under", "again", "further", "then", "once", "here", 
    "there", "when", "where", "why", "how", "all", "any", "both", "each", "few", 
    "more", "most", "other", "some", "such", "no", "nor", "not", "only", "own", 
    "same", "so", "than", "too", "very")
corpus = tm_map(corpus, removeWords, sw)
```


4) Stem the document

```r
corpus = tm_map(corpus, stemDocument)
```


Build a document-term matrix called "dtm" from the preprocessed corpus. How many unique word stems are in dtm?

```r
dtm = DocumentTermMatrix(corpus)
ncol(dtm)
```

```
## [1] 3926
```


###PROBLEM 17 - REMOVING SPARSE TERMS  (1 point possible)
Remove all terms that don't appear in at least 5% of documents in the corpus, storing the result in a new document term matrix called spdtm.

How many unique terms are in spdtm?

```r
spdtm = removeSparseTerms(dtm, 0.95)
ncol(spdtm)
```

```
## [1] 17
```


###PROBLEM 18 - EVALUATING WORD FREQUENCIES IN A CORPUS  (1 point possible)
Convert spdtm to a data frame called articleText. Which word stem appears the most frequently across all snippets?

```r
articleText <- as.data.frame(as.matrix(spdtm))
sort(colSums(articleText))
```

```
##     offer      year       can    servic      make     chief    execut 
##        51        55        57        57        60        61        63 
##      said      busi       one technolog     yahoo      will     googl 
##        65        66        76        77        80        83        91 
## microsoft       new   compani 
##        98       171       173
```


###PROBLEM 19 - ADDING DATA FROM ORIGINAL DATA FRAME  (1 point possible)
Copy the following variables from the articles data frame into articleText:

1) print

```r
articleText$print = data$print
```

2) type

```r
articleText$type = data$type
```

3) word.count

```r
articleText$word.count = data$word.count
```

4) popular

```r
articleText$popular = data$popular
```


Then, split articleText into a training set called trainText and a testing set called testText using the variable "spl" that was earlier used to split articles into train and test.

```r
trainText <- subset(articleText, spl == T)
testText <- subset(articleText, spl == F)
```


How many variables are in testText?

```r
ncol(testText)
```

```
## [1] 21
```


###PROBLEM 20 - TRAINING ANOTHER LOGISTIC REGRESSION MODEL  (1 point possible)
Using trainText, train a logistic regression model called glmText to predict the dependent variable using all other variables in the data frame.


```r
glmText <- glm(popular ~ ., data = trainText, family = "binomial")
```


How many of the word frequencies from the snippet text are significant at the p=0.05 level?


```r
summary(glmText)
```

```
## 
## Call:
## glm(formula = popular ~ ., family = "binomial", data = trainText)
## 
## Deviance Residuals: 
##    Min      1Q  Median      3Q     Max  
## -1.164  -0.519  -0.359  -0.238   2.686  
## 
## Coefficients:
##              Estimate Std. Error z value Pr(>|z|)    
## (Intercept) -2.339173   0.531260   -4.40  1.1e-05 ***
## busi        -0.909679   0.717564   -1.27    0.205    
## can          0.397002   0.499297    0.80    0.427    
## chief       -0.263451   0.882392   -0.30    0.765    
## compani     -0.059919   0.359458   -0.17    0.868    
## execut      -0.205320   0.722966   -0.28    0.776    
## googl       -1.659250   1.017989   -1.63    0.103    
## make        -0.086350   0.491725   -0.18    0.861    
## microsoft   -0.101625   0.474533   -0.21    0.830    
## new         -0.189142   0.361721   -0.52    0.601    
## offer       -0.464316   0.752060   -0.62    0.537    
## one         -0.588336   0.606470   -0.97    0.332    
## said         0.256610   0.575934    0.45    0.656    
## servic      -1.019974   1.032816   -0.99    0.323    
## technolog   -0.320859   0.482472   -0.67    0.506    
## will        -0.896275   0.745782   -1.20    0.229    
## yahoo        0.371830   0.540264    0.69    0.491    
## year         0.255543   0.569473    0.45    0.654    
## print       -0.718551   0.312709   -2.30    0.022 *  
## typeNews     0.983506   0.415166    2.37    0.018 *  
## typeOther    0.989554   0.617887    1.60    0.109    
## word.count   0.000215   0.000109    1.97    0.048 *  
## ---
## Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1
## 
## (Dispersion parameter for binomial family taken to be 1)
## 
##     Null deviance: 468.37  on 681  degrees of freedom
## Residual deviance: 416.26  on 660  degrees of freedom
## AIC: 460.3
## 
## Number of Fisher Scoring iterations: 7
```


###PROBLEM 21 - TEST SET AUC OF NEW LOGISTIC REGRESSION MODEL  (1 point possible)
What is the test-set AUC of the new logistic regression model?

```r
glmTextPred <- predict(glmText, newdata = testText, type = "response")
ROCRpred2 = prediction(glmTextPred, testText$popular)
ROCRauc2 = performance(ROCRpred2, "auc")
ROCRauc2
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
## [1] 0.6852
## 
## 
## Slot "alpha.values":
## list()
```


###PROBLEM 22 - ASSESSING OVERFITTING OF NEW MODEL  (1 point possible)
What is the most accurate description of the new logistic regression model?

ANS glmText is overfitted, and removing variables would improve its test-set performance.
