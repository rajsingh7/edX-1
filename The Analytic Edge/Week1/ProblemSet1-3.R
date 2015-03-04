# ProblemSet1 - 3

# Load data
poll = read.csv(file.choose())

# Q1 How many people participated in the poll?
str(poll)
summary(poll)

# Q2 How many interviewees responded that they use a smartphone?
# Q3 How many interviewees responded that they don't use a smartphone?
table(poll$Smartphone)

# Q4 How many interviewees did not respond to the question, resulting
# in a missing value, or NA, in the summary() output?
summary(poll$Smartphone)

table(poll$Sex, poll$Region)

# Q5 Which of the following are states in the Midwest census region?
table(poll$State, poll$Region)
table(poll$Region, poll$State)

sort(table(poll$Region, poll$State)[1,1:ncol(table(poll$Region, poll$State))], decreasing = T)

# Q6 Which was the state in the South census region with the largest
# number of interviewees?
which.max(table(poll$Region, poll$State)[3,1:ncol(table(poll$Region, poll$State))])

# Q7 How many interviewees reported neither Internet use nor smartphone use?
nrow(subset(poll, poll$Internet.Use == 0 & poll$Smartphone == 0))

# Q8 How many interviewees reported both Internet use and smartphone use?
nrow(subset(poll, poll$Internet.Use == 1 & poll$Smartphone == 1))

# Q9 How many interviewees reported Internet use but no smartphone use?
nrow(subset(poll, poll$Internet.Use == 1 & poll$Smartphone == 0))

# Q10 How many interviewees reported smartphone use but no Internet use?
nrow(subset(poll, poll$Internet.Use == 0 & poll$Smartphone == 1))

# Q11 How many interviewees have a missing value for their Internet use?
sum(is.na(poll$Internet.Use))

# Q12 How many interviewees have a missing value for their smartphone use?
sum(is.na(poll$Smartphone))

# Use the subset function to obtain a data frame called "limited", which 
# limited to interviewees who reported Internet use or who reported 
# Smartphone use.

limited = subset(poll, poll$Internet.Use == 1 | poll$Smartphone == 1)

# Q13 How many interviewees are in the new data frame?

str(limited)

# Q 14 Which variables have missing values in the limited data frame?
# nam = names(limited)
# numna = c(1:13)
# for (i in 1:13){
#   t = nam[i]
#   numna[i] = sum(is.na(paste("limited$",t)))
# }
# 
# numna

     
sum(is.na(limited$Internet.Use))
sum(is.na(limited$Smartphone))
sum(is.na(limited$Sex))
sum(is.na(limited$Age))
sum(is.na(limited$State))
sum(is.na(limited$Region))
sum(is.na(limited$Conservativeness))
sum(is.na(limited$Info.On.Internet))
sum(is.na(limited$Worry.About.Info))
sum(is.na(limited$Privacy.Importance))
sum(is.na(limited$Anonymity.Possible))
sum(is.na(limited$Tried.Masking.Identity))
sum(is.na(limited$Privacy.Laws.Effective))

# Q15 What is the average number of pieces of personal information 
# on the Internet, according to the Info.On.Internet variable?
mean(limited$Info.On.Internet)

# Q16 How many interviewees reported a value of 0 for Info.On.Internet?
sum(limited$Info.On.Internet == 0)

# Q17 How many interviewees reported the maximum value of 11 for
# Info.On.Internet?
sum(limited$Info.On.Internet == 11)

# Q18 What proportion of interviewees who answered the Worry.About.Info
# question worry about how much information is available about them on 
# the Internet?
table(limited$Worry.About.Info)[2]/nrow(limited)

# Q19 What proportion of interviewees who answered the Anonymity.Possible
# question who think it is possible to be completely anonymous on the
# Internet?
table(limited$Anonymity.Possible)[2]/(table(limited$Anonymity.Possible)[1]+table(limited$Anonymity.Possible)[2])

# Q20 What proportion of interviewees who answered the 
# Tried.Masking.Identity question have tried masking their 
# identity on the Internet?
table(limited$Tried.Masking.Identity)[2]/(table(limited$Tried.Masking.Identity)[1]+table(limited$Tried.Masking.Identity)[2])

# Q21 What proportion of interviewees who answered the Privacy.Laws.Effective
# question find United States privacy laws effective?
table(limited$Privacy.Laws.Effective)[2]/(table(limited$Privacy.Laws.Effective)[1]+table(limited$Privacy.Laws.Effective)[2])

# Q22 Build a histogram of the age of interviewees. 
# What is the best represented age group in the population?
hist(limited$Age)

# Q23 What is the largest number of interviewees that have exactly 
# the same value in their Age variable AND the same value in their
# Info.On.Internet variable? 
plot(limited$Age, limited$Info.On.Internet)
table(limited$Age, limited$Info.On.Internet)[which.max(table(limited$Age, limited$Info.On.Internet))]

# Q24 To avoid points covering each other up, we can use the jitter() 
# function on the values we pass to the plot function. Experimenting 
# with the command jitter(c(1, 2, 3)), what appears to be the 
# functionality of the jitter command?
jitter(c(1, 2, 3))

# Q25  plot Age against Info.On.Internet with plot(jitter(limited$Age), 
# jitter(limited$Info.On.Internet)). What relationship to you observe 
# between Age and Info.On.Internet?
plot(jitter(limited$Age),jitter(limited$Info.On.Internet))

# Q26 What is the average Info.On.Internet value for smartphone users?
# Q27 What is the average Info.On.Internet value for non-smartphone users?
tapply(limited$Info.On.Internet, limited$Smartphone, mean) 

# Q28 What proportion of smartphone users who answered the
# Tried.Masking.Identity question have tried masking their identity 
# when using the Internet?
table(limited$Tried.Masking.Identity, limited$Smartphone)
93/(390+93)
33/(33+248)
tapply(limited$Tried.Masking.Identity, limited$Smartphone, table)



# Q29 What proportion of non-smartphone users who answered the
# Tried.Masking.Identity question have tried masking their 
# identity when using the Internet?

































