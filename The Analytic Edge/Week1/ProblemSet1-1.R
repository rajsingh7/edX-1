mvt <- read.csv(file.choose())

# Q1 How many rows of data (observations) are in this dataset?
# Q2 How many variables are in this dataset?
str(mvt)

# Q3 Using the "max" function, what is the maximum value of the variable "ID"?

max(mvt$ID)

# Q4 What is the minimum value of the variable "Beat"?

min(mvt$Beat)

# Q5 How many observations have value TRUE in the Arrest variable (this is the number of crimes for which an arrest was made)?

sum(mvt$Arrest == T)

# Q6 How many observations have value a LocationDescription value of ALLEY?
sum(mvt$LocationDescription == "ALLEY")

# Q7 In what format are the entries in the variable Date?
head(mvt$Date)

DateConvert = as.Date(strptime(mvt$Date, "%m/%d/%y %H:%M"))

# Q8 What is the month and year of the median date in our dataset?
median(DateConvert)

mvt$Month = months(DateConvert)

mvt$Weekday = weekdays(DateConvert)

mvt$Date = DateConvert

# Q 10 In which month did the fewest motor vehicle thefts occur?

which.min(table(mvt$Month))

# Q 11 On which weekday did the most motor vehicle thefts occur?

which.max(table(mvt$Weekday))

# Q 12 Which month has the largest number of motor vehicle thefts for which an arrest was made?

which.max(table(subset(mvt,mvt$Arrest == T)$Month))

hist(mvt$Date, breaks=100)

# Q 13 Does it look like crime increases or decreases from 2002 - 2012?

# Q 14 Does it look like crime increases or decreases from 2005 - 2008?

# Q 15 Does it look like crime increases or decreases from 2009 - 2011?

#  Create a boxplot of the variable "Date", sorted by the variable "Arrest"

# Q 16 Does it look like there were more crimes for which arrests were made in the first half of the time period or the second half of the time period? 
boxplot(mvt$Date, mvt$Arrest)

# Q 17 For what proportion of motor vehicle thefts in 2001 was an arrest made?
table(subset(mvt,mvt$Year == 2001)$Arrest)[2]/sum(table(subset(mvt,mvt$Year == 2001)$Arrest))

# Q 18 For what proportion of motor vehicle thefts in 2007 was an arrest made?
table(subset(mvt,mvt$Year == 2007)$Arrest)[2]/sum(table(subset(mvt,mvt$Year == 2007)$Arrest))

# Q 19 For what proportion of motor vehicle thefts in 2012 was an arrest made?
table(subset(mvt,mvt$Year == 2012)$Arrest)[2]/sum(table(subset(mvt,mvt$Year == 2012)$Arrest))

# Q 20 Which locations are the top five locations for motor vehicle thefts, excluding the "Other" category?

sort(table(mvt$LocationDescription))

# Create a subset of your data, only taking observations for which the theft happened in one of these five locations, and call this new data set "Top5". 

# Q 21 How many observations are in Top5?
topnames = names(sort(table(mvt$LocationDescription)))[73:78]
Top5names = c(topnames[1:3],topnames[5:6])
Top5 <- subset(mvt, mvt$LocationDescription == Top5names[1] |mvt$LocationDescription == Top5names[2]|mvt$LocationDescription == Top5names[3]|mvt$LocationDescription == Top5names[4]|mvt$LocationDescription == Top5names[5])

nrow(Top5)

# Q 22 One of the locations has a much higher arrest rate than the other locations. Which is it?
Top5$LocationDescription = factor(Top5$LocationDescription)

which.max(table(Top5$LocationDescription) )

which.max(table(subset(Top5,Top5$Arrest == T)$LocationDescription)/table(Top5$LocationDescription))

# Q 23 On which day of the week do the most motor vehicle thefts at gas stations happen?

Gas = subset(Top5, Top5$LocationDescription == "GAS STATION")
which.max(table(Gas$Weekday))

# Q 24 On which day of the week do the fewest motor vehicle thefts in residential driveways happen?

Res = subset(mvt, mvt$LocationDescription == "DRIVEWAY - RESIDENTIAL")
which.min(table(Res$Weekday))
