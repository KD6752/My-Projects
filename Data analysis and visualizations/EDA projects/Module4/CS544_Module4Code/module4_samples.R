#### 2. Discrete Distributions

#### 2.2. Random Variable Example—Number of Heads

x <- c(0, 1, 2, 3)
# same as x <- 0:3

f <- c(1/8, 3/8, 3/8, 1/8)

mu <- sum(x * f)
mu

sigmaSquare <- sum((x - mu)^2 * f)
sigmaSquare

sigma <- sqrt(sigmaSquare)
sigma

F <- cumsum(f)
F

for (i in 1:length(x)) {
  cat(sprintf("P[#Heads <= %d] = %.2f\n", x[i], F[i] ))
}
  


#### 2.3. Random Variable Example—Age of Students

ages <- c(21,25,27,23,21,21,25,25,21,27)
mean(ages)

ctable <- table(ages)
ctable

dframe <- as.data.frame(ctable)
dframe

x <- as.numeric(as.character(dframe$ages))
x

f <- dframe$Freq / (sum(dframe$Freq))
f

mu <- sum(x * f)
mu

F <- cumsum(f)
F

for (i in 1:length(x)) {
  cat(sprintf("P[Age <= %d] = %.2f\n", x[i], F[i] ))
}





#### 2.7. Bernoulli Trials

p <- 1/4
sample(0:1, size = 10, replace = TRUE, 
  prob = c(1 - p, p))

p <- 3/4
sample(0:1, size = 10, replace = TRUE, 
  prob = c(1 - p, p))

#### 2.10. Example Using R—Tossing 5 Coins

# Fair coin (Head as Success)
# X is the number of successes

n <- 5; p <- 1/2

# P(X = 3)   3 Heads
choose(n,3) * p^3 * (1 - p)^2

dbinom(3, size = n, prob = p)

# Distribution of all probabilities

dbinom(0:n, size = n, prob = p)

# P(X = 1), P(X = 5)

dbinom(c(1,5), size = n, prob = p)

# P(X <= 3)   at most 3 successes

sum(dbinom(0:3, size = n, prob = p))

# or

pbinom(3, size = n, prob = p)

# P(X > 3)  at least 4 successes

sum(dbinom(4:n, size = n, prob = p))

# Same as  1 - P(X <= 3)

1 - pbinom(3, size = n, prob = p)

# or

pbinom(3, size = n, prob = p, lower.tail = FALSE)

# Plot PMF

n = 5; p = 0.5;

pmf <- dbinom(0:n, size = n, prob = p)

plot(0:n, pmf, type = "h", xaxt = "n",
     main = "", xlab = "x", ylab = "PMF")
points(0:n, pmf, pch = 16)   
axis(side = 1, at = 0:n, labels = TRUE)
abline(h = 0, col="red")

# Expected value   n*p

sum(0:n * pmf)


# Plot CDF

cdf <- cumsum(pmf)
cdf

# or

cdf <- pbinom(0:n, size = n, prob = p)
cdf

# Insert a 0 at the beginning for step function

cdf <- c(0, cdf)
cdf

cdfplot <- stepfun(0:n, cdf)
base::plot(cdfplot, verticals = FALSE, pch = 16,
  main = "", xlab = "x", ylab = "CDF")
  

# Repeat plot with n = 100; p = 0.5
# Repeat plot with n = 100; p = 0.7
# Repeat plot with n = 100; p = 0.3



# Quantile values

pbinom(0:5, size=5, prob=1/2)

qbinom(0.8125, size=5, prob=1/2)
qbinom(0.25, size=5, prob=1/2)
qbinom(0.5, size=5, prob=1/2)

cdf <- pbinom(0:5, size=5, prob=1/2)
cdf

qbinom(cdf, size=5, prob=1/2)


# Random numbers from the distribution

rbinom(20, size=5, prob=1/2)

y <- rbinom(1000, size=5, prob=1/2)
table(y)

plot(table(y), type="h", col="red")





