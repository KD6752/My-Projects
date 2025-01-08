# How quantiles are calculated

x <- 0:100

fivenum(x)

summary(x)

x <- 1:10
x

fivenum(x)

summary(x)

quantile(x)

quantile(x, probs=0.25)

quantile(x, probs=c(0.25, 0.75))

IQR(x)


####

n <- length(x)

q <- 0.25
1 + (n-1)*q

q <- 0.75
1 + (n-1)*q

x <- seq(5,50, by = 5)
x

summary(x)

(n <- length(x))

(q <- 0.25)
(index <- 1 + (n-1)*q)
(lower <- floor(index))
(upper <- ceiling(index))

ifelse(lower == upper, 
       x[lower], 
       x[lower] + (x[upper] - x[lower]) * (index - lower)
       )

my.quantile <- function(x, q = seq(0,1,by=0.25)) {
  n <- length(x)
  index <- 1 + (n-1)*q
  lower <- floor(index)
  upper <- ceiling(index)
  result <- 
    ifelse(lower == upper, 
         x[lower], 
         x[lower] + (x[upper] - x[lower]) * (index - lower)
    )
  names(result) <- paste0(q*100, "%")
  result
}

my.quantile(x)

my.quantile(x, 0.25)
