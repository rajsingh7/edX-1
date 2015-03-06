ProblemSet 5-1
========================================================
###DETECTING VANDALISM ON WIKIPEDIA

Wikipedia is a free online encyclopedia that anyone can edit and contribute to. It is available in many languages and is growing all the time. On the English language version of Wikipedia:

There are currently 4.3 million pages.
There have been a total of 653 million edits (also called revisions) over its lifetime.
There are approximately 130,000 edits per day.
One of the consequences of being editable by anyone is that some people vandalize pages. This can take the form of removing content, adding promotional or inappropriate content, or more subtle shifts that change the meaning of the article. With this many articles and edits per day it is difficult for humans to detect all instances of vandalism and revert (undo) them. As a result, Wikipedia uses bots - computer programs that automatically revert edits that look like vandalism. In this assignment we will attempt to develop a vandalism detector that uses machine learning to distinguish between a valid edit and vandalism.

The data for this problem is based on the revision history of the page Language. Wikipedia provides a history for each page that consists of the state of the page at each revision. Rather than manually considering each revision, a script was run that checked whether edits stayed or were reverted. If a change was eventually reverted then that revision is marked as vandalism. This may result in some misclassifications, but the script performs well enough for our needs.

As a result of this preprocessing, some common processing tasks have already been done, including lower-casing and punctuation removal. The columns in the dataset are:

Vandal = 1 if this edit was vandalism, 0 if not.
Minor = 1 if the user marked this edit as a "minor edit", 0 if not.
Loggedin = 1 if the user made this edit while using a Wikipedia account, 0 if they were not.
Added = The unique words added.
Removed = The unique words removed.
Notice the repeated use of unique. The data we have available is not the bag of words - rather it is the set of words that were removed or added. For example, if a word was removed multiple times in a revision it will only appear one time in the "Removed" column.

###PROBLEM 1.1 - BAGS OF WORDS  (1 point possible)
Load the data wiki.csv with the option stringsAsFactors=FALSE, calling the data frame "wiki". Convert the "Vandal" column to a factor using the command wiki$Vandal = as.factor(wiki$Vandal).

How many cases of vandalism were detected in the history of this page?


```r
wiki <- read.csv(file.choose(), stringsAsFactors = FALSE)
wiki$Vandal = as.factor(wiki$Vandal)
table(wiki$Vandal)
```

```
## 
##    0    1 
## 2061 1815
```


###PROBLEM 1.2 - BAGS OF WORDS  (1 point possible)
We will now use the bag of words approach to see if we can improve our model further. We now have two columns of textual data, with different meanings. For example, adding rude words has a different meaning to removing rude words. We'll start like we did in class by building a document term matrix from the Added column. The text already is lowercase and stripped of punctuation. So to pre-process the data, just complete the following four steps:

1) Create the corpus for the Added column, and call it "corpusAdded".

2) Remove the English-language stopwords.

3) Stem the words.

4) Build the DocumentTermMatrix, and call it dtmAdded.

How many terms appear in dtmAdded?


```r
library(tm)
```

```
## Warning: package 'tm' was built under R version 3.0.3
```

```r
library(SnowballC)
corpusAdded = Corpus(VectorSource(wiki$Added))
corpusAdded = tm_map(corpusAdded, removeWords, stopwords("english"))
corpusAdded = tm_map(corpusAdded, stemDocument)
frequencies = DocumentTermMatrix(corpusAdded)
dtmAdded <- as.data.frame(as.matrix(frequencies))
ncol(dtmAdded)
```

```
## [1] 6675
```


###PROBLEM 1.3 - BAGS OF WORDS  (1 point possible)
Filter out sparse terms by keeping only terms that appear in 0.3% or more of the revisions, and call the new matrix sparseAdded. How many terms appear in sparseAdded?


```r
sparseAdded = removeSparseTerms(frequencies, 0.997)
ncol(sparseAdded)
```

```
## [1] 166
```


###PROBLEM 1.4 - BAGS OF WORDS  (1 point possible)
Convert sparseAdded to a data frame called wordsAdded, and then prepend all the words with the letter A, by using the command:


```r
wordsAdded <- as.data.frame(as.matrix(sparseAdded))
colnames(wordsAdded) = paste("A", colnames(wordsAdded))
```