#### 2.12. Hypergeometric Distribution

## Without replacement

# PMF & CDF Example

M <- 5    # Of interest
N <- 3    # Not of interest
K <- 2    # Sample Size


# P(X = 1)   one item of interest out of 2

choose(M,1) * choose(N,1) / choose(M+N, 2)

dhyper(1, m = M, n = N, k = K)

# Distribution of all probabilities

pmf <- dhyper(0:K, m = M, n = N, k = K)
pmf

cdf <- phyper(0:K, m = M, n = N, k = K)
cdf
# same as  cdf <- cumsum(pmf)

#Quantile
qhyper(0.64, m = M, n = N, k = K)

# random numbers from the distribution

rhyper(20, m = M, n = N, k = K )




#### 2.13. Example Using R—Faulty Chips

M <- 20; N <- 980; K <- 50

# P(X = 2)  exactly 2 faulty chips

dhyper(2, m = M, n = N, k = K)

# P(X <= 2)   at most 2 faulty chips

sum(dhyper(0:2, m = M, n = N, k = K))
phyper(2, m = M, n = N, k = K)

# P(X > 2)   at least 3 faulty chips

1 - phyper(2, m = M, n = N, k = K)
# or
phyper(2, m = M, n = N, k = K, lower.tail = FALSE)


# Plot PMF
pmf <- dhyper(0:K, m = M, n = N, k = K)

plot(0:K,pmf,type="h",
  xlab="x",ylab="PMF",ylim=c(0,0.5))
abline(h=0)

# Expected value   K*M/(M+N)

sum(0:K * pmf)


# Plot CDF
cdf <- c(0, cumsum(pmf))
cdfplot <- stepfun(0:K, cdf)
plot(cdfplot, verticals = FALSE, pch = 16,
  main = "", xlab = "x", ylab = "CDF")

#
x <- rhyper(1000, m = M, n = N, k = K )
plot(table(x))





#### 2.14. Geometric Distribution

p <- 0.5

# P(X = 2)  first 2 are failures and then the success

(1-p)*(1-p)*p

dgeom(2, prob = p)

# P(X <= 2)   at most 2 failures

sum(dgeom(0:2, prob = p))
pgeom(2, prob = p)


# P(X > 2)   at least 3 failures

1 - pgeom(2, prob = p)
# or
pgeom(2, prob = p, lower.tail = FALSE)


# Distribution of all probabilities

pmf <- dgeom(0:10, prob = p)
pmf

#Plot PMF
plot(0:10,pmf,type="h",
  xlab="x",ylab="PMF")
abline(h=0, col="red")


# Expected value   (1-p)/p

sum(0:10 * pmf)



# Plot CDF
cdf <- c(0, cumsum(pmf))
cdfplot <- stepfun(0:10, cdf)
plot(cdfplot, verticals = FALSE, pch = 16,
     main = "", xlab = "x", ylab = "CDF")




#Quantile

pgeom(0:5, prob = p)

qgeom(0.75, prob = p)
qgeom(0.8, prob = p)


# random numbers from the distribution

rgeom(20, prob = p)

x <- rgeom(1000, prob = p)
plot(table(x))





#### 2.15. Negative Binomial Distribution

r <- 3  # Number of successes (fixed)
p <- 0.5

# P(X = 5)   five failures before getting 3 successes
# 2 successes in the first 7 attempts, 8th is success

choose(7, 2) * (p**r) * ((1-p)**5) 

dnbinom(5, size = r, prob = p)

# Distribution of probabilities

pmf <- dnbinom(0:20, size = r, prob = p)
pmf

#Plot PMF
plot(0:20,pmf,type="h",
  xlab="x",ylab="PMF", ylim = c(0, 0.2))
abline(h=0, col="red")

# Expected value   r * (1-p)/p

sum(0:20 * pmf)



# P(X <= 5)   at most 5 failures

sum(dnbinom(0:5, size = r, prob = p))

