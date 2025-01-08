
#****************************************
#                                       #
#           OH - Week 6                 #
#                                       #
#****************************************

# rm(list=ls())  # clear all objects
# cat("\014") # clear the console


library(stringr)
library(tidyverse)




# The stringr package is part of the TidyVerse and written by Hadley Wickham.  
# The functions in the stringr package are really just wrapper functions for a set of functions that 
# already exist in Base R for manipulating strings and pattern matching called "regular expression" functions.  
# These functions come from Linux (and Unix before that).  
# What the stringr package adds is that it standardizes the function arguments and it simplifies 
# some tasks that may take multiple steps in Base R.

# The help file for the grep() function gives an overview of the regular expression functions from Base R: 
# grep(), grepl(), sub(), gsub(), regexpr(), gregexpr() and regexec().  
# FYI, grep() comes from "Globally search a Regular Expression and Print". 
?base::grep

# The help file for regex (which is not a function but a help file for regular expressions) will teach 
# you how to really use the power of regular expressions.  
# In particular, there are several built in features and named classes of characters that will be very, very, 
# helpful for you in your homework assignment (hint, hint, hint).
?base::regex

# I strongly advise you to read the two help files for grep and regex first, just like you would read the module.  
# Don't worry about memorizing or all the details, just get the general ideas of what is possible, 
# so that you can come back quickly and find what you need for your assignment.
# By the way, data wrangling, string manipulation, and regular expressions are ***extremely*** useful skills to learn 
# that you *WILL* use in any real world machine learning / data analysis / statistical job and are actually worth putting on 
# your resume skills section.

# The actual content of Module 6 is a pretty extensive tutorial and examples of the stringr package functions.
# Also see help files for:
?stringr
?stringi


# RStudio / TidyVerse / stringr Cheatsheets
# https://rstudio.com/resources/cheatsheets/   -->   https://posit.co/resources/cheatsheets/
# https://github.com/rstudio/cheatsheets/raw/master/strings.pdf



########################################
# Some basics of regular expressions   #
########################################

string_vec = c("John Doe", "1234 Main Street", "Anytown, CA", "95618", "555-555-1212", "Carpe diem.")
names(string_vec) = c("Name", "Street", "City, State", "Zipcode", "Phone", "Motto")
string_vec



# str_detect() in the stringr package returns a logical vector (of TRUEs and FALSEs).
# Note that *most* regular expressions are enclosed in a set of square brackets [  ] called a character set 
# because you usually want to match any single character in that list (character set) 
# so you can think of [ ] as sort of like an "or" statement, i.e. "|" the vertical bar not "l" the letter l.  
str_detect(string = string_vec, pattern = "a")      # Find strings that contain exactly "a".
str_detect(string = string_vec, pattern = "ae")     # Find strings that contain exactly "ae".
str_detect(string = string_vec, pattern = "[ae]")   # Find strings that contain an "a" or an "e", i.e. a set of "a" or "e".
str_detect(string = string_vec, pattern = "a|e")    # Find strings that contain an "a" or an "e", i.e. literally "a" OR "e". 

# Note that none of those find "Anytown, CA" because those are capital A's, not lower case a's so 
# regular expressions are case sensitive unless you first convert everything to lower case using str_to_lower()
# or you could use ignore.case option in the "old fashioned" grep(), grepl(), regex(), etc.
str_detect(string = string_vec, pattern = "[aAeE]")   # Find strings that contain an "a" or "A" or "e" or "E".
str_detect(string = str_to_lower(string_vec), pattern = "[ae]")   # Find strings that contain an "a" or "A" or "e" or "E".
grepl(x = string_vec, pattern = "[ae]", ignore.case = TRUE)   # Find strings that contain an "a" or "A" or "e" or "E".

# These are really the same as grepl() in Base R, but 
grepl(pattern = "a", x = string_vec)
grepl(pattern = "ae", x = string_vec)
grepl(pattern = "[ae]", x = string_vec)
grepl(pattern = "[aAeE]", x = string_vec)
grepl(pattern = "[ae]", x = string_vec, ignore.case = TRUE)

# Now that you have a vector of logical TRUE and FALSE from either str_detect() or grepl(),
# you can use subset operator square brackets [  ] to get the actual strings that match.  
string_vec[ str_detect(string = string_vec, pattern = "[ae]") ]

# OR, the stringr package function str_subset() simplifies this task into one step, i.e. 
str_subset(string = string_vec, pattern = "[ae]")

# Note this is equivalent to grep() with value = TRUE.
grep(pattern = "[ae]", x = string_vec, value = TRUE)
string_vec[ grep(pattern = "[ae]", x = string_vec) ]




#-----------------------------------------------------------------------------
#   Part 1a: Detect and show all the words that have a punctuation symbol.   #
#-----------------------------------------------------------------------------
# There are named classes of characters for the set of punctuation characters.  Find it in ?base::regex.
# You can then either directly use the subset operator square brackets [ ] or use one of the appropriate
# functions from the stringr package that will subset for you (you can find that in the Module or the
# example code on the Discussion Board that goes with the Module or look at the introduction to the stringr
# package ??stringr::stringr).

# Here is a different example.  Supposed you wanted to detect all the strings that contain a number,
# i.e. a digit 0,1,2,3,4,5,6,7,8,9.
# You could do this by brute force.
str_detect(string = string_vec, pattern = "[0123456789]")
# OR
grepl(pattern = "[0123456789]", x = string_vec)

