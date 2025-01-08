# Strings and Regular Expressions

if (!is.element("stringr", installed.packages()[,"Package"]))
  install.packages("stringr", repos="http://cran.us.r-project.org", 
                   dependencies = TRUE)

library(stringr)

# https://cran.r-project.org/web/packages/stringr/vignettes/stringr.html

# Join - str_c
str_c(c(1,2))
str_c(c("a", "b"), c(1,2), c("c", "d"))
str_c(c("a", "b"), c(1,2), c("c", "d"), sep = "-")

str_c("Letter: ", letters)
str_c("Letter", letters, sep = ": ")
str_c(LETTERS, " is for", "...")
str_c(LETTERS, c(" is for", " for"), "...")
str_c(letters[-26], " is before ", letters[-1])

str_c(c(1,2), collapse = "")
str_c(c("a", "b"), c(1,2), c("c", "d"), collapse=":")
str_c(c("a", "b"), c(1,2), c("c", "d"), sep = "-", collapse=":")

str_c(letters, collapse = "")
str_c(letters, collapse = ":")

str_flatten(letters)
str_flatten(letters, collapse = ":")


# Missing inputs give missing outputs
str_c(c("a", NA, "b"), "-d")

# str_length

str_length(c("a", "b", "c"))
str_length(c("a1", "b23", "c456"))
str_length(c("a1", NA, "c456"))

str_length(letters)

# substrings

s <- "United States"

str_length(s)

str_sub(s, 1, 6)
str_sub(s, end = 6)
str_sub(s, start = 2, end = 5)

str_sub(s, 8, 13)
str_sub(s, 8)

str_sub(s, c(1, 8), c(6, 13))

str_sub(s, start = c(1, 8), end = c(6, 13))

str_sub(s, c(1, 8))

str_sub(s, end = c(6, 13))

# Negative indices

str_sub(s, -1)
str_sub(s, -6)
str_sub(s, -10, -8)
str_sub(s, end = -6)


# Replacement form

x <- "CLAP"
str_sub(x, 1, 1) <- "F"; x
str_sub(x, -1, -1) <- "T"; x
str_sub(x, 2, -2) <- "OO"; x
str_sub(x, 2, -2) <- ""; x

# String duplication

x <- c("a1", "b2", "c3")
str_dup(x, 2)
str_dup(x, 1:3)
str_c("a", str_dup("ha", 0:4))


# Trimming
x <- "    How     are \n you?\t"
x
str_trim(x)
str_trim(x, side="left")
str_trim(x, side="right")

x <- "    How     are \n you?\t"
str_squish(x)

x <- "\t   How\t\t  \t\tare\tyou?"
str_squish(x)


str_trim("  String with trailing and leading white space\t")
str_trim("\n\nString with trailing and leading white space\n\n", side = "right")

# Padding

str_pad("cs544", 10)
str_pad("cs544", 10, pad = "_")

rbind(
  str_pad("cs544", 10, "left"),
  str_pad("cs544", 10, "right"),
  str_pad("cs544", 10, "both")
)

str_pad(c("a", "abc", "abcdef"), 5)

str_pad("a", c(2, 4, 6))

str_pad("cs544", 10, pad = c("_", "#"))
str_pad(c("cs544", "cs555"), 10, pad = c("_", "#"))

# Longer strings are returned unchanged
str_pad("cs544", 3)

# String truncation

x <- "Foundations of Data Analytics with R";x
str_length(x)

rbind(
  str_trunc(x, 25, "left"),
  str_trunc(x, 25, "right"),
  str_trunc(x, 25, "center")
)

# str_detect

head(fruit)
tail(fruit)
length(fruit)

fruit[str_detect(fruit, "ap")]
fruit[str_detect(fruit, "^ap")]
fruit[str_detect(fruit, "it$")]
fruit[str_detect(fruit, "[dvw]")]
fruit[str_detect(fruit, "[:space:]")]

# or str_subset

str_subset(fruit, "ap")
str_subset(fruit, "^ap")
str_subset(fruit, "it$")
str_subset(fruit, "[dvw]")
str_subset(fruit, "[:space:]")

# fruits which start with b and end with y
str_subset(fruit, "^b(.)*y$")
str_subset(fruit, "^b(.)+y$")