Now repeat all of the steps we've done so far (create a corpus, remove stop words, stem the document, create a sparse document term matrix, and convert it to a data frame) to create a Removed bag-of-words dataframe, called wordsRemoved, except this time, prepend all of the words with the letter R:


```r
corpusRemoved = Corpus(VectorSource(wiki$Removed))
corpusRemoved = tm_map(corpusRemoved, removeWords, stopwords("english"))
corpusRemoved = tm_map(corpusRemoved, stemDocument)
f = DocumentTermMatrix(corpusRemoved)
s <- removeSparseTerms(f, 0.997)
wordsRemoved <- as.data.frame(as.matrix(s))
colnames(wordsRemoved) = paste("R", colnames(wordsRemoved))
```


How many words are in the wordsRemoved data frame?


```r
ncol(wordsRemoved)
```

```
## [1] 162
```


###PROBLEM 1.5 - BAGS OF WORDS  (1 point possible)
Combine the two dataframes (using cbind) into a data frame called wikiWords then add the Vandal column (HINT: remember how we added the dependent variable back into our data frame in the Twitter lecture). Set the random seed to 123 and then split the data set using sample.split from the "caTools" package to put 70% in the training set.

What is the accuracy on the test set of a baseline method that always predicts "not vandalism" (the most frequent outcome)?


```r
wikiWords <- as.data.frame(cbind(wordsAdded, wordsRemoved))
wikiWords$Vandal = wiki$Vandal
library(caTools)
```

```
## Warning: package 'caTools' was built under R version 3.0.3
```

```r
set.seed(123)
split = sample.split(wikiWords$Vandal, SplitRatio = 0.7)
train = subset(wikiWords, split == TRUE)
test = subset(wikiWords, split == FALSE)
table(train$Vandal)
```

```
## 
##    0    1 
## 1443 1270
```

```r
1443/(1443 + 1270)
```

```
## [1] 0.5319
```


