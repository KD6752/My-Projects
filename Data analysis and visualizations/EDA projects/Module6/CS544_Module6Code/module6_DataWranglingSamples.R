# tidyverse

install.packages("tidyverse")

library(tidyverse)

# nycflights13 datasets

install.packages("nycflights13")

library(nycflights13)

# tibble

a <- 1:100

tibble(a, b = 2 * a)

tibble(a, b = 2 * a, c = b^2)

# error with data.frame

data.frame(a, b = 2 * a, c = b^2)

# converting to tibble
as_tibble(iris)

# flights dataset

nycflights13::flights

# tribble

athlete.info <- tribble(
  ~Name,       ~Salary, ~Endorsements, ~Sport,
  "Mayweather",  105,      0,             "Boxing",
  "Ronaldo",      52,     28,             "Soccer",
  "James",      19.3,     53,             "Basketball",
  "Messi",      41.7,     23,             "Soccer",
  "Bryant",     30.5,     31,             "Basketball"
)

athlete.info

# glimpse
glimpse(athlete.info)

glimpse(nycflights13::flights)

# Pipe

summary(athlete.info)

athlete.info |> summary()

# is_tibble

is_tibble(athlete.info)

## dplyr - filter

filter(flights, month == 4)

# with pipe

flights |> filter(month == 4)

flights |> filter(month == 4, day == 10)
# equivalent to flights[flights$month == 4 & flights$day == 10, ]

flights |> filter(month == 6 | month == 7)

flights |> filter(month == 6 | month == 7) |> tail()

flights |> filter(month %in% c(3, 5, 7))

## dplyr - arrange

athlete.info

athlete.info |> arrange(Salary)

athlete.info |> arrange(Sport, Name)

athlete.info |> arrange(desc(Salary))

flights |> arrange(year, month, day)

flights |> arrange(year, month, day) |> View()

# Arranging column in descending order

flights |> arrange(desc(arr_delay)) |> head(10)

## dplyr - select

# Select columns by name
flights |> select(carrier, flight, tailnum, origin, dest)

# Select all columns between carrier and dest (inclusive)
flights |> select(carrier:dest)

# Select all columns except those from carrier to dest (inclusive)
flights |> select(-(carrier:dest)) 

# Rename variables with select

flights |> select(departure_time = dep_time)

flights |> rename(departure_time = dep_time)

#
flights |> select(starts_with("d"))
flights |> select(ends_with("time"))
flights |> select(contains("in"))

flights |> select(flight, origin, dest, everything())

flights |> 
  select(flight, origin, dest, arr_delay, everything()) |>
  arrange(desc(arr_delay)) |> head(10)

## mutate


flights |>
  mutate(gain = arr_delay - dep_delay,
         speed = (distance / air_time) * 60)  |>
  select(flight, arr_delay, dep_delay, gain, 
         distance, air_time, speed, everything())

# can refer to new columns

flights |>
  mutate(air_time_in_hours = air_time/60,
         speed = distance / air_time_in_hours)  |>
  select(flight, distance, air_time, air_time_in_hours, 
         speed, everything())

## transmute

# To keep only the new variables
flights |>
  transmute(gain = arr_delay - dep_delay,
            speed = (distance / air_time) * 60)

## distinct

flights |> distinct(origin)

flights |> distinct(tailnum) |> head(10)

flights |> distinct(carrier)

flights |> distinct(carrier) |>
  arrange(carrier)

flights |> distinct(origin, dest) 

flights |> distinct(origin, dest) |>
  arrange(origin, dest) |>
  View()

## summarize

flights |>
  summarise(delay = mean(arr_delay))

flights |>
  summarise(delay = mean(arr_delay, 
                         na.rm = TRUE))

flights |>
  filter(arr_delay > 0) |>
  summarise(count = n(),
            avg_delay = mean(arr_delay))

flights |>
  filter(arr_delay < 0) |>
  summarise(count = n(),
            avg_early = mean(arr_delay))

flights |>
  filter(arr_delay == 0) |>
  summarise(count = n(),
            avg_early = mean(arr_delay))

# group

flights |>
  filter(arr_delay > 0) |>
  group_by(year, month) |>
  summarise(count = n(),
            avg_delay = mean(arr_delay))

flights |>
  filter(arr_delay > 0) |>
  group_by(year, month) |>
  summarise(count = n(),
            avg_delay = mean(arr_delay)) |>
  arrange(desc(avg_delay))


flights |>
  filter(arr_delay > 0) |>
  group_by(origin) |>
  summarise(count = n(),
            avg_delay = mean(arr_delay))

flights |>
  filter(arr_delay > 0) |>
  group_by(origin, dest) |>
  summarise(count = n(),
            avg_delay = mean(arr_delay))

flights |>
  filter(arr_delay > 0) |>
  group_by(origin, dest) |>
  summarise(count = n(),
            avg_delay = mean(arr_delay)) |>
  arrange(desc(avg_delay))

flights |>
  filter(arr_delay > 0) |>
  arrange(desc(arr_delay)) |>
  group_by(origin, dest) |>
  summarise(worst = first(arr_delay),
            best = last(arr_delay))

flights |>
  filter(arr_delay > 0) |>
  group_by(origin, dest, year, month) |>
  summarise(avg_delay = mean(arr_delay)) |>
  arrange(desc(avg_delay)) |>
  summarise(worst = first(avg_delay),
            best = last(avg_delay))

flights |>
  filter(arr_delay > 0) |>
  group_by(origin, dest, year, month) |>
  summarise(avg_delay = mean(arr_delay)) |>
  arrange(desc(avg_delay)) |>
  summarise(worst = first(avg_delay),
            worst_month = first(month),
            best = last(avg_delay),
            best_month = first(month))


## tidyr

# sample data in wide format

set.seed(123)

sales <- 
  tibble(Store=rep(1:3, each=4),
         Year=rep(2014:2017, 3),
         Qtr_1 = round(runif(12, 10, 30)),
         Qtr_2 = round(runif(12, 10, 30)),
         Qtr_3 = round(runif(12, 10, 30)),
         Qtr_4 = round(runif(12, 10, 30))
  )
sales

# gather

sales |>
  gather(Quarter, Revenue, Qtr_1 : Qtr_4) |>
  head(12)

sales |>
  gather(Quarter, Revenue, Qtr_1 : Qtr_4) |>
  tail(12)

# Equaivalent forms

sales |>
  gather(key = Quarter, 
         value = Revenue, 
         Qtr_1 : Qtr_4)

sales |> 
  gather(Quarter, Revenue, -Store, -Year)

sales |> gather(Quarter, Revenue, 3:6)

sales |> gather(Quarter, Revenue, 
                 Qtr_1, Qtr_2, 
                Qtr_3, Qtr_4) -> long_data

# separate

long_data |>
  separate(Quarter, c("Time_Interval", "Interval_ID"),
           convert = TRUE) -> separate_data

separate_data

glimpse(separate_data)

# Equivalent form

long_data |> 
  separate(Quarter, 
           into = c("Time_Interval", "Interval_ID"), 
            sep = "_", convert = TRUE) -> separate_data

# unite

separate_data |>
  unite(Quarter, Time_Interval, Interval_ID)

# default separator is _

separate_data |>
  unite(Quarter, Time_Interval, Interval_ID, sep = ".")

separate_data |>
  unite(Quarter, Time_Interval, Interval_ID) -> unite_data

unite_data

# Other Examples

pew <- read.csv("http://kalathur.com/cs544/data/pew.csv", 
                stringsAsFactors = FALSE, check.names = FALSE)
pew

pew |>
  gather(income, frequency, -religion)

#