# Pattern matching

data <- c(
  "123 Main St", 
  "6175551234", 
  "978-356-1234", 
  "Work: 617-423-4567; Home: 508.555.3589; Cell: 555 777 3456"
)
phone <- "([2-9][0-9]{2})([- .]?)([0-9]{3})([- .])?([0-9]{4})"


# Which strings contain phone numbers?
str_detect(data, phone)

data[str_detect(data, phone)]

# or
str_subset(data, phone)

# Where in the string is the phone number located?
str_locate(data, phone)

# What are the phone numbers?
str_extract(data, phone)


str_locate_all(data, phone)

str_extract_all(data, phone)

str_extract_all(data, phone, simplify = TRUE)

# Pull out the three components of the match
# str_match() extracts capture groups formed by () from the first match

str_match(data, phone)

str_match_all(data, phone)

# replace

str_replace(data, phone, "XXX-XXX-XXXX")

str_replace_all(data, phone, "XXX-XXX-XXXX")

# Word boudaries

str_locate_all("This is cs544", "is")
str_extract_all("This is cs544", "is", simplify = TRUE)

str_locate_all("This is cs544", "\\bis\\b")
str_extract_all("This is cs544", "\\bis\\b", simplify = TRUE)

# Functions

col2hex <- function(col) {
  rgb <- col2rgb(col)
  rgb(rgb["red", ], rgb["green", ], rgb["blue", ], max = 255)
}

# Goal replace color names in a string with their hex equivalent
strings <- c("Roses are red, violets are blue", 
             "My favourite colour is green")
colors <- str_c("\\b", colors(), "\\b", collapse="|")

# This gets us the colors
str_extract_all(strings, colors)

# locations
str_locate_all(strings, colors)

#Using str_replace_all

matches <- col2hex(colors())
names(matches) <- str_c("\\b", colors(), "\\b")
str_replace_all(strings, matches)

# Counting matches

data <- c(
  "123 Main St", 
  "6175551234", 
  "978-356-1234", 
  "Work: 617-423-4567; Home: 508.555.3589; Cell: 555 777 3456"
)
phone <- "([2-9][0-9]{2})([- .]?)([0-9]{3})([- .])?([0-9]{4})"

str_count(data, phone)

x <- "Hello, how are you? I am fine, thank you."
str_length(x)

str_count(x, boundary("sentence"))
str_count(x, boundary("word"))
str_count(x, boundary("character"))

y <- c("Hello, how are you? I am fine, thank you.", "Good bye!")
str_length(y)

str_count(y, boundary("sentence"))
str_count(y, boundary("word"))
str_count(y, boundary("character"))

# Splitting of strings

x <- c("Hello, how are you? I am fine, thank you.", "Good bye!")

str_split(x, boundary("sentence"))
str_split(x, boundary("sentence"), simplify = TRUE)

str_split(x, boundary("word"))
str_split(x, boundary("word"), n = 4)

str_split(x, boundary("character"))


## Regular Expressions
# http://stringr.tidyverse.org/articles/regular-expressions.html

# Basic matches

skills <- c("Java", "Python", "R", "Scala", "Spark")

str_detect(skills, "r")

str_detect(skills, regex("r"))

str_detect(skills, regex("r", ignore_case = TRUE))

str_extract(skills, ".a.")

str_extract(skills, "(.)+a(.)+")

str_extract(skills, regex("(.)+s(.)+", ignore_case = TRUE))
str_extract(skills, regex("(.)*s(.)+", ignore_case = TRUE))

str_extract(skills, "^S")
str_extract(skills, "^S(.)+")

str_extract(skills, "a$")
str_extract(skills, "(.)+a$")

str_extract(skills, "^S(.)+a$")

str_extract(skills, "(P|R)(.)+")
str_extract(skills, "(P|R)(.)*")

str_extract(skills, "S(a|b|c)(.)+")
str_extract(skills, "S(a|b|c)?(.)+")

str_extract(skills, "S([abc])(.)+")
str_extract(skills, "S([abc])?(.)+")

years <- c("MMX", "MMXX", "MMXXX")
str_extract(years, "X{2}")
str_extract(years, "X{2,}")
str_extract(years, "X{1,2}")