###PROBLEM 1.6 - BAGS OF WORDS  (1 point possible)
Build a CART model to predict Vandal, using all of the other variables as independent variables. Use the training set to build the model and the default parameters (don't set values for minbucket or cp).

What is the accuracy of the model on the test set, using a threshold of 0.5? (Remember that if you add the argument type="class" when making predictions, the output of predict will automatically use a threshold of 0.5.)


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
wikiCART = rpart(Vandal ~ ., data = train, method = "class")
predictCART = predict(wikiCART, newdata = test, type = "class")
table(test$Vandal, predictCART)
```

```
##    predictCART
##       0   1
##   0 618   0
##   1 533  12
```

```r
(618 + 12)/(618 + 12 + 533)
```

```
## [1] 0.5417
```


###PROBLEM 1.7 - BAGS OF WORDS  (1 point possible)
Plot the CART tree. How many word stems does the CART model use?

```r
prp(wikiCART)
```

![plot of chunk unnamed-chunk-9](figure/unnamed-chunk-9.png) 


###PROBLEM 1.8 - BAGS OF WORDS  (1 point possible)
Given the performance of the CART model relative to the baseline, what is the best explanation of these results?

Although it beats the baseline, bag of words is not very predictive for this problem. 

###PROBLEM 2.1 - PROBLEM-SPECIFIC KNOWLEDGE  (1 point possible)
We weren't able to improve on the baseline using the raw textual information. More specifically, the words themselves were not useful. There are other options though, and in this section we will try two techniques - identifying a key class of words, and counting words.

The key class of words we will use are website addresses. "Website addresses" (also known as URLs - Uniform Resource Locators) are comprised of two main parts. An example would be "http://www.google.com". The first part is the protocol, which is usually "http" (HyperText Transfer Protocol). The second part is the address of the site, e.g. "www.google.com". We have stripped all punctuation so links to websites appear in the data as one word, e.g. "httpwwwgooglecom". We hypothesize that given that a lot of vandalism seems to be adding links to promotional or irrelevant websites, the presence of address is a sign of vandalism.

We can search for the presence of a web address in the words added by searching for "http" in the Added column. The grepl function returns TRUE if a string is found in another string, e.g.


```r
grepl("cat", "dogs and cats", fixed = TRUE)  # TRUE
```

```
## [1] TRUE
```

```r
grepl("cat", "dogs and rats", fixed = TRUE)  # FALSE
```

```
## [1] FALSE
```


Create a copy of your dataframe from the previous question:


```r
wikiWords2 = wikiWords
```


Make a new column in wikiWords2 that is 1 if "http" was in Added:


```r
wikiWords2$HTTP = ifelse(grepl("http", wiki$Added, fixed = T), 1, 0)
```


Based on this new column, how many revisions added a link?


```r
table(wikiWords2$HTTP)
```

```
## 
##    0    1 
## 3659  217
```


###PROBLEM 2.2 - PROBLEM-SPECIFIC KNOWLEDGE  (1 point possible)
Use the split that we created before to make new training and testing sets:


```r
train2 = subset(wikiWords2, split == T)
test2 = subset(wikiWords2, split == F)
```


Then create a new CART model using this new variable as one of the independent variables.

What is the new accuracy of the CART model on the test set, using a threshold of 0.5?


```r
wiki2CART = rpart(Vandal ~ ., data = train2, method = "class")
predict2CART = predict(wiki2CART, newdata = test2, type = "class")
table(test2$Vandal, predict2CART)
```

```
##    predict2CART
##       0   1
##   0 609   9
##   1 488  57
```

```r
(609 + 57)/(488 + 57 + 609)
```

```
## [1] 0.5771
```

```r
prp(wiki2CART)
```

![plot of chunk unnamed-chunk-15](figure/unnamed-chunk-15.png) 


###PROBLEM 2.3 - PROBLEM-SPECIFIC KNOWLEDGE  (1 point possible)
Another possibility is that the number of words added and removed is predictive, perhaps more so than the actual words themselves. We already have a word count available in the form of the document-term matrices (DTMs).

Sum the rows of dtmAdded and dtmRemoved and add them as new variables in your data frame 

wikiWords2 (called NumWordsAdded and NumWordsRemoved) by using the following commands:

```r
wikiWords2$NumWordsAdded = rowSums(as.matrix(dtmAdded))
wikiWords2$NumWordsRemoved = rowSums(as.matrix(dtmRemoved))
```

```
## Error: �Ҳ�������'dtmRemoved'
```


What is the average number of words added?

```r
mean(wikiWords2$NumWordsAdded)
```

```
## [1] 4.05
```


###PROBLEM 2.4 - PROBLEM-SPECIFIC KNOWLEDGE  (1 point possible)
Then, use your orginal split (do not generate the split again) to split the data into a training set and testing set, like we did in Problem 2.2. Create the CART model again (using the training set and the default parameters).

What is the new accuracy of the CART model on the test set?


```r
train2 = subset(wikiWords2, split == T)
test2 = subset(wikiWords2, split == F)
wiki2RCART = rpart(Vandal ~ ., data = train2, method = "class")
predict2RCART = predict(wiki2RCART, newdata = test2, type = "class")
table(test2$Vandal, predict2RCART)
```

```
##    predict2RCART
##       0   1
##   0 330 288
##   1 144 401
```

```r
(248 + 514)/(514 + 104 + 297 + 248)
```

```
## [1] 0.6552
```


###PROBLEM 3.1 - USING NON-TEXTUAL DATA  (1 point possible)
We have two pieces of "metadata" (data about data) that we haven't yet used. Make a copy of wikiWords2, and call it wikiWords3:


```r
wikiWords3 = wikiWords2
```


Then add the two original variables Minor and Loggedin to this new data frame:


```r
wikiWords3$Minor = wiki$Minor
wikiWords3$Loggedin = wiki$Loggedin
```


Use the original split to subset wikiWords3 into a training and a test set.

Build a CART model using all the training data. What is the accuracy of the model on the test set?

```r
train3 = subset(wikiWords3, split == T)
test3 = subset(wikiWords3, split == F)
wiki3CART = rpart(Vandal ~ ., data = train3, method = "class")
predict3CART = predict(wiki3CART, newdata = test3, type = "class")
table(test3$Vandal, predict3CART)
```

```
##    predict3CART
##       0   1
##   0 596  22
##   1 311 234
```

```r
(595 + 241)/(595 + 241 + 304 + 23)
```

```
## [1] 0.7188
```


###PROBLEM 3.2 - USING NON-TEXTUAL DATA  (1 point possible)
There is a substantial difference in the accuracy of the model using the meta data. Is this because we made a more complicated model?

Plot the CART tree. How many splits are there in the tree?


```r
prp(wiki3CART)
```

![plot of chunk unnamed-chunk-22](figure/unnamed-chunk-22.png) 
