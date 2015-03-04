ProblemSet 5-2
========================================================
AUTOMATING REVIEWS IN MEDICINE

The medical literature is enormous. Pubmed, a database of medical publications maintained by the U.S. National Library of Medicine, has indexed over 23 million medical publications. Further, the rate of medical publication has increased over time, and now there are nearly 1 million new publications in the field each year, or more than one per minute.

The large size and fast-changing nature of the medical literature has increased the need for reviews, which search databases like Pubmed for papers on a particular topic and then report results from the papers found. While such reviews are often performed manually, with multiple people reviewing each search result, this is tedious and time consuming. In this problem, we will see how text analytics can be used to automate the process of information retrieval.

The dataset consists of the titles (variable title) and abstracts (variable abstract) of papers retrieved in a Pubmed search. Each search result is labeled with whether the paper is a clinical trial testing a drug therapy for cancer (variable trial). These labels were obtained by two people reviewing each search result and accessing the actual paper if necessary, as part of a literature review of clinical trials testing drug therapies for advanced and metastatic breast cancer.

###PROBLEM 1.1 - LOADING THE DATA  (1 point possible)
Load clinical_trial.csv into a data frame called trials (remembering to add the argument stringsAsFactors=FALSE), and investigate the data frame with summary() and str().


```r
trials <- read.csv(file.choose(), stringsAsFactors = F)
str(trials)
```

```
## 'data.frame':	1860 obs. of  3 variables:
##  $ title   : chr  "Treatment of Hodgkin's disease and other cancers with 1,3-bis(2-chloroethyl)-1-nitrosourea (BCNU; NSC-409962)." "Cell mediated immune status in malignancy--pretherapy and post-therapy assessment." "Neoadjuvant vinorelbine-capecitabine versus docetaxel-doxorubicin-cyclophosphamide in early nonresponsive breast cancer: phase "| __truncated__ "Randomized phase 3 trial of fluorouracil, epirubicin, and cyclophosphamide alone or followed by Paclitaxel for early breast can"| __truncated__ ...
##  $ abstract: chr  "" "Twenty-eight cases of malignancies of different kinds were studied to assess T-cell activity and population before and after in"| __truncated__ "BACKGROUND: Among breast cancer patients, nonresponse to initial neoadjuvant chemotherapy is associated with unfavorable outcom"| __truncated__ "BACKGROUND: Taxanes are among the most active drugs for the treatment of metastatic breast cancer, and, as a consequence, they "| __truncated__ ...
##  $ trial   : int  1 0 1 1 1 0 1 0 0 0 ...
```

```r
summary(trials)
```

```
##     title             abstract             trial      
##  Length:1860        Length:1860        Min.   :0.000  
##  Class :character   Class :character   1st Qu.:0.000  
##  Mode  :character   Mode  :character   Median :0.000  
##                                        Mean   :0.439  
##                                        3rd Qu.:1.000  
##                                        Max.   :1.000
```


We can use R's string functions to learn more about the titles and abstracts of the located papers. The nchar() function counts the number of characters in a piece of text. Using the nchar() function on the variables in the data frame, answer the following questions:

How many characters are there in the longest abstract?

```r
which.max(nchar(trials$abstract))
```

```
## Error: 多字节字符串23有错
```

```r
nchar(trials$abstract[664])
```

```
## [1] 3708
```


###PROBLEM 1.2 - LOADING THE DATA  (1 point possible)
How many search results provided no abstract? (HINT: A search result provided no abstract if the number of characters in the abstract field is zero.)

```r
sum((nchar(trials$abstract) == 0))
```

```
## Error: 多字节字符串23有错
```


###PROBLEM 1.3 - LOADING THE DATA  (1 point possible)
What is the shortest title of any article? Include capitalization and punctuation in your response, but don't include the quotes.

```r
which.min(nchar(trials$title))
```

```
## Error: 多字节字符串156有错
```

```r
trials$title[1258]
```

```
## [1] "A decade of letrozole: FACE."
```



###PROBLEM 2.1 - PREPARING THE CORPUS  (2 points possible)
Because we have both title and abstract information for trials, we need to build two corpera instead of one. Name them corpusTitle and corpusAbstract.

Following the commands from lecture, perform the following tasks. Make sure to perform them in this order.

1) Convert the title variable to corpusTitle and the abstract variable to corpusAbstract.

```r
library(tm)
```

```
## Warning: package 'tm' was built under R version 3.0.3
```