pnbinom(5, size = r, prob = p)

# P(X > 5)   at least 6 failures

1 - pnbinom(5, size = r, prob = p)

#or

pnbinom(5, size = r, prob = p, lower.tail = FALSE)


cdf <- c(0, cumsum(pmf))
cdf

cdfplot <- stepfun(0:10, cdf)
plot(cdfplot, verticals = FALSE, pch = 16,
  main = "", xlab = "x", ylab = "CDF")


# random numbers from the distribution

rnbinom(20, size = r, prob = p)

x <- rnbinom(1000, size = r, prob = p)
plot(table(x))




#### 2.16. Poisson Distribution

# Average of 8 patients in a given interval

# P(X = 6)

dpois(6, lambda=8)

# P(X <= 2)

sum(dpois(0:2, lambda=8))
#or
ppois(2, lambda=8)

# Between 5 and 10 inclusive

sum(dpois(5:10, lambda=8))

#  P(X <= 10) - P(X <= 4)

ppois(10, lambda=8) - ppois(4, lambda=8)
#or
diff(ppois(c(4,10), lambda=8))

# 
pmf <- dpois(0:40, lambda=8)
pmf

#Plot PMF
plot(0:40,pmf,type="h",
  xlab="x",ylab="PMF", ylim = c(0, 0.25))
abline(h=0, col="red")

# Expected value
sum(0:40 * pmf)


# Plot CDF

cdf <- c(0, cumsum(pmf))
cdf


cdfplot <- stepfun(0:10, cdf)
plot(cdfplot, verticals = FALSE, pch = 16,
     main = "", xlab = "x", ylab = "CDF")

# random numbers from this distribution

rpois(20, lambda = 8)

x <- rpois(1000, lambda = 8)
plot(table(x))



#### 2.4. Discrete Uniform Distribution

# Single Die

x <- 1:6
f <- rep(1/6, 6)

# Expected value

mu <- sum(x * f)
mu

sigmaSquare <- sum((x - mu)^2 * f)
sigmaSquare

# PMF and CDF example
m <- 6
dunif(1, max = m)

pmf <- dunif(1:m, max = m)
pmf

cdf <- punif(1:m, max = m)
cdf

#Plot PMF
plot(1:m, pmf, type="h",
     xlab="x",ylab="PMF", ylim = c(0, 0.2))
abline(h=0, col="red")

# Quantile
qunif(0.5, max=6)

# Generate Uniform Data

sample(6, size = 20, replace = TRUE)

sample(10:20, size = 5, replace = TRUE)

sample(c("H", "T"), size = 10, replace = TRUE)

# runif

runif(20, max = m)

runif(20, min = 1, max = m+1)

floor(runif(20, min = 1, max = m+1))

x <- floor(runif(6000, min = 1, max = m+1))
table(x)
plot(table(x))

# or

x <- sample(6, size = 6000, replace = TRUE)
table(x)
plot(table(x))


##############################

#### 3. Continuous Distributions

#### 3.1. Figure plot

par(mfrow=c(1,3))

x <- seq(-10,10,0.01)
pdf = dnorm(x,0,2)
plot(x, pdf, type="h", main="Normal Distribution",
  col="lightblue", xaxt="n", yaxt="n")

x <- seq(0,10,0.01)
pdf = dunif(x,0,10)
plot(x, pdf, type="h", main="Uniform Distribution",
 col="lightblue", xaxt="n", yaxt="n")

x <- seq(0,12,0.001)
pdf = dexp(x,0.4)
# Plot PDF
plot(x,pdf,type="h", main="Exponential Distribution",
  col="lightblue", xaxt="n", yaxt="n")
abline(h=0)

par(mfrow=c(1,1))

#### 3.3. Example 1 — Uniform Distribution

# Plot

x <- seq(0, 1, 0.001)
pdf <- dunif(x,0,1)

plot(x, pdf, type="h", main="Uniform Distribution",
 col="lightblue", xaxt="n", yaxt="n", ylim=c(0,1.5))

