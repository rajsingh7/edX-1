Title
========================================================

You have been hired by New Day Electronics Inc. (NDE), an original device manufacturer (ODM) of low-end smart phones, based in China. Each smart phone is powered by an application processor (AP), which serves as the 'brain' that makes the phone 'smart'. Although NDE assembles the phones, it does not make the APs. Instead, all the APs are procured from a microchip manufacturer based in Vietnam. The APs are produced in a facility that is in high demand, which means there is usually a long leadtime for the delivery of the products after the order is placed.

You are in charge of managing the inventory for the APs. You have decided to use an (s,Q) inventory policy. NDE's annual demand for APs item is normally distributed with a mean of 2,500 units. Based on the RMSE, you know that the standard deviation of the AP demand is 224 units per year. Each AP costs you $10. Placing an order is extremely cheap: you calculate it only costs you $5 to place each order.  The lead-time is constant and equal to 10 weeks. (For the purpose of this problem, assume there are 52 week in a year.)  The holding charge is 25% annually.


```r
c = 10
ct = 5
L = 10
h = 0.25
D = 2500
ce = c*h
```

# Question 1
What is the economic order quantity, Q*, for the APs? Round to the nearest integer.

```r
Q = sqrt(2*ct*D/ce)
Q
```

```
## [1] 100
```

# Question 2
In case of a stock out of APs, there is a penalty of $6 per unit short per year. What is the reorder point, s, for your current policy? Round to the nearest integer.

```r
mu_DL <- 2500*10/52
sd_DL <- 224*sqrt(10/52)
cs <- 6
(Q*ce)/(D*cs)< 1
```

```
## [1] TRUE
```

```r
k <- -1*qnorm((Q*ce)/(D*cs))
k
```

```
## [1] 2.128045
```

```r
mu_DL + sd_DL*k
```

```
## [1] 689.8082
```

# Question 3
Having completed the course in Supply Chain and Logistics Fundamentals, you know that the best values for k and Q will be when both are solved simultaneously. (We will show how to do this in a later lecture.) For now, let's assume that, by using this approach, you have come up with the following values: k = 1.98 and Q* = 144.

With this policy, what will be your new reorder point, s? Round to the nearest integer.

```r
Q = 144
k = 1.98
mu_DL + sd_DL*k
```

```
## [1] 675.2656
```


# Question 4
The manager of the smart phone product line suggests that you use a (R, S) periodic review inventory policy and proposes ordering every 4 weeks. Using the k value from part 2.2 for the manager’s order policy, what is the order up to level, S?

```r
k = 2.13
R = 4
mu_DLR <- D*(R+L)/52
sd_DLR <- 224*sqrt((R+L)/52)
mu_DLR + k*sd_DLR
```

```
## [1] 920.6423
```

# Question 5
Your regional director of procurement wants to consolidate things. He has negotiated with the vendor and is proposing that you set up a weekly periodic review system. However the vendor has now increased its lead time from 10 weeks to 13 weeks. Using the k value from part 2.2 what is the order up to level, S, as per the regional director’s new policy?

```r
R = 1
L = 13
mu_DLR <- D*(R+L)/52
sd_DLR <- 224*sqrt((R+L)/52)
mu_DLR + k*sd_DLR
```

```
## [1] 920.6423
```

# Question 6
You want to compare the costs of the two (s, Q) continuous review policies from part 2.2. Enter the total relevant cost (TRC) (e.g. ordering plus holding plus shortage costs) for this policy, rounded to the closest dollar. Note: the solution to this problem will not be posted until after the deadline.

TRC of (s,Q) from 2.2

```r
c = 10
ct = 5
L = 10
h = 0.25
D = 2500
ce = c*h
Q = sqrt(2*ct*D/ce)
mu_DL <- 2500*10/52
sd_DL <- 224*sqrt(10/52)
cs <- 6
k <- -1*qnorm((Q*ce)/(D*cs))
Gk <- dnorm(k)-k*(1-pnorm(k))
round(ct*(D/Q)+ce*(Q/2+k*sd_DL)+cs*sd_DL*Gk*(D/Q),0)
```

```
## [1] 861
```

# Question 7
You want to compare the costs of the two (s, Q) continuous review policy from part 2.3. Enter the total relevant cost (TRC) (e.g. ordering plus holding plus shortage costs) for this policy, rounded to the closest dollar. Note: the solution to this problem will not be posted until after the deadline.

TRC of (s,Q) from 2.3

```r
c = 10
ct = 5
L = 10
h = 0.25
D = 2500
ce = c*h
Q = 144
mu_DL <- 2500*10/52
sd_DL <- 224*sqrt(10/52)
cs <- 6
k <- -1*qnorm((Q*ce)/(D*cs))
Gk <- dnorm(k)-k*(1-pnorm(k))
round(ct*(D/Q)+ce*(Q/2+k*sd_DL)+cs*sd_DL*Gk*(D/Q),0)
```

```
## [1] 845
```

# Question 8
You want to compare the costs of the two (R, S) periodic review policies from parts 2.4 and 2.5. Enter the total relevant cost (ordering plus holding plus shortage) for each policy, rounded to the closest dollar. Note: the solution to this problem will not be posted until after the deadline.

```r
ct = 5
ce = 2.5
cs <- 6
D = 2500
Q = 192
k <- 2.128045
mu_DLR <- 2500*14/52
sd_DLR <- 224*sqrt(14/52)
Gk <- dnorm(k)-k*(1-pnorm(k))
round(ct*(D/Q)+ce*(Q/2+k*sd_DLR)+cs*sd_DLR*Gk*(D/Q),0)
```

```
## [1] 978
```


# Question 9
You want to compare the costs of the two (R, S) periodic review policies from parts 2.4 and 2.5. Enter the total relevant cost (ordering plus holding plus shortage) for each policy, rounded to the closest dollar. Note: the solution to this problem will not be posted until after the deadline.


```r
ct = 5
ce = 2.5
cs <- 6
D = 2500
Q = 48
k <- 2.128045
mu_DLR <- 2500*14/52
sd_DLR <- 224*sqrt(14/52)
Gk <- dnorm(k)-k*(1-pnorm(k))
round(ct*(D/Q)+ce*(Q/2+k*sd_DLR)+cs*sd_DLR*Gk*(D/Q),0)
```

```
## [1] 1156
```
