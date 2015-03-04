# Analytic Edge Week2 ProblemSet 2-3

pisaTrain = read.csv(file.choose())
pisaTest = read.csv(file.choose())

# Q1 How many students are there in the training set?
str(pisaTrain)

# Q2 Using tapply() on pisaTrain, what is the average reading test score of males?
# Q3 Using tapply() on pisaTrain, what is the average reading test score of females?
tapply(pisaTrain$readingScore, pisaTrain$male ,mean)

# Q4 Which variables are missing data in at least one observation in the training set?
summary(pisaTrain)

pisaTrain = na.omit(pisaTrain)

pisaTest = na.omit(pisaTest)

# Q5 How many observations are now in the training set?
nrow(pisaTrain)
# Q6 How many observations are now in the testing set?
nrow(pisaTest)

# Q7 Which of the following variables is an unordered factor with at least 3 levels?
# grade 
# male 
# raceeth 
unique(pisaTrain$grade)
unique(pisaTrain$male)
unique(pisaTrain$raceeth)

# Q8 Which of the following variables is an ordered factor with at least 3 levels?
# grade 
# male 
# raceeth 

# Q9 Which binary variables will be included in the regression model?

# Q10 For a student who is Asian, which binary variables would be set to 0? 
# All remaining variables will be set to 1.

# Q11 For a student who is white, which binary variables would be set to 0? 
# All remaining variables will be set to 1.

pisaTrain$raceeth = relevel(pisaTrain$raceeth, "White")

pisaTest$raceeth = relevel(pisaTest$raceeth, "White")

# Q12 What is the Multiple R-squared value of lmScore on the training set?
lmmodel = lm(readingScore~ . , data = pisaTrain)
summary(lmmodel)
# ans 0.3251

# Q13 What is the training-set root-mean squared error (RMSE) of lmScore?
RMSE = sqrt(sum((predict(lmmodel, pisaTrain) - pisaTrain$readingScore)^2)/nrow(pisaTrain))
RMSE

# Q14 Consider two students A and B. They have all variable values the same, except that
# student A is in grade 11 and student B is in grade 9. What is the predicted reading 
# score of student A minus the predicted reading score of student B?
29.542707*(11-9)

# Q15 What is the meaning of the coefficient associated with variable raceethAsian?

# Q16 Using the "predict" function and supplying the "newdata" argument, use the lmScore
# model to predict the reading scores of students in pisaTest. Call this vector of predictions
# "predTest". Do not change the variables in the model (for example, do not remove variables
# that we found were not significant in the previous part of this problem). Use the summary
# function to describe the test set predictions.
# What is the range between the maximum and minimum predicted reading score on the test set?
lmscore = predict(lmmodel, pisaTest)

# Q17 What is the sum of squared errors (SSE) of lmScore on the testing set?
RSS = sum((lmscore - pisaTest$readingScore)^2)
RSS

# Q18 What is the root-mean squared error (RMSE) of lmScore on the testing set?

RMSE = sqrt(sum((predict(lmmodel, pisaTest) - pisaTest$readingScore)^2)/nrow(pisaTest))
RMSE

# Q19 What is the predicted test score used in the baseline model? Remember to
# compute this value using the training set and not the test set.
mean(pisaTrain$readingScore)

# Q20 What is the sum of squared errors of the baseline model on the testing set?
TSS = sum((mean(pisaTrain$readingScore)-pisaTest$readingScore)^2)
TSS

R2 = 1-RSS/TSS

R2