axis(side = 1, at = seq(0,1,by=0.1), labels = TRUE)
axis(side = 2, at = c(0,1), labels = TRUE)

##

# P(X <= 0.4)
punif(0.4, min=0, max=1)

# P(0.2 < X < 0.4)

punif(0.4, min=0, max=1) - punif(0.2, min=0, max=1)

#### 3.4. Example 2 — Uniform Distribution

1 - punif(5, min=2.5, max=6.5)
punif(5, min=2.5, max=6.5, lower.tail=FALSE)

#### 3.5. Normal Distribution

# Plots
x <- seq(-6,6,0.1)
pdf.1 = dnorm(x, mean = 0, sd = 0.5)
pdf.2 = dnorm(x, mean = 0, sd = 1)
pdf.3 = dnorm(x, mean = 0, sd = 2)

plot(x, pdf.1, type="l", col="green", xlim=c(-6,6))
lines(x, pdf.2, col="red")
lines(x, pdf.3, col="blue")


x1 <- seq(-7,1,0.1)
pdf.1 = dnorm(x1, mean = -3, sd = 1)

x2 <- seq(-4,4,0.1)
pdf.2 = dnorm(x2, mean = 0, sd = 1)

x3 <- seq(2,10,0.1)
pdf.3 = dnorm(x3, mean = 6, sd = 1)

plot(x1, pdf.1, type="l", col="green", xaxt="n", xlim=c(-8,12))
lines(x2, pdf.2, col="red")
lines(x3, pdf.3, col="blue")
axis(side = 1, at = seq(-8,12,by=2), labels = TRUE)

#### 3.6. Example—Normal Distribution
# Gestation example

x <- seq(212,320)
pdf <- dnorm(x, mean = 266, sd = 16)

plot(x, pdf, type="l", col="red", 
  xlim=c(212,320), ylim=c(0,0.03),
  xaxt="n", yaxt="n",
  main="Gestation Period", xlab="Days", ylab="PDF")
axis(side = 1, at = c(218,234,250,266,282,298,314), 
  labels = TRUE) 
axis(side = 2, at = c(0,0.01,0.02,0.03), 
  labels = TRUE) 

mu <- 266; sigma <- 16

pnorm(mu, mean = mu, sd = sigma)

pnorm(mu - 3*sigma, mean = mu, sd = sigma)

pnorm(mu + 3*sigma, mean = mu, sd = sigma) -
 pnorm(mu - 3*sigma, mean = mu, sd = sigma)
 
pnorm(mu + 2*sigma, mean = mu, sd = sigma) -
 pnorm(mu - 2*sigma, mean = mu, sd = sigma)

pnorm(mu + sigma, mean = mu, sd = sigma) -
 pnorm(mu - sigma, mean = mu, sd = sigma)
 

#CDF

x <- seq(212,320)
cdf <- pnorm(x, mean = 266, sd = 16)
plot(x, cdf, type="l", col="red", 
  xlim=c(212,320), ylim=c(0,1),
  xaxt="n",
  main="Gestation Period CDF", xlab="Days", ylab="CDF")
abline(h=0)
axis(side = 1, at = c(218,234,250,266,282,298,314), 
  labels = TRUE) 
  
  
#### 3.7. Standard Normal Distribution

x <- seq(-4,4,0.1)
pdf <- dnorm(x, mean = 0, sd = 1)

plot(x, pdf, type="l", col="red", xlim=c(-3,3))

cdf <- pnorm(x, mean = 0, sd = 1)
plot(x, cdf, type="l", col="red", xlim=c(-3,3))

100*(pnorm(c(1,2,3)) - pnorm(c(-1,-2,-3)))

#### 3.8. Normal Quantiles

qnorm(0.5, mean=0, sd=1)

qnorm(0.95, mean=80, sd=5)

qnorm(0.99, mean=80, sd=5)

### 3.9. Generating Random Numbers with Normal Distribution