```r
library(SnowballC)
corpusTitle <- Corpus(VectorSource(trials$title))
corpusAbstract <- Corpus(VectorSource(trials$abstract))
corpusTitle[[2]]
```

```
## Cell mediated immune status in malignancy--pretherapy and post-therapy assessment.
```

```r
strwrap(corpusAbstract[[2]])
```

```
##  [1] "Twenty-eight cases of malignancies of different kinds were studied"
##  [2] "to assess T-cell activity and population before and after"         
##  [3] "institution of therapy. Fifteen cases were diagnosed as"           
##  [4] "non-metastasising squamous cell carcinoma of larynx, pharynx,"     
##  [5] "laryngopharynx, hypopharynx and tonsils. Seven cases were"         
##  [6] "non-metastasising infiltrating duct carcinoma of breast and 6"     
##  [7] "cases were non-Hodgkin's lymphoma (NHL). It was observed that 3"   
##  [8] "out of 15 cases (20%) of squamous cell carcinoma cases were"       
##  [9] "Mantoux test (MT) negative with a T-cell population of less than"  
## [10] "40%, 2 out of 7 cases (28.6%) of infiltrating duct carcinoma of"   
## [11] "breast were MT negative with a T-cell population of less than 40%" 
## [12] "and 3 out of 6 cases (50%) of NHL were MT negative with a T-cell"  
## [13] "population of less than 40%. The normal controls, consisting of"   
## [14] "apparently normal healthy adults, had a T-cell population of more" 
## [15] "than 40% and were all MT positive. The patients who showed a"      
## [16] "negative skin test and a T-cell population less than 40% were"     
## [17] "further subjected to assessment of T-cell population and activity" 
## [18] "after appropriate therapy, and clinical cure of the disease. It"   
## [19] "was observed that 2 out of 3 cases (66.66%) of squamous cell"      
## [20] "carcinomas, 2 out of 2 cases (100%) of adenocarcinomas and one out"
## [21] "of 3 cases (33.33%) of NHL showed positive conversion with a"      
## [22] "T-cell population of more than 40%."
```


2) Convert corpusTitle and corpusAbstract to lowercase.

```r
corpusTitle = tm_map(corpusTitle, tolower)
```

```
## Error: 多字节字符串1有错
```

```r
corpusAbstract = tm_map(corpusAbstract, tolower)
```

```
## Error: 多字节字符串1有错
```

```r
corpusTitle[[2]]
```

```
## Cell mediated immune status in malignancy--pretherapy and post-therapy assessment.
```

```r
strwrap(corpusAbstract[[2]])
```

```
##  [1] "Twenty-eight cases of malignancies of different kinds were studied"
##  [2] "to assess T-cell activity and population before and after"         
##  [3] "institution of therapy. Fifteen cases were diagnosed as"           
##  [4] "non-metastasising squamous cell carcinoma of larynx, pharynx,"     
##  [5] "laryngopharynx, hypopharynx and tonsils. Seven cases were"         
##  [6] "non-metastasising infiltrating duct carcinoma of breast and 6"     
##  [7] "cases were non-Hodgkin's lymphoma (NHL). It was observed that 3"   
##  [8] "out of 15 cases (20%) of squamous cell carcinoma cases were"       
##  [9] "Mantoux test (MT) negative with a T-cell population of less than"  
## [10] "40%, 2 out of 7 cases (28.6%) of infiltrating duct carcinoma of"   
## [11] "breast were MT negative with a T-cell population of less than 40%" 
## [12] "and 3 out of 6 cases (50%) of NHL were MT negative with a T-cell"  
## [13] "population of less than 40%. The normal controls, consisting of"   
## [14] "apparently normal healthy adults, had a T-cell population of more" 
## [15] "than 40% and were all MT positive. The patients who showed a"      
## [16] "negative skin test and a T-cell population less than 40% were"     
## [17] "further subjected to assessment of T-cell population and activity" 
## [18] "after appropriate therapy, and clinical cure of the disease. It"   
## [19] "was observed that 2 out of 3 cases (66.66%) of squamous cell"      
## [20] "carcinomas, 2 out of 2 cases (100%) of adenocarcinomas and one out"
## [21] "of 3 cases (33.33%) of NHL showed positive conversion with a"      
## [22] "T-cell population of more than 40%."
```


3) Remove the punctuation in corpusTitle and corpusAbstract.

```r
corpusTitle = tm_map(corpusTitle, removePunctuation)
corpusAbstract = tm_map(corpusAbstract, removePunctuation)
corpusTitle[[2]]
```

