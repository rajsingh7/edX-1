# Analytic Edge Week2 ProblemSet 2-1

data(state)

statedata = cbind(data.frame(state.x77), state.abb, state.area, state.center,  state.division, state.name, state.region)

str(statedata)
# Q1 In the R command you used to generate this plot, which variable name did you use as the first argument?
plot(statedata$x, statedata$y)

# Q2 determine which region of the US (West, North Central, South, or Northeast) has the highest average 
# high school graduation rate of all the states in the region:
which.max(tapply(statedata$HS.Grad, statedata$state.region, mean))

# Q3 Which region has the highest median murder rate?
boxplot(statedata$Murder~statedata$state.region)

# Q4 You should see that there is an outlier in the Northeast region of
# the boxplot you just generated. Which state does this correspond to? 
Northeast = subset(statedata,statedata$state.region == "Northeast")
row.names(Northeast)[which.max(Northeast$Murder)]


# Q5 build a model to predict life expectancy by state
# Build the model with all potential variables included 
# (Population, Income, Illiteracy, Murder, HS.Grad, Frost, and Area).
# What is coefficient for income?
model0 = lm(Life.Exp ~ Population + Income + Illiteracy + Murder + HS.Grad + Frost + Area, data = statedata)
summary(model0)

# Q6 Call the coefficient for income x (the answer to Problem 2.1). 
# What is the interpretation of the coefficient x?

# ans :For a one unit increase in income, predicted life expectancy decreases by |x| Status: correct

plot(statedata$Income, statedata$Life.Exp)

# Q7 Visually observe the plot. What appears to be the relationship?

# ans Life expectancy is somewhat positively correlated with income

# Q8 The model we built does not display the relationship we saw from the plot of life expectancy
# vs. income. Which of the following explanations seems the most reasonable? 

# ans  Multicollinearity

# Q9 Perform "backwards variable selection" Which variables does this model contain?
model1 = lm(Life.Exp ~ Population + Income + Illiteracy + Murder + HS.Grad + Frost, data = statedata)
summary(model1)

model2 = lm(Life.Exp ~ Population + Income + Murder + HS.Grad + Frost, data = statedata)
summary(model2)

model3 = lm(Life.Exp ~ Population + Murder + HS.Grad + Frost, data = statedata)
summary(model3)

# ans Population, Murder, Frost, HS.Grad

# Q10 Removing insignificant variables often changes the R-squared values of the model.
# By looking at the summary output of the initial and simplified models and using what 
# you learned in class, which of the following correctly explains the changes in the 
# Multiple R-squared value?

# ans We expect the "Multiple R-squared" of the simplified model to be slightly worse

# Q11 Which state do we predict to have the lowest life expectancy? 
sort(predict(model3, statedata))[1]

# Q12 Which state actually has the lowest life expectancy? 
row.names(statedata)[which.min(statedata$Life.Exp)]

# Q13 Which state do we predict to have the highest life expectancy?
sort(predict(model3, statedata))[nrow(statedata)]

# Q14 Which state actually has the highest life expectancy?
row.names(statedata)[which.max(statedata$Life.Exp)]

RSS = sum((predict(model3, statedata) - statedata$Life.Exp)^2)
# Q15 For which state do we make the smallest absolute error?
which.min(abs(predict(model3, statedata) - statedata$Life.Exp))

# Q16 For which state do we make the largest absolute error?
which.max(abs(predict(model3, statedata) - statedata$Life.Exp))