# More elegant to use the named class of characters [:digit:].
# Note that *most* regular expressions are enclosed in a set of square brackets because you usually want 
# to match any single character in that list so you can think of [ ] as sort of like an "or" statement.  
# Note also that the named class of characters are also enclosed in a set of square brackets (and a set 
# of colons) sooooo, you really need double square brackets if this is not confusing enough.
str_detect(string = string_vec, pattern = "[[:digit:]]")        # This is "most" correct
str_detect(string = string_vec, pattern = "[:digit:]")          # This works in stringr functions
# OR 
grepl(pattern = "[[:digit:]]", x = string_vec)                  # This is correct
grepl(pattern = "[:digit:]", x = string_vec)                    # This does *not* give the correct result in grepl

string_vec[ grepl(pattern = "[[:digit:]]", x = string_vec) ]    # This is correct
string_vec[ grepl(pattern = "[:digit:]", x = string_vec) ]      # This does *not* give the correct result in grepl


#--------------------------------------------------------------------------
#   1f: similar example, find all the strings that start with a number.   #
#--------------------------------------------------------------------------
# The caret "^" is a metacharacter to indicate a string that *starts* with ...
str_subset(string = string_vec, pattern = "^[[:digit:]]")



#------------------------------------------------------------------------
#   1g: similar example, find all the strings that end with a number.   #
#------------------------------------------------------------------------
# The dollar sign "$" is a metacharacter to indicate a string that *ends* with ...
str_subset(string = string_vec, pattern = "[[:digit:]]$")



#-----------------------------------------------------------------------------------------
#   1h: similar example, find a string that begins with a number and ends with a letter  #
#-----------------------------------------------------------------------------------------
# Wildcard is ".", i.e. the period . matches any single character.
# The "*" asterisk means zero or more times repeated.
# The "+" plus sign means one or more times repeated.
# Note that this does not work since the starting digit must be followed exactly by the ending letter
str_subset(string = string_vec, pattern = "^[[:digit:]][[:alpha:]]$") 

# Note that this gets the correct answer but by dumb luck since it is actually picking up the "4 M" in "1234 Main Street"
str_subset(string = string_vec, pattern = "[[:digit:]].[[:alpha:]]")

# Note that even this one is not quite right either since starts with a number, has a wildcard, ends with a letter, BUT
# is exactly 3 characters long (since start, wildcard, end)
str_subset(string = string_vec, pattern = "^[[:digit:]].[[:alpha:]]$")

# put all together to get the correct answer for the correct reason
# i.e. start with a digit, there might be one or more printable characters of any kind in the middle, and ends with a number
str_subset(string = string_vec, pattern = "^[[:digit:]].+[[:alpha:]]$") 
str_subset(string = string_vec, pattern = "^[[:digit:]].*[[:alpha:]]$") 

str_subset(string = "8b", pattern = "^[[:digit:]].*[[:alpha:]]$") # * is 0 or more times
str_subset(string = "8b", pattern = "^[[:digit:]].+[[:alpha:]]$") # + is 1 or more times


# Turns out that [[ ]] is the same as ([ ])
str_subset(string = string_vec, pattern = "^([:digit:]).+([:alpha:])$") 


# It's complicated - check your work.  The HW question is not this complicated at all ;)




#===========================================
#   Part 2 Data Wrangling with tidyverse   # 
#===========================================



library(nycflights13)
flights

# https://rstudio.com/resources/cheatsheets/
# https://github.com/rstudio/cheatsheets/raw/master/data-transformation.pdf


str(flights)

#--------------------------------------------------------------------------------------------------------------
#   2b: similar example using the flights data find the minimum distance flight for each carrier (from NYC)   #
#--------------------------------------------------------------------------------------------------------------
# Notice that Hawaiian Airlines (HA) appears to only fly back to Hawaii from NYC, not stopping anywhere else.
min_dist <- 
  flights %>%
    group_by(carrier) %>%
      summarise(min_dist = min(distance))
min_dist


flights %>%
  group_by(carrier) %>%
  summarise(min_dist = min(distance)) %>%
  arrange(desc(min_dist)) %>%
  slice_tail(n = 1)


# OR notice the difference in syntax (still tidyverse but different way)
min_dist <- 
  summarise(group_by(.data = flights, carrier), 
            min_dist = min(distance))
min_dist


# Assignment requires you to use tidyverse, but since we worked through similar tasks in previous office hours, 
# let's recap here to demonstrate that there are many, many ways to do this
# in Base R and get the same results, just note the different syntax and the different formats of the results.
tapply(X = flights$distance, INDEX = flights$carrier, FUN = min)
aggregate(x = flights$distance, by = list(flights$carrier), FUN = min)
by(data = flights$distance, INDICES = flights$carrier, FUN = min)

# Two steps, split the data first, and then either sapply or lapply in a second step
flights.split = split(x = flights$distance, f = flights$carrier)
sapply(X = flights.split, FUN = min)
lapply(X = flights.split, FUN = min)


#-------------------------
#   2c: similar to #2b   #
#-------------------------

#---------------------------------------------------------------------------
#   2d: use the filter() function and store the result.                    #   
#       Similar example is filter the flights data to Hawaiian Airlines.   #
#---------------------------------------------------------------------------

HA_flights <- flights %>%
                filter(carrier == "HA")
HA_flights

# Tidyverse, but different syntax
HA_flights <- filter(.data = flights, carrier == "HA")
HA_flights


# Separate notes
# filter() subsets rows
# select() subsets columns
HA_flights %>%
  select(carrier, origin, dest, distance)

#---------------------------------
#   2e: similar to #2a and #2b   #
#---------------------------------








# Office hours scratchwork



