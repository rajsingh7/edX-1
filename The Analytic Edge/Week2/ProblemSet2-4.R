#Analytic Edge ProblemSet2-4 

FluTrain = read.csv(file.choose())

# Q1 , which week corresponds to the highest percentage of ILI-related physician visits? 
# Q2 Which week corresponds to the highest percentage of ILI-related query fraction?
FluTrain$Week[which.max(FluTrain$ILI)]
FluTrain$Week[which.max(FluTrain$Queries)]

# Q3 Plot the histogram of the dependent variable, ILI. 
# What best describes the distribution of values of ILI?
hist(FluTrain$ILI,breaks = 30)
# seem to be a expentional distribution that has a long/fat tail 

# Q4 Plot the natural logarithm of ILI versus Queries. What does the plot suggest?.
plot(log(FluTrain$ILI), FluTrain$Queries)

# Q5 Based on our understanding of the data from the previous subproblem, 
# which model best describes our estimation problem?

# ans log(ILI) = intercept + coefficient x Queries, where the coefficient is positive 

# call the regression model from the previous problem (Problem 2.1) FluTrend1 and run it in R. 
# Q6 What is the training set R-squared value for FluTrend1 model?
model = lm(log(ILI) ~ Queries, data = FluTrain)
summary(model)

# Q7 the correlation between the independent and the dependent variables. 
correlation = cor(log(FluTrain$ILI), FluTrain$Queries)
correlation^2

FluTest = read.csv(file.choose())
PredTest1 = exp(predict(model, newdata=FluTest))
PredTest1[11]

# Q8 What is the relative error betweeen the estimate and the observed for that week? 
abs((PredTest1[11] - FluTest$ILI[11])/FluTest$ILI[11])

# Q9 What is the Root Mean Square Error (RMSE) between our estimates and the actual 
# observations for the percentage of ILI-related physician visits?
sqrt(sum((PredTest1 - FluTest$ILI)^2)/nrow(FluTest))

install.packages("zoo")
library(zoo)
ILILag2 = lag(zoo(FluTrain$ILI), -2, na.pad=TRUE)
FluTrain$ILILag2 = coredata(ILILag2)

# Q21 How many values are missing in the new ILILag2 variable?
sum(is.na(FluTrain$ILILag2))

# Q22 Use the plot() function to plot the log of ILILag2 against the log of ILI.
# Which best describes the relationship between these two variables
plot(log(FluTrain$ILI),log(FluTrain$ILILag2))

# Q23 Train a linear regression model on the FluTrain dataset to predict the log of
# the ILI variable using the Queries variable as well as the log of the ILILag2 variable.
# Call this model FluTrend2.
# Which coefficients are significant at the p=0.05 level in this regression model?

# Q24 What is the R^2 value of the FluTrend2 model?
model2 = lm(log(ILI) ~ log(ILILag2) + Queries, data = FluTrain)
summary(model2)

# Q25 On the basis of R-squared value and significance of coefficients, which statement 
# is the most accurate?

# Q26 How many missing values are there in this new variable?
ILILag2 = lag(zoo(FluTest$ILI), -2, na.pad=TRUE)
FluTest$ILILag2 = coredata(ILILag2)

sum(is.na(FluTest$ILILag2))

# Q27 Which value should be used to fill in the ILILag2 variable for the first observation in FluTest?
# Q28 Which value should be used to fill in the ILILag2 variable for the second observation in FluTest?
FluTest$ILILag2[1] = FluTrain$ILI[nrow(FluTrain)-1]
FluTest$ILILag2[2] = FluTrain$ILI[nrow(FluTrain)]

# Q29 What is the new value of the ILILag2 variable in the first row of FluTest?
# Q30 What is the new value of the ILILag2 variable in the second row of FluTest?


# 1.8527356
# 2.1241299

# Q31 What is the test-set RMSE of the FluTrend2 model?
PredTest2 = exp(predict(model2, newdata=FluTest))
sqrt(sum((PredTest2 - FluTest$ILI)^2)/nrow(FluTest))


