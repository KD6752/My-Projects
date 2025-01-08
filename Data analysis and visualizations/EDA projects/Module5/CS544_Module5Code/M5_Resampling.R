## Resampling Methods
## 4.2. The replicate Function

set.seed(100)

x <- 1:5
sample(x, replace = TRUE)
sample(x, replace = TRUE)

replicate(10, sample(x, replace = TRUE))

y <- replicate(10, sample(x, replace = TRUE),
               simplify = FALSE)
y

sapply(y, mean, simplify = TRUE)


####

## 4.3. Bootstrap Distribution—Standard Error of the Mean

set.seed(120)

pop.mean <- 60
pop.sd <- 10

sample.size <- 30

x <- rnorm(sample.size, mean = pop.mean, sd = pop.sd)
x <- as.integer(x)
x

resamples.1 <- replicate(1000, 
                         sample(x, replace = TRUE),
                         simplify = FALSE)

head(resamples.1, n = 2)

xbar.star <- sapply(resamples.1, mean, simplify = TRUE)

length(xbar.star)

head(xbar.star, n = 6)

hist(xbar.star, breaks=40, prob = TRUE, 
     xlim=c(50,70), ylim=c(0, 0.3))

sd.sample.means <- pop.sd/sqrt(sample.size)
sd.sample.means

curve(dnorm(x, mean = pop.mean, sd = sd.sample.means), 
      from = 50, to = 70, add = TRUE)

mean(xbar.star)

mean(x)

mean(xbar.star) - mean(x)

sd(xbar.star)

sd.sample.means

#

library(boot)

set.seed(120)

samplemean <- function(x, indices) { 
  return (mean(x[indices]))
}
boot(data = x, statistic = samplemean, R = 1000)

#

## 4.4. Bootstrap Distribution—Standard Error of the Median

set.seed(120)

length(rivers)

hist(rivers, breaks = 20)

mean(rivers)

median(rivers)


resamples.2 <- replicate(1000, 
                         sample(rivers, replace = TRUE),
                         simplify = FALSE)

medians.star <- sapply(resamples.2, median, 
                       simplify = TRUE)

length(medians.star)

hist(medians.star, breaks=30, prob = TRUE)

median(rivers)

mean(medians.star)

mean(medians.star) - median(rivers)

sd(medians.star)

set.seed(120)

samplemedian <- function(x, indices) { 
  return (median(x[indices]))
}


boot(data = rivers, 
     statistic = samplemedian, R = 1000)


## 4.5. Bootstrap Confidence Intervals


quantile(medians.star, c(0.025, 0.975))

set.seed(120)

samplemedian <- function(x, indices) { 
  return (median(x[indices]))
}

boot.data <- boot(data = rivers, 
                  statistic = samplemedian, R = 1000)

boot.ci(boot.data, conf = 0.95, type="perc")

getda