y <- rnorm(20, mean = 80, sd = 5)

y <- rnorm(1000, mean = 80, sd = 5)
y <- round(y)
table(y)
plot(table(y), type="h")


###########################

#### 3.11. Example—Exponential Distribution

pexp(1/60, rate=20)


x <- seq(0,1, by=1/60)
pdf <- dexp(x, rate=20)

plot(x, pdf, type="l", col="red", 
   xlim=c(0,0.4))
abline(h=0)

cdf <- pexp(x, rate=20)
plot(x, cdf, type="l", col="red", 
   xlim=c(0,0.4))


#########################

##

#### 4.1. Random Variables

S <- rolldie(2, makespace = TRUE)
head(S, n = 2)
tail(S, n = 2)

# Method1 - with direct use of columns

S1 <- addrv(S, U = X1 + X2)

S1

Prob(S1, U == 7)
Prob(S1, U <= 6)
Prob(S1, U > 6)

# marginal distribution of the random variable

M1 <- marginal(S1, vars = "U")
M1

Prob(M1, U == 7)
Prob(M1, U <= 6)
Prob(M1, U > 6)

plot(probs ~ U, M1, type='h', col = 'red', lwd=10)


# with built-in function

S1 <- addrv(S, FUN = sum, name = "U")
S1

Prob(S1, U == 7)
Prob(S1, U <= 6)
Prob(S1, U > 6)

# marginal distribution of the random variable

M1 <- marginal(S1, vars = "U")
M1

Prob(M1, U == 7)
Prob(M1, U <= 6)
Prob(M1, U > 6)


#### 4.2. Multiple Random Variables

S1 <- addrv(S, FUN = max,
            invars = c("X1", "X2"), name = "V")
S2 <- addrv(S1, FUN = min,
            invars = c("X1", "X2"), name = "W")

head(S2, n = 3)
tail(S2, n = 3)

# marginal distribution of the random variable

M2 <- marginal(S2, vars = "V")
M2

plot(probs ~ V, M2, type='h', col = 'red', lwd=10)

M3 <- marginal(S2, vars = "W")
M3

plot(probs ~ W, M3, type='h', col = 'red', lwd=10)

# Joint marginal distribution

M4 <- marginal(S2, vars = c("V", "W"))
M4


#### 4.3. Random Variables with User-defined functions

S <- rolldie(2, makespace = TRUE)
head(S, n = 2)


mySum <- function (row) {
  return (row[1] + row[2])
}

S1 <- addrv(S, FUN = sum, name = "U")
S1

Prob(S1, U == 7)
Prob(S1, U <= 6)
Prob(S1, U > 6)

# marginal distribution of the random variable

M1 <- marginal(S1, vars = "U")
M1

Prob(M1, U == 7)
Prob(M1, U <= 6)
Prob(M1, U > 6)


# Coin toss example - number of heads

S <- tosscoin(3, makespace = TRUE)
head(S, n = 2)


countHeads <- function(row) {
  return (sum(row == "H"))
}

S1 <- addrv(S, FUN = countHeads, name = "U")
S1

Prob(S1, U == 2)
Prob(S1, U >= 2)


M1 <- marginal(S1, vars = "U")
M1

Prob(M1, U == 2)
Prob(M1, U >= 2)


## Coin toss example - first and last toss being heads

S <- tosscoin(3, makespace = TRUE)
head(S, n = 2)

S1 <- addrv(S, U = (toss1 == 'H' & toss2 == 'H'))
S1

Prob(S1, U == TRUE)

M1 <- marginal(S1, vars = "U")
M1

Prob(M1, U == TRUE)

# With user-defined function

firstAndLastHeads <- function (row) {
  return (row[1] == 'H' & row[3] == 'H')
}

S1 <- addrv(S, FUN = firstAndLastHeads, name = "U")
S1

Prob(S1, U == TRUE)

M1 <- marginal(S1, vars = "U")
M1

Prob(M1, U == TRUE)



