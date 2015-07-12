Title
========================================================

Riding Patriot supplies tires to most of New England's taxi cabs: thousands of taxis across Massachusetts, New Hampshire, Maine, Vermont, Connecticut, and Rhode Island depend on it to have tires available for immediate purchase. A long-standing relationship with local taxi collectives has made Riding Patriot the go-to supplier of tires for cabs in the region.

In an effort to maintain logistics costs low, the CEO of Riding Patriot has hired you as a consultant for their logistics department, and assigned you the task of looking into the cost of inventory at their Distribution Center (DC) located in Franklin, Massachusetts. Through some interviews and data collection on site you learn that Riding Patriot has several stores across the New England region. All of them are served from this single DC. You have been asked to define a (s, Q) policy for the inventory in this DC.

The demand of tires from taxi cabs is normally distributed and relatively stable at around 3,500 units per month, with a standard deviation of 375 units per month. The Sales department tells you that Riding Patriot pays $217 per unit. Through talks with Finance and Logistics personnel, you estimate that the firm's holding charge is about 16% of the item's cost per year.

Tires have to be shipped in full containers from the West Coast. Every time Riding Patriot places an order, it has to be in multiples of 100 units, and incurs an ordering cost of $1,650 for each order it places. Since the tires are moved by rail and truck, the lead time from the vendor is relatively long at 3 weeks. Payment is due at the moment the order is placed, and ownership of the items is transferred to you as soon as the order is placed.  Riding Patriot's policy is to maintain a customer service level (CSL) of 95%.

# Question 1
For orders from Riding Patriot to its supplier, what order size would you recommend? Use the economic order quantity (EOQ) formula, but subject to the constraint of ordering multiples of 100.


```r
D = 3500*12
c = 217
h = 0.16
ct = 1600
L = 3
CSL = 0.95
ce = c*h
Q = ceiling(sqrt(2*ct*D/ce)/100)*100
Q
```

```
## [1] 2000
```

# Question 2
On an average, how frequently would Riding Patriot place these orders? Give your answer in terms of weeks, with one decimal.


```r
T <- 52/(D/Q)
T
```

```
## [1] 2.47619
```

# Question 3
What is your Reorder Point s? Give your answer rounded to the nearest multiple of 10.

```r
mu_DL <- 3500/4*3
sd_DL <- 375/2*sqrt(3)
k <- qnorm(0.95)
s <- ceiling((mu_DL + sd_DL*k)/10)*10
```

# Question 4
What is the expected annual cost of carrying cycle stock? Round to the nearest multiple of $100

```r
CoCS <- round((ce*Q/2)/100)*100
```

# Question 5
What is the expected annual cost of carrying the safety stock? Round to the nearest multiple of $100

```r
CoSS <- round((ce*k*sd_DL)/100)*100
```

# Question 6
The head of the Finance and Accounting department has reminded you that, since you pay for the items upfront and take ownership of them as soon as the order is placed, you should also consider the cost of the 'pipeline inventory.' Holding pipeline inventory is a little cheaper than holding inventory on hand. The reason for this is that the cost of carrying inventory on hand includes both the cost of money (which is 8% for Riding Patriot) and the cost of storing and managing the inventory in the DC (which accounts for the rest). Using a carrying charge of 8% for the pipeline inventory, what is the expected annual cost of carrying the pipeline inventory? Round to the nearest multiple of $100

```r
CoPS <- ceiling((c*8/100*L/48*D)/100)*100
```

# Question 7
In a meeting with the CEO, and the heads of Sales, Logistics and Finance, you present your findings on what Riding Patriot pays for carrying cycle, safety and pipeline inventory. They are all very attentive to what you are presenting.

"I have a question", says the head of Sales, "As you know, currently we have a policy of keeping a 95% customer service level. I have repeatedly asked for this level to be raised, to reduce lost sales."

"And I have repeatedly pointed out that this would increase our inventory holding cost", interrupts the head of Logistics.

"Let's ask the consultant", says the CEO, "Which of these inventory carrying costs would be affected by us increasing the customer service level?"


```r
kprime <- qnorm(0.999)
sprime <- ceiling((mu_DL + sd_DL*kprime)/10)*10
CoCSprime <- round((ce*Q/2)/100)*100
CoSSprime <- round((ce*kprime*sd_DL)/100)*100
CoPSprime <- ceiling((c*8/100*L/48*D)/100)*100

c(CoCS,CoCSprime)
```

```
## [1] 34700 34700
```

```r
c(CoSS,CoSSprime)
```

```
## [1] 18500 34800
```

```r
c(CoPS,CoPSprime)
```

```
## [1] 45600 45600
```

ANS:Safety stock

# Question 8
"Here is my point", continues the head of Sales, "Right now, we are leaving a lot of money on the table. Look, I estimate that every year we lose about a hundred thousand dollars in sales because we run out of stock. That's a lot of money! I have run some numbers, and I think that - if we increase the customer service level from 95% to 99.9%, we would reduce these lost sales tenfold, from $100,000 to only $10,000 per year."

"So, it all comes down to the increase in inventory carrying cost", says the CEO. "How much more would we have to pay in inventory holding cost if we were to implement a CSL of 99.9%?" Please provide the increase in inventory holding cost, rounded to the nearest multiple of $1000.

```r
round((CoSSprime-CoSS)/100)*100
```

```
## [1] 16300
```

# Question 9
"So, based on this," asks the CEO "would it make sense financially to change 

```r
(100000-10000)-round((CoSSprime-CoSS)/100)*100 > 0
```

```
## [1] TRUE
```

# Question 10
"I think a change of CSL from 95% to 99.9% would have a benefit in terms of our relationship with the taxi companies" says the CEO. "Let's try to put this benefit in simple terms."

Which of the following statements better describes the relative frequency of stockout events with the new CSL of 99.9% compared to the previous CSL of 95%?

```r
(5/100)/(0.1/100)
```

```
## [1] 50
```
