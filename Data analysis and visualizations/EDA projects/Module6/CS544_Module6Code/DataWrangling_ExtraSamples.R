### More examples of Data Wrangling

library(tidyverse)

tstate <- as_tibble(state.x77)
tstate$Region <- state.region
tstate$Name   <- state.name

tstate <- select(tstate, Name, Region, everything())

glimpse(tstate)

# Filter states with Income > the mean Income of all states OR HS Graduation Rate > 60%
# We will apply the OR condition using |

mean(tstate$Income)

tstate |> 
  filter(Income > mean(Income) | `HS Grad` > 60) %>% 
  select(Region,Frost,Area)

# Filter for states in the West Region and the above condition (Income > the mean Income of all states OR HS Graduation Rate > 60%)

tstate |> 
  filter(Region=="West")

tstate |> 
  filter(Region=="West", 
         (Income > mean(Income) | `HS Grad` > 60)  )

tstate |>
  filter(Income > mean(Income) | `HS Grad` > 60) %>% 
  filter(Region=="West")


# In the example below:
# 1) We sorted the data frame by State Name using arrange
# 2) We applied a group-by using Region, i.e., all resulting values would be aggregated using Region
# 3) We calcuated the values for total rows using n(), the unique states belonging to each region using n_distinct
#   the max & mean literacy using max and mean respectively
# 

tstate |>  
  arrange(Name) |> 
  group_by(Region) |> 
  summarise(total_rows = n(), 
            first_state = first(Name), 
            last_state = last(Name),
            unique_states = n_distinct(Name), 
            max_literacy = max(100-Illiteracy), 
            mean_literacy = mean(100-Illiteracy, 
                                 na.rm=T))


### Iris Example

iris |> 
  group_by(Species) |> 
  select(Sepal.Length, Sepal.Width)   |> 
  summarise( meanSL=mean(Sepal.Length),
             sdSL=sd(Sepal.Length),
             meanSW= mean(Sepal.Width),
             sdSW= sd(Sepal.Width)) |> 
  filter(meanSL==max(meanSL) | meanSW==max(meanSW))



### Join Operations

library(tidyverse)
library(nycflights13)

# Smaller dataset

flights2 <- flights |>
  select(year:day, hour, origin, dest, 
         tailnum, carrier)

flights2

# Mutating join - add airline name

airlines

flights2 |>
  select(-origin, -dest) |> 
  left_join(airlines, by = "carrier")

# Joins

x <- tribble(
  ~key, ~val_x,
  1, "x1",
  2, "x2",
  3, "x3"
)

y <- tribble(
  ~key, ~val_y,
  1, "y1",
  2, "y2",
  4, "y4"
)

x
y

# Inner join - keeps observations that appear in both tables

x |> 
  inner_join(y, by = "key")

# same as
inner_join(x, y)
inner_join(x, y, by = "key")

# Left join - keeps all observations in the left table

x
y

x |> 
  left_join(y, by = "key")


# Right join - keeps all observations in the right table

x
y

x |> 
  right_join(y, by = "key")

# Full join - keeps all observations in both the tables

x
y

x |> 
  full_join(y, by = "key")

## Multiple keys

weather

names(flights2)
names(weather)

intersect(names(flights2), names(weather))

# default - use all common columns as keys

flights2 |> 
  left_join(weather) |>  View()

planes

intersect(names(flights2), names(planes))

# year column has different meaning in both

flights2 |> 
  left_join(planes, by = "tailnum") |>  
  View()

# default suffix for non-joined duplicate variables

flights2 |> 
  left_join(planes, by = "tailnum", 
            suffix=c("_left","_right")) |>  
  View()

  
# When join column names are different

airports

names(airports)
names(flights2)

str_subset(airports$faa, "^B")

unique(str_subset(flights2$dest, "^B"))

flights2 |> 
  left_join(airports, c("dest" = "faa")) |> 
  View()

##

library(plotly)

flights3 <- flights2 |>
  group_by(dest) |>
  summarise(count = n())

flights3

flights4 <- flights3 |>
  inner_join(airports, c("dest" = "faa")) 

flights4

geo <- list(
  scope = 'usa',
  projection = list(type = 'albers usa'),
  showland = TRUE,
  landcolor = toRGB("gray95"),
  subunitcolor = toRGB("gray85"),
  countrycolor = toRGB("gray85"),
  countrywidth = 0.5,
  subunitwidth = 0.5
)

flights4 |>
  plot_geo(lat = ~lat, lon = ~lon) |>
  add_markers(text = ~paste(dest, name,  paste("Total:", count), sep = "<br />"),
              color = ~count, symbol = I("square"), size = I(8), hoverinfo = "text"
              ) |>
  colorbar(title = "nycflights13 data") |>
  layout(title = 'NYC Flights Dataset<br />(Hover for airport)', 
         geo = geo)


######


## Self Join Example

set.seed(123)
df <- data.frame(Name = paste0("P", 1:5), 
                 Age = sample(20:60, 5))
df

df |>
  cross_join(df,
             suffix=c("1","2"))

# Who is older than each person?
df |>
  cross_join(df,
             suffix=c("1","2")) |>
  filter(Age1 < Age2)



