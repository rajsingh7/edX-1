IBM <- read.csv(file.choose())

GE <- read.csv(file.choose())

ProcterGamble <- read.csv(file.choose())

CocaCola <- read.csv(file.choose())

Boeing <- read.csv(file.choose())

str(IBM)

# convert the dates into a format that R can understand. 

IBM$Date = as.Date(IBM$Date, "%m/%d/%y")

GE$Date = as.Date(GE$Date, "%m/%d/%y")

CocaCola$Date = as.Date(CocaCola$Date, "%m/%d/%y")

ProcterGamble$Date = as.Date(ProcterGamble$Date, "%m/%d/%y")

Boeing$Date = as.Date(Boeing$Date, "%m/%d/%y")

# Q1 Our five datasets all have the same number of observations. How many observations are there in each data set?

str(GE)

# Q2 What is the earliest year in our datasets?

GE$Date[which.min(GE$Date)]

# Q3 What is the latest year in our datasets?

GE$Date[which.max(GE$Date)]

# Q4 What is the mean stock price of IBM over this time period?

mean(IBM$StockPrice)


# Q5 What is the minimum stock price of General Electric (GE) over this time period?

GE$StockPrice[which.min(GE$StockPrice)]

# Q6 What is the maximum stock price of Coca-Cola over this time period?

CocaCola$StockPrice[which.max(CocaCola$StockPrice)]

# Q7 What is the median stock price of Boeing over this time period?

median(Boeing$StockPrice)

# Q8 What is the standard deviation of the stock price of Procter & Gamble over this time period?

sd(ProcterGamble$StockPrice)

# Q9 Around what year did Coca-Cola has its highest stock price in this time period?

plot(CocaCola$Date, CocaCola$StockPrice, type = "l")

CocaCola$Date[which.max(CocaCola$StockPrice)]

# Q10 Around what year did Coca-Cola has its lowest stock price in this time period?

CocaCola$Date[which.min(CocaCola$StockPrice)]

# Q11 In March of 2000, the technology bubble burst, and a stock market crash occurred. 
# According to this plot,  which company's stock dropped more?

lines(ProcterGamble$Date, ProcterGamble$StockPrice, col='red')
abline(v=as.Date(c("2000-03-01")), lwd=2)

# Q 12 Around 1983, the stock for one of these companies (Coca-Cola or Procter and Gamble)
# was going up, while the other was going down. Which one was going up?

abline(v=as.Date(c("1983-06-01")), lwd=2)

# Q 13 In the time period shown in the plot, which stock generally has lower values?

mean(ProcterGamble$StockPrice) - mean(CocaCola$StockPrice)

# Q14 Which stock fell the most right after the technology bubble burst in March 2000?

plot(CocaCola$Date[301:432], CocaCola$StockPrice[301:432], type="l", col="red", ylim=c(0,210))
lines(IBM$Date[301:432], IBM$StockPrice[301:432], col='black')
lines(GE$Date[301:432], GE$StockPrice[301:432], col='blue')
lines(Boeing$Date[301:432], Boeing$StockPrice[301:432], col='green')
lines(ProcterGamble$Date[301:432], ProcterGamble$StockPrice[301:432], col='yellow')
comp = c('IBM','GE','Boeing','ProcterGamble','CocaCola')
c6 <- c('black','blue','green','yellow','red')
legend("topright",legend = comp[1:6], col = c6, text.col = c6,seg.len = 0)

abline(v=as.Date(c("2000-03-01")), lwd=2)


# Q15 Which stock reaches the highest value in the time period 1995-2005?


# Q 16 In October of 1997, there was a global stock market crash that was caused by an economic crisis in Asia. Comparing September 1997 to November 1997, which companies saw a decreasing trend in their stock price?

abline(v=as.Date(c("1997-09-01")), lwd=2)
abline(v=as.Date(c("1997-12-01")), lwd=2)

# Q 17 In the last two years of this time period (2004 and 2005) which stock seems to be performing the best, in terms of increasing stock price?

# Q 18 For IBM, compare the monthly averages to the overall average stock price. In which months has IBM historically had a higher stock price (on average)?

mmIBM <- tapply(IBM$StockPrice, months(IBM$Date), mean)
mmIBM > mean(IBM$StockPrice)

# Q19 General Electric and Coca-Cola both have their highest average stock price in the same month. Which month is this?
mmGE <- tapply(GE$StockPrice, months(GE$Date), mean)
which.max(mmGE)


# Q20 For the months of December and January, every company's average stock is higher in one month and lower in the other. In which month are the stock prices lower?
mmGE[12] - mmGE[7]