```
## Cell mediated immune status in malignancypretherapy and posttherapy assessment
```

```r
strwrap(corpusAbstract[[2]])
```

```
##  [1] "Twentyeight cases of malignancies of different kinds were studied" 
##  [2] "to assess Tcell activity and population before and after"          
##  [3] "institution of therapy Fifteen cases were diagnosed as"            
##  [4] "nonmetastasising squamous cell carcinoma of larynx pharynx"        
##  [5] "laryngopharynx hypopharynx and tonsils Seven cases were"           
##  [6] "nonmetastasising infiltrating duct carcinoma of breast and 6 cases"
##  [7] "were nonHodgkins lymphoma NHL It was observed that 3 out of 15"    
##  [8] "cases 20 of squamous cell carcinoma cases were Mantoux test MT"    
##  [9] "negative with a Tcell population of less than 40 2 out of 7 cases" 
## [10] "286 of infiltrating duct carcinoma of breast were MT negative with"
## [11] "a Tcell population of less than 40 and 3 out of 6 cases 50 of NHL" 
## [12] "were MT negative with a Tcell population of less than 40 The"      
## [13] "normal controls consisting of apparently normal healthy adults had"
## [14] "a Tcell population of more than 40 and were all MT positive The"   
## [15] "patients who showed a negative skin test and a Tcell population"   
## [16] "less than 40 were further subjected to assessment of Tcell"        
## [17] "population and activity after appropriate therapy and clinical"    
## [18] "cure of the disease It was observed that 2 out of 3 cases 6666 of" 
## [19] "squamous cell carcinomas 2 out of 2 cases 100 of adenocarcinomas"  
## [20] "and one out of 3 cases 3333 of NHL showed positive conversion with"
## [21] "a Tcell population of more than 40"
```


4) Remove the English language stop words from corpusTitle and corpusAbstract.

```r
corpusTitle = tm_map(corpusTitle, removeWords, stopwords("english"))
corpusAbstract = tm_map(corpusAbstract, removeWords, stopwords("english"))
corpusTitle[[2]]
```

```
## Cell mediated immune status  malignancypretherapy  posttherapy assessment
```

```r
strwrap(corpusAbstract[[2]])
```

```
##  [1] "Twentyeight cases malignancies different kinds studied assess"     
##  [2] "Tcell activity population institution therapy Fifteen cases"       
##  [3] "diagnosed nonmetastasising squamous cell carcinoma larynx pharynx" 
##  [4] "laryngopharynx hypopharynx tonsils Seven cases nonmetastasising"   
##  [5] "infiltrating duct carcinoma breast 6 cases nonHodgkins lymphoma"   
##  [6] "NHL It observed 3 15 cases 20 squamous cell carcinoma cases"       
##  [7] "Mantoux test MT negative Tcell population less 40 2 7 cases 286"   
##  [8] "infiltrating duct carcinoma breast MT negative Tcell population"   
##  [9] "less 40 3 6 cases 50 NHL MT negative Tcell population less 40 The" 
## [10] "normal controls consisting apparently normal healthy adults Tcell" 
## [11] "population 40 MT positive The patients showed negative skin test"  
## [12] "Tcell population less 40 subjected assessment Tcell population"    
## [13] "activity appropriate therapy clinical cure disease It observed 2 3"
## [14] "cases 6666 squamous cell carcinomas 2 2 cases 100 adenocarcinomas" 
## [15] "one 3 cases 3333 NHL showed positive conversion Tcell population"  
## [16] "40"
```


5) Stem the words in corpusTitle and corpusAbstract (each stemming might take a few minutes).

```r
corpusTitle = tm_map(corpusTitle, stemDocument)
corpusAbstract = tm_map(corpusAbstract, stemDocument)
corpusTitle[[2]]
```

```
## Cell mediat immun status  malignancypretherapi  posttherapi assess
```

```r
strwrap(corpusAbstract[[2]])
```

