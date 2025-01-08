### New Pipe Operator in R

x <- 100

sqrt(x)
x |> sqrt()

log(x, base = 10)
x |> log(base = 10)

log10(sqrt(x))
x |> sqrt() |> log10()

##

summary(subset(mtcars, mpg > 20, select = c("mpg", "wt")))

# With pipe notation
mtcars |> subset(mpg > 20, , select = c("mpg", "wt")) |> summary()

