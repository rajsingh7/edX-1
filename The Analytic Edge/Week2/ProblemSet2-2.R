# Analytic Edge Week2 ProblemSet 2-2

data = read.csv(file.choose())

train = subset(data, data$Year <= 2006)

test = subset(data, data$Year >2006)

# Q1 build a linear regression model using all of the independent variables 
# (except Year and Month) to predict the dependent variable Temp. Enter the model R2:
# Q2 Which variables are significant in the model? We will consider a variable signficant
# only if the p-value is below 0.05.
model0 = lm(Temp ~ MEI + CO2 + CH4 + N2O + CFC.11 + CFC.12 + TSI + Aerosols,data = train)
summary(model0)

# Q3 the regression coefficients of both the N2O and CFC-11 variables are negative,
# Which of the following is the simplest correct explanation for this contradiction?

# ans All of the gas concentration variables reflect human development - N2O and CFC.11 are 
# correlated with other variables in the data set.

# Q4 Compute the correlations between all the variables in the training set. Which of
# the following independent variables is N2O highly correlated with
# (absolute correlation greater than 0.7)?

# Q5 Which of the following independent variables is CFC.11 highly correlated with?

cor(train)

# Q6 focus on the N2O variable and build a model with only MEI, TSI, Aerosols and N2O.
# Remember to use the training set to build the model.
# Enter the coefficient of N2O in this reduced model:

model1 = lm(Temp ~ MEI + TSI + Aerosols + N2O, data = train)
summary(model1)
# ans 2.532e-02

# Q7 Enter the model R2:
# ans 0.7261

# Q8 function, step, that will automate the procedure of trying different combinations
# of variables to find a good compromise of model simplicity and R2. This trade-off is 
# formalized by the Akaike information criterion (AIC)

# Enter the R2 value of the model produced by the step function:
model2 = step(model0)
summary(model2)

# Q9 Which of the following variable(s) were eliminated from the full model by the step function?

predTemp = predict(model2, test)

RSS = sum((predTemp - test$Temp)^2)
TSS = sum((mean(train$Temp)-test$Temp)^2)
RS = 1-RSS/TSS
RS
