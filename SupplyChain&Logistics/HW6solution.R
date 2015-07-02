#HW6-1
# Q1
qnorm(1-1/1000,3500,275)

#HW6-2 Q2 
# data table method
Q =  seq(2500,4500,50)
x = seq(2500,4500,50)
df <- as.data.frame(matrix(0, length(x), length(Q)))
row.names(df) <-x
names(df) <- Q
for (r in 1:nrow(df)){
  for (c in 1:ncol(df)){
    xval = as.numeric(row.names(df)[r])
    Qval = as.numeric(names(df)[c])
    df[r,c] = 2.75*xval + 3.75*max(c(0,Qval-xval)) + 12.25*max(c(0,xval - Qval))
  }
}

df$CumProb <- 0
df$Prob <- 0


for (r in 1:nrow(df)){
  df$CumProb[r] <- pnorm(as.numeric(row.names(df)[r]),3500,275)
}
df$Prob[1] <- df$CumProb[1]
df$Prob[2:nrow(df)] <- diff(df$CumProb,1)

expected <- vector()
for (col in 1:(ncol(df)-2)){
  expected <- c(expected, sum(df$Prob*df[,col]))
}

names(df)[which.min(expected)]

# Q2   marginal analysis method
CR <- 12.25/(12.25+3.75)
qnorm(CR)*275+3500

# Q3
round(pnorm(3700,3500,275,lower.tail=F),3)

# Q4 
k <- (3700-3500)/275
round((dnorm(k)-k*(1-pnorm(k)))*275,0)

# Q5

CR <- 12.25/(12.25+0.75)
qnorm(CR)*735+3800

# Q6
pnorm(4950,3800,735,F)


# HW6-2
# Q1 
CR <- 1015/(1015+575)
qnorm(CR)*3+15

# Q2
pnorm(16,15,3,F)

# Q3
pnorm(16,15,3,F)*4*5*3

# Q4

# Q5
CR <- 3025/(3025+575)
qnorm(CR)*3+15

# Q6
pnorm(18,15,3,F)*4*5*3

# Q7
CR <- 3025/(3025+575-270)
qnorm(CR)*3+15

# Q8
pnorm(19,15,3,F)*4*5*3