```
##  [1] "Twentyeight case malign differ kind studi assess Tcell activ popul"
##  [2] "institut therapi Fifteen case diagnos nonmetastasis squamous cell" 
##  [3] "carcinoma larynx pharynx laryngopharynx hypopharynx tonsil Seven"  
##  [4] "case nonmetastasis infiltr duct carcinoma breast 6 case nonHodgkin"
##  [5] "lymphoma NHL It observ 3 15 case 20 squamous cell carcinoma case"  
##  [6] "Mantoux test MT negat Tcell popul less 40 2 7 case 286 infiltr"    
##  [7] "duct carcinoma breast MT negat Tcell popul less 40 3 6 case 50 NHL"
##  [8] "MT negat Tcell popul less 40 The normal control consist appar"     
##  [9] "normal healthi adult Tcell popul 40 MT posit The patient show"     
## [10] "negat skin test Tcell popul less 40 subject assess Tcell popul"    
## [11] "activ appropri therapi clinic cure diseas It observ 2 3 case 6666" 
## [12] "squamous cell carcinoma 2 2 case 100 adenocarcinoma one 3 case"    
## [13] "3333 NHL show posit convers Tcell popul 40"
```


6) Build a document term matrix called dtmTitle from corpusTitle and dtmAbstract from corpusAbstract.

```r
frequenciesTitle = DocumentTermMatrix(corpusTitle)
frequenciesAbstract = DocumentTermMatrix(corpusAbstract)
```


7) Limit dtmTitle and dtmAbstract to terms with sparseness of at most 95% (aka terms that appear in at least 5% of documents).

```r
sparseTitle = removeSparseTerms(frequenciesTitle, 0.95)
sparseAbstract = removeSparseTerms(frequenciesAbstract, 0.95)
```


8) Convert dtmTitle and dtmAbstract to data frames.

```r
title = as.data.frame(as.matrix(sparseTitle))
abstract = as.data.frame(as.matrix(sparseAbstract))
```


How many terms remain in dtmTitle after removing sparse terms (aka how many columns does it have)?

```r
ncol(sparseTitle)
```

```
## [1] 33
```

```r
ncol(sparseAbstract)
```

```
## [1] 347
```


###PROBLEM 2.2 - PREPARING THE CORPUS  (1 point possible)
What is the most likely reason why dtmAbstract has so many more terms than dtmTitle?

Abstracts tend to have many more words than titles

###PROBLEM 2.3 - PREPARING THE CORPUS  (1 point possible)
What is the most frequent word stem across all the abstracts? Hint: you can use colSums() to compute the frequency of a word across all the abstracts.

```r
which.max(colSums(abstract))
```

```
## patient 
##     218
```


###PROBLEM 3.1 - BUILDING A MODEL  (1 point possible)
We want to combine dtmTitle and dtmAbstract into a single data frame to make predictions. However, some of the variables in these data frames have the same names. To fix this issue, run the following commands:


```r
colnames(title) = paste0("T", colnames(title))
colnames(abstract) = paste0("A", colnames(abstract))
```


What was the effect of these functions?

Adding the letter T in front of all the title variable names and adding the letter A in front of all the abstract variable names. 

###PROBLEM 3.2 - BUILDING A MODEL  (1 point possible)
Using cbind(), combine dtmTitle and dtmAbstract into a single data frame called dtm. As we did in class, add the dependent variable "trial" to dtm, copying it from the original data frame called trials. How many columns are in this combined data frame?


```r
dtm <- cbind(title, abstract)
dtm$trial = trials$trial
ncol(dtm)
```

```
## [1] 381
```


###PROBLEM 3.3 - BUILDING A MODEL  (1 point possible)
Now that we have prepared our data frame, it's time to split it into a training and testing set and to build regression models. Set the random seed to 144 and use the sample.split function from the caTools package to split dtm into data frames named "train" and "test", putting 70% of the data in the training set.


```r
library(caTools)
```

```
## Warning: package 'caTools' was built under R version 3.0.3
```

```r
set.seed(144)
split <- sample.split(dtm$trial, SplitRatio = 0.7)
train <- subset(dtm, split == T)
test <- subset(dtm, split == F)
```


What is the accuracy of the baseline model on the training set? (Remember that the baseline model predicts the most frequent outcome in the training set for all observations.)

```r
table(train$trial)
```

```
## 
##   0   1 
## 730 572
```

```r
730/(730 + 572)
```

```
## [1] 0.5607
```


