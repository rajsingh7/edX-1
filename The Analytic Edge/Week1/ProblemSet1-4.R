# ProblemSet 1 - 4
# load data
CPS <- read.csv(file.choose())

# Q1 How many interviewees are in the dataset?
str(CPS)

# Q2 Among the interviewees with a value reported for the Industry 
# variable, what is the most common industry of employment?
which.max(table(CPS$Industry))

sort(table(CPS$Region))
# Q3 Which state has the fewest interviewees?
# Q4 Which state has the largest number of interviewees?
sort(table(CPS$State))

# Q5 What proportion of interviewees are citizens of the United States?
unique(CPS$Citizenship)
sort(table(CPS$Citizenship))
(7073+116639)/(7073+7590+116639)

# Q6  For which races are there at least 250 interviewees in
# the CPS dataset of Hispanic ethnicity?
table(subset(CPS,CPS$Hispanic == 1)$Race)>250

# Q7 Which variables have at least one interviewee with a missing (NA) value?
summary(CPS)

is.na(CPS$Married)
# Q8 We can see the breakdown of whether Married is missing based on the 
# reported value of the Region variable with the function
# table(CPS$Region, is.na(CPS$Married)). Which is the most accurate:
table(CPS$Region, is.na(CPS$Married))
table(CPS$Sex, is.na(CPS$Married))
table(CPS$Age, is.na(CPS$Married))
table(CPS$Citizenship, is.na(CPS$Married))

# Q9 How many states had all interviewees living in a non-metropolitan
# area (aka they have a missing MetroAreaCode value)? 
t = table(CPS$State, is.na(CPS$MetroAreaCode))
sum(t[1:nrow(t),2] == 0)

# Q10 How many states had all interviewees living in a metropolitan area? 
# Again, treat the District of Columbia as a state.
sum(t[1:nrow(t),1] == 0)

# Q11 Which region of the United States has the largest proportion of 
# interviewees living in a non-metropolitan area?
table(CPS$Region, is.na(CPS$MetroAreaCode))

# Q12 Which state has a proportion of interviewees living in
# a non-metropolitan area closest to 30%?
t = tapply(is.na(CPS$MetroAreaCode), CPS$State, mean)
t = abs(t - 0.3)
t[which.min(t)]

# Q13 Which state has the largest proportion of non-metropolitan
# interviewees, ignoring states where all interviewees were non-metropolitan?
t = tapply(is.na(CPS$MetroAreaCode), CPS$State, mean)
sort(t, decreasing = T)

MetroAreaMap = read.csv(file.choose())

# Q14 How many metropolitan areas are stored in MetroAreaMap?
str(MetroAreaMap)

CPS = merge(CPS, MetroAreaMap, by.x="MetroAreaCode", by.y="Code", all.x=TRUE)

# Q15 What is the name of the variable that was added to the 
# data frame by the merge() operation?
names(CPS)

# Q16 How many interviewees have a missing value for the new
# metropolitan area variable? 
sum(is.na(CPS$MetroArea))

# Q17 Which of the following metropolitan areas has the largest number of interviewees?
# Atlanta-Sandy Springs-Marietta, GA
# Baltimore-Towson, MD 
# Boston-Cambridge-Quincy, MA-NH 
# San Francisco-Oakland-Fremont, CA
sort(table(CPS$MetroArea))

# Q18 Which metropolitan area has the highest proportion of 
# interviewees of Hispanic ethnicity?
sort(tapply(CPS$Hispanic, CPS$MetroArea, mean), decreasing = T)[1]

# Q 19 determine the number of metropolitan areas in the United States
# from which at least 20% of interviewees are Asian.
sum(sort(tapply(CPS$Race == "Asian", CPS$MetroArea, mean), decreasing = T)>0.2)


# Q 20 determine which metropolitan area has the smallest proportion
# of interviewees who have received no high school diploma.
sort(tapply(CPS$Education == "No high school diploma", CPS$MetroArea, mean,na.rm=TRUE))[1]


CountryMap = read.csv(file.choose())

str(CountryMap)
# Q21 What is the name of the variable added to the CPS data frame by this merge operation?
CPS = merge(CPS, CountryMap, by.x="CountryOfBirthCode", by.y="Code", all.x=TRUE)

# Q22 How many interviewees have a missing value for the new country of birth variable?
sum(is.na(CPS$Country))

# Q23 Among all interviewees born outside of North America, 
# which country was the most common place of birth?

sort(table(CPS$Country))

# Q 24 What proportion of the interviewees from the "New York-Northern New Jersey-Long 
# Island, NY-NJ-PA" metropolitan area have a country of birth that is not the United States?

Long = subset(CPS, CPS$MetroArea == "New York-Northern New Jersey-Long Island, NY-NJ-PA")
Long = subset(Long, is.na(Long$Country)==F)

sum(sort(table(Long$Country)))

(5404-3736)/5404

# Q 25 Which metropolitan area has the largest number (note -- not proportion) of 
# interviewees with a country of birth in India?
IndiaOrigin = subset(CPS, CPS$Country == "India")
sort(table(IndiaOrigin$MetroArea))

# Q 26 In Brazil?

BrazilOrigin = subset(CPS, CPS$Country == "Brazil")
sort(table(BrazilOrigin$MetroArea))
# Q 27 In Somalia?
SomaliaOrigin = subset(CPS, CPS$Country == "Somalia")
sort(table(SomaliaOrigin$MetroArea))






