###PROBLEM 3.4 - BUILDING A MODEL  (1 point possible)
Build a CART model called trialCART, using all the independent variables in the training set to train the model, and then plot the CART model. Just use the default parameters to build the model (don't add a minbucket or cp value). Remember to add the method="class" argument, since this is a classification problem.


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
trialCART <- rpart(trial ~ ., data = train, method = "class")
```


What is the name of the first variable the model split on?

```r
prp(trialCART)
```

![plot of chunk unnamed-chunk-20](figure/unnamed-chunk-20.png) 


###PROBLEM 3.5 - BUILDING A MODEL  (1 point possible)
Obtain the training set predictions for the model (do not yet predict on the test set). Extract the predicted probability of a result being a trial (recall that this involves not setting a type argument, and keeping only the second column of the predict output). What is the maximum predicted probability for any result?


```r
predictTrainCART = predict(trialCART, newdata = train)
predictTrainCART = predictTrainCART[2:ncol(predictTrainCART)]
which.max(predictTrainCART)
```

```
## [1] 1
```

```r
predictTrainCART[1]
```

```
## [1] 0.8636
```


###PROBLEM 3.6 - BUILDING A MODEL  (1 point possible)
Without running the analysis, how do you expect the maximum predicted probability to differ in the testing set?

The maximum predicted probability will likely be exactly the same in the testing set. 

###PROBLEM 3.7 - BUILDING A MODEL  (3 points possible)
For these questions, use a threshold probability of 0.5 to predict that an observation is a clinical trial.


```r
predictTrainCART = predict(trialCART, newdata = train, type = "class")
table(train$trial, predictTrainCART)
```

```
##    predictTrainCART
##       0   1
##   0 635  95
##   1 127 445
```


What is the training set accuracy of the CART model?

```r
(631 + 441)/(631 + 441 + 99 + 131)
```

```
## [1] 0.8233
```


What is the training set sensitivity of the CART model?

```r
441/(441 + 131)
```

```
## [1] 0.771
```


What is the training set specificity of the CART model?

```r
631/(631 + 99)
```

```
## [1] 0.8644
```


###PROBLEM 4.1 - EVALUATING THE MODEL ON THE TESTING SET  (1 point possible)
Evaluate the CART model on the testing set using the predict function and creating a vector of predicted probabilities predTest.

What is the testing set accuracy, assuming a probability threshold of 0.5 for predicting that a result is a clinical trial?


```r
predictTestCART = predict(trialCART, newdata = test)
predProb = predictTestCART[, 2]
table(test$trial, predProb >= 0.5)
```

```
##    
##     FALSE TRUE
##   0   260   53
##   1    81  164
```

```r
(261 + 162)/(261 + 52 + 83 + 162)
```

```
## [1] 0.7581
```



###PROBLEM 4.2 - EVALUATING THE MODEL ON THE TESTING SET  (1 point possible)
Using the ROCR package, what is the testing set AUC of the prediction model?

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
predROCR <- prediction(predProb, test$trial)
perfROCR <- performance(predROCR, "tpr", "fpr")
plot(perfROCR, colorize = T)
```

![plot of chunk unnamed-chunk-27](figure/unnamed-chunk-27.png) 

```r
performance(predROCR, "auc")@y.values
```

```
## [[1]]
## [1] 0.8374
```


PART 5: DECISION-MAKER TRADEOFFS

The decision maker for this problem, a researcher performing a review of the medical literature, would use a model (like the CART one we built here) in the following workflow:

1) For all of the papers retreived in the PubMed Search, predict which papers are clinical trials using the model. This yields some initial Set A of papers predicted to be trials, and some Set B of papers predicted not to be trials. (See the figure below.)

2) Then, the decision maker manually reviews all papers in Set A, verifying that each paper meets the study's detailed inclusion criteria (for the purposes of this analysis, we assume this manual review is 100% accurate at identifying whether a paper in Set A is relevant to the study). This yields a more limited set of papers to be included in the study, which would ideally be all papers in the medical literature meeting the detailed inclusion criteria for the study.

3) Perform the study-specific analysis, using data extracted from the limited set of papers identified in step 2.

This process is shown in the figure below.

![image] (https://courses.edx.org/c4x/MITx/15.071x/asset/InfoRetrievalFigure2.png)

###PROBLEM 5.1 - DECISION-MAKER TRADEOFFS  (1 point possible)
What is the cost associated with the model in Step 1 making a false negative prediction?

A paper that should have been included in Set A will be missed, affecting the quality of the results of Step 3. 

###PROBLEM 5.2 - DECISION-MAKER TRADEOFFS  (1 point possible)
What is the cost associated with the model in Step 1 making a false positive prediction?

A paper will be mistakenly added to Set A, yielding additional work in Step 2 of the process but not affecting the quality of the results of Step 3. 

###PROBLEM 5.3 - DECISION-MAKER TRADEOFFS  (1 point possible)
Given the costs associated with false positives and false negatives, which of the following is most accurate?

A false negative is more costly than a false positive; the decision maker should use a probability threshold less than 0.5 for the machine learning